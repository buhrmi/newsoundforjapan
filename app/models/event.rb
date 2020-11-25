class Event < ApplicationRecord
  belongs_to :place
  has_many :gigs
  has_many :talents, through: :gigs

  def description
    talents.first(5).pluck(:display_name).join(', ') + ' @ ' + place.name
  end

  def display_name
    "CALL FOR DJs | " + I18n.l(start_at, format: :short) + ": " + name
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
