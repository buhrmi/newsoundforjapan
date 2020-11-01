class PlacesController < ApplicationController
  def show
    place = Place.find(params[:id])
    gigs = place.gigs.on_that_day(Time.parse(params[:start_at]))

    if current_user
      current_user_gig = current_user.gigs.where(place_id: params[:id]).on_that_day(Time.parse(params[:start_at])).first
    end
    
    render inertia: 'places/show', props: {
      place: place.to_prop,
      current_user_gig: current_user_gig.try(:to_prop),
      start_at: params[:start_at],
      gigs: gigs.map(&:to_prop)
    }
  end
end
