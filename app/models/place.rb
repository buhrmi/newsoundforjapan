
class Place < ApplicationRecord
  has_one_attached :profile_image
  has_many :gigs
  @google_client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
      
  def profile_image_thumbnail
    if profile_image.attached?
      Rails.application.routes.url_helpers.rails_representation_url profile_image.variant(resize: '800x800'), only_path: true
    end
  end

  def to_prop(incl_private=false)
    {
      id: id,
      name: name,
      profile_image: profile_image_thumbnail,
      url: Rails.application.routes.url_helpers.place_url(self, only_path: true)
    }
  end


  def self.from_event_location(location)
    return nil unless location.to_s.present?
    place = Place.where(address: location.to_s).first
    if !place
      spots = @google_client.spots_by_query(location.to_s)
      spot = spots.first
      place = Place.create(google_place_id: spot.place_id, address: location.to_s, name: spot.name)
      
      if photo = spot.photos[0]
        url = photo.fetch_url(800) 
        image = open url
        place.profile_image.attach(io: image, filename: "avatar.jpg")
      end
    end
    return place
    
  end
end
