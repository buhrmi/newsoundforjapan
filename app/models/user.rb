require 'open-uri'
require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class User < ApplicationRecord
  has_one_attached :profile_image
  has_many :gigs, foreign_key: 'talent_id'

  after_save_commit :broadcast_changes

  def broadcast_changes
    # UsersChannel.broadcast_to(self, update: to_prop(true) )
  end
  
  def self.from_google auth_hash
    User.where(email: auth_hash[:info][:email]).first_or_create(name: auth_hash[:info][:first_name]).tap do |u|
      u.google_access_token = auth_hash[:credentials][:token]
      u.google_refresh_token = auth_hash[:credentials][:refresh_token]
      u.google_expires_at = Time.at auth_hash[:credentials][:expires_at]
      if url = auth_hash[:info][:image]
        image = open url
        u.profile_image.attach(io: image, filename: url.split('/').last)
      end
      u.save
    end
  end

  def self.from_twitch auth_hash
    
    user = User.where(twitch_id: auth_hash[:uid]).first_or_create
    
    if auth_hash['info']['image']
      image = open auth_hash['info']['image']
      user.profile_image.attach(io: image, filename: "avatar.jpg")
    end
    
    user.update!(
      name: auth_hash['info']['name'],
      email: auth_hash['info']['email'],
      display_name: auth_hash['info']['nickname'],
      description: auth_hash['info']['description']
    )
    user
  end



  def sync_gigs_with_ics!
    return unless ics_url
    ics = open ics_url
    
    cals = Icalendar::Calendar.parse(ics)
    cal = cals.first

    maybe_deleted_external_ids = gigs.pluck :external_id    
    
    for cal_event in cal.events
      start_at = cal_event.dtstart.to_time
      next if start_at < Time.now
      gig = Gig.where(external_id: cal_event.uid.to_s).first_or_create
      gig.place = Place.from_event_location(cal_event.location)
      gig.summary =  cal_event.summary
      gig.talent_id = self.id
      gig.start_at = start_at
      gig.end_at = cal_event.dtend.to_time
      gig.save!
      maybe_deleted_external_ids.delete cal_event.uid.to_s
    end
    Gig.where(external_id: maybe_deleted_external_ids).delete_all
  end

  def profile_image_thumbnail
    if profile_image.attached?
      Rails.application.routes.url_helpers.rails_representation_url profile_image.variant(resize: '100x100'), only_path: true
    end
  end

  # def google_calendar_service
  #   secrets = Google::APIClient::ClientSecrets.new(
  #     { "web" => 
  #       { "access_token" => google_access_token, 
  #         "refresh_token" => google_refresh_token, 
  #         "client_id" => ENV.fetch('GOOGLE_CLIENT_ID'), 
  #         "client_secret" => ENV.fetch('GOOGLE_CLIENT_SECRET')
  #       }
  #     }
  #   )
  #   service = Google::Apis::CalendarV3::CalendarService.new
  #   service.authorization = secrets.to_authorization
  #   service.authorization.refresh!
  #   service
  # end

  def to_prop(incl_private=false)
  
    prop = {
      id: id,
      name: name,
      display_name: display_name,
      description: description,
      profile_image: profile_image_thumbnail,
      url: Rails.application.routes.url_helpers.user_url(self, only_path: true)
    }
    if incl_private
      prop[:email] = email
      prop[:ics_url] = ics_url
    end
    prop
  end

end
