class EventsController < ApplicationController
  def show
    @title_object = event = Event.find(params[:id])
    current_user_gig = event.gigs.where(talent: current_user).first
    render inertia: 'events/show', props: {
      event: event.to_prop,
      gigs: event.gigs.map(&:to_prop),
      current_user_gig: current_user_gig
    }
  end

  def index
    upcoming = Event.upcoming.order('start_at ASC')
    past = Event.past.order('start_at DESC')

    render inertia: 'events/index', props: {
      upcoming: upcoming.map { |e| e.to_prop(true) },
      past: past.map { |e| e.to_prop(true) }
    }
  end
end
