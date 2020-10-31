
class Place < ApplicationRecord
  has_one_attached :profile_image
  has_many :gigs
  @google_client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
      
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
