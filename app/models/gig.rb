class Gig < ApplicationRecord
  belongs_to :talent, class_name: 'User'

  belongs_to :place, optional: true
  scope :on_that_day, lambda { |time| where('start_at > ? and start_at < ?', time - 12.hours, time + 12.hours) }  
  def self.create_from_calendar_event! calendar_event
    gig = Gig.where(external_id: calendar_event.id).first_or_create(
      
    )
  end

  def to_prop
    {
      id: id,
      start_at: start_at,
      summary: summary,
      talent: talent.to_prop,
      place: place.to_prop
    }
  end
end
