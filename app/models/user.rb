require 'open-uri'

class User < ApplicationRecord
  has_one_attached :profile_image

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

  def profile_image_thumbnail
    if profile_image.attached?
      Rails.application.routes.url_helpers.rails_representation_url profile_image.variant(resize: '100x100'), only_path: true
    end
  end

  def google_calendar_service
    secrets = Google::APIClient::ClientSecrets.new(
      { "web" => 
        { "access_token" => google_access_token, 
          "refresh_token" => google_refresh_token, 
          "client_id" => ENV.fetch('GOOGLE_CLIENT_ID'), 
          "client_secret" => ENV.fetch('GOOGLE_CLIENT_SECRET')
        }
      }
    )
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = secrets.to_authorization
    service.authorization.refresh!
    service
  end

  def to_prop(incl_private=false)
  
    prop = {
      id: id,
      name: name,
      profile_image: profile_image_thumbnail,
      url: Rails.application.routes.url_helpers.user_url(self, only_path: true)
    }
    if incl_private
      prop[:email] = email
      prop[:calendars] = calendars
      prop[:google_calendar_id] = google_calendar_id
    end
    prop
  end

  def calendars
    google_calendar_service.list_calendar_lists.items
  end


end
