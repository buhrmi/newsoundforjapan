class GigsController < ApplicationController
  def index
    upcoming = Gig.where('start_at > ?', Time.now)
    past = Gig.where('start_at < ?', Time.now)

    render inertia: 'gigs/index', props: {
      upcoming: upcoming.map(&:to_prop),
      past: past.map(&:to_prop)
    }
  end
end
