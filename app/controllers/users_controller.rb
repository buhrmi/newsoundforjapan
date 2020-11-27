class UsersController < ApplicationController
  def show
    if params[:twitter_name]
      @title_object = user = User.from_twitter_name(params[:twitter_name])
    elsif params[:name]
      @title_object = user = User.find_by_name!(params[:name])
    elsif params[:id]
      @title_object = user = User.find(params[:id])  
    else
      @title_object = user = current_user
    end

    render inertia: 'users/show', props: {
      user: user.to_prop,
      gigs: user.gigs.upcoming.map(&:to_prop)
    }
  end

  def update
    user = User.find(params[:id])
    head 403 unless user == current_user
    user.ics_url = params[:user][:ics_url]
    user.save
    redirect_to user
  end

  def new
    return redirect_to current_user if current_user
    render inertia: 'users/new', props: {
    }
  end

end