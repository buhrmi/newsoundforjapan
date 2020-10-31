class Gig < ApplicationRecord
  belongs_to :talent, class_name: 'User'

  belongs_to :place, optional: true
  
  def self.create_from_calendar_event! calendar_event
    gig = Gig.where(external_id: calendar_event.id).first_or_create(
      
    )
  end
end
