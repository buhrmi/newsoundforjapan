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
end
