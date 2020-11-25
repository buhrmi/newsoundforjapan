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

  def self.from_twitter auth_hash, current_user

    user = current_user || User.where(twitter_id: auth_hash[:uid]).first_or_create
    
    if auth_hash['info']['image'] && !user.profile_image.attached?
      image = open auth_hash['info']['image']
      user.profile_image.attach(io: image, filename: "avatar.jpg")
    end
    
    user.name ||= auth_hash['info']['nickname']
    user.twitter_id = auth_hash[:uid]
    user.twitter_name = auth_hash['info']['nickname']
    user.email = auth_hash['info']['email']
    user.description ||= auth_hash['info']['description']
    user.display_name ||= auth_hash['info']['name']
    user.save
    user
  end

  def self.from_twitch auth_hash
    
    user = User.where(twitch_id: auth_hash[:uid]).first_or_create
    
    if auth_hash['info']['image']
      image = open auth_hash['info']['image']
      user.profile_image.attach(io: image, filename: "avatar.jpg")
    end
    
    user.name ||= auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.display_name ||= auth_hash['info']['nickname']
    user.description ||= auth_hash['info']['description']
    user.save
    user
  end



  def sync_gigs_with_ics!
    return unless ics_url
    ics = open ics_url
    
    cals = Icalendar::Calendar.parse(ics)
    cal = cals.first

    # We keep all future externally imported gigs in a list, so we can delete them if they
    # are no longer on the calendar
    maybe_deleted_external_ids = gigs.where('start_at > ?', Time.now).pluck(:external_id).reject { |id| id.nil? || id.empty? }    
    
    for cal_event in cal.events
      start_at = cal_event.dtstart.to_time
      next if start_at < Time.now
      gig = Gig.where(external_id: cal_event.uid.to_s).first_or_initialize
      place = Place.from_event_location(cal_event.location)
      gig.event ||=  Event.where(place: place).where('start_at > ? and start_at < ?', start_at - 12.hours, start_at + 12.hours).first_or_create(start_at: start_at, name: cal_event.summary)
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
      Rails.application.routes.url_helpers.rails_representation_url profile_image.variant(resize: '400x400'), only_path: true
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
      soundcloud_playlist_id: soundcloud_playlist_id,
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
