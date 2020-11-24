class GigsController < ApplicationController
  def create
    return inertia_redirect_to '/auth/twitter' unless current_user
    gig = Gig.create(create_params.merge talent: current_user)
    redirect_to event_url(gig.event)
  end
  
  def index
    upcoming = Gig.where('start_at > ?', Time.now).order('start_at ASC')
    past = Gig.where('start_at < ?', Time.now).order('start_at DESC')

    render inertia: 'gigs/index', props: {
      upcoming: upcoming.map(&:to_prop),
      past: past.map(&:to_prop)
    }
  end

  def create_params
    params.require(:gig).permit(:event_id, :start_at)
  end
end
