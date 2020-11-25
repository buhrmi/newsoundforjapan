class Event < ApplicationRecord
  belongs_to :place
  has_many :gigs
  has_many :talents, through: :gigs

  def description
    I18n.l(start_at, format: :short) + ": " +  talents.first(5).pluck(:display_name).join(', ') + ' and more @ ' + place.name
  end

  def display_name
    "CALL FOR DJs | " + name
  end

  def to_prop
    {
      id: id,
      start_at: start_at,
      name: name,
      place: place.to_prop
    }
  end
end
