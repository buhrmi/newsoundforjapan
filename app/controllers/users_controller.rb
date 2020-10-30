require 'google/apis/calendar_v3'
require 'google/api_client/client_secrets.rb'

class UsersController < ApplicationController
  def show
    if params[:name]
      @title_object = user = User.find_by_name!(params[:name])
    elsif params[:id]
      @title_object = user = User.find(params[:id])  
    else
      @title_object = user = current_user
    end

    if user.google_calendar_id
      service = user.google_calendar_service
      response = service.list_events(user.google_calendar_id,
                                    max_results:   10,
                                    single_events: true,
                                    order_by:      "startTime",
                                    time_min:      DateTime.now.rfc3339)
      gigs = response.items
    else
      gigs = []
    end
    render inertia: 'users/show', props: {
      user: user.to_prop,
      gigs: gigs
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