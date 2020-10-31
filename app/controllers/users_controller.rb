class UsersController < ApplicationController
  def show
    if params[:name]
      @title_object = user = User.find_by_name!(params[:name])
    elsif params[:id]
      @title_object = user = User.find(params[:id])  
    else
      @title_object = user = current_user
    end
    user.fetch_gigs_from_ics!
    
    render inertia: 'users/show', props: {
      user: user.to_prop,
      gigs: user.gigs
    }
  end

  def update
    user = User.find(params[:id])
    head 403 unless user == current_user
    user.google_calendar_id = params[:user][:google_calendar_id]
    user.save
    redirect_to user
  end

  def new
    return redirect_to current_user if current_user
    render inertia: 'users/new', props: {
    }
  end

end