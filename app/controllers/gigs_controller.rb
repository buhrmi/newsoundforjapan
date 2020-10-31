class GigsController < ApplicationController
  def index
    upcoming = Gig.where('start_at > ?', Time.now)
    past = Gig.where('start_at < ?', Time.now)

    render inertia: 'gigs/index', props: {
      upcoming: upcoming,
      past: past
    }
  end
end
