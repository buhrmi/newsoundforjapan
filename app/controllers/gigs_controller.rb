class GigsController < ApplicationController
  def create
    return redirect_to '/auth/twitter' unless current_user
    Gig.create(talent: current_user, place_id: params[:place_id], start_at: params[:start_at])
  end
  
  def index
    upcoming = Gig.where('start_at > ?', Time.now).order('start_at ASC')
    past = Gig.where('start_at < ?', Time.now).order('start_at DESC')

    render inertia: 'gigs/index', props: {
      upcoming: upcoming.map(&:to_prop),
      past: past.map(&:to_prop)
    }
  end
end
