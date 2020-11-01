class GigsController < ApplicationController
  def create
    return redirect_to '/auth/twitter' unless current_user
    gigs_on_this_day = current_user.gigs.on_that_day(Time.parse(create_params[:start_at]))
    if gigs_on_this_day.empty?
      gig = Gig.create(create_params.merge talent: current_user)
      redirect_to place_url(gig.place, start_at: gig.start_at)
    else
      flash[:error] = 'You are already on the lineup'
      redirect_back fallback_location: root_url
    end
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
    params.require(:gig).permit(:place_id, :start_at)
  end
end
