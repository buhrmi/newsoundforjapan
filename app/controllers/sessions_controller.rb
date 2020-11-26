class SessionsController < ApplicationController
  def create
    if auth_hash.provider == 'twitter'
      user = User.from_twitter(auth_hash, current_user)
    else
      user = User.from_twitch(auth_hash)
    end
    cookies.signed[:user_id] = user.id
    
    ahoy.authenticate(user)  
    redirect_to current_user
    
  end
  
  def destroy
    cookies.signed[:user_id] = nil
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end