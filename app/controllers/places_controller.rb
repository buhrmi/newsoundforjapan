class PlacesController < ApplicationController
  def show
    place = Place.find(params[:id])
    gigs = place.gigs.on_that_day(Time.parse(params[:start_at]))
    render inertia: 'places/show', props: {
      place: place.to_prop,
      start_at: params[:start_at],
      gigs: gigs.map(&:to_prop)
    }
  end
end
