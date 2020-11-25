class Gig < ApplicationRecord
  belongs_to :talent, class_name: 'User'
  belongs_to :event

  validates_uniqueness_of :talent, scope: 'event_id'

  before_save :ensure_start_time_is_set

  scope :upcoming, lambda { where 'start_at > ?', Time.now}

  def self.create_from_calendar_event! calendar_event
    gig = Gig.where(external_id: calendar_event.id).first_or_create(
      
    )
  end


  def ensure_start_time_is_set
    self.start_at ||= event.start_at
  end

  def to_prop
    {
      id: id,
      start_at: start_at,
      event: event.to_prop,
      talent: talent.to_prop    }
  end
end
