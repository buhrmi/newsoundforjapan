class PlacesController < ApplicationController
  def show
    place = Place.find(params[:id])
    gigs = place.gigs.on_that_day(params[:start_at])
    render inertia: 'places/show', props: {
      place: place.to_prop,
      gigs: gigs.map(&:to_prop)
    }
  end
end
