class Event < ApplicationRecord
  belongs_to :place
  has_many :gigs
  has_many :talents, through: :gigs

  scope :upcoming, lambda { where 'start_at > ?', Time.now}
  scope :past, lambda { where 'start_at < ?', Time.now}

  def description
    Time.zone ='Asia/Tokyo'
    I18n.l(start_at.in_time_zone, format: :short) + ": " +  talents.first(5).pluck(:display_name).join(', ') + ' and more @ ' + place.name
  end

  def display_name
    "CALL FOR DJs | " + name
  end

  def to_prop include_gigs = false
    prop = {
      id: id,
      start_at: start_at,
      name: name,
      place: place.to_prop
    }
    if include_gigs
      prop[:gigs] = gigs.map(&:to_prop)
    end
    prop
  end
end
