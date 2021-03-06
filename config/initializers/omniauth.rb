Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitch, ENV["TWITCH_CLIENT_ID"], ENV["TWITCH_CLIENT_SECRET"]
  provider :twitter, ENV["TWITTER_CLIENT"], ENV["TWITTER_SECRET"]
  
  scopes = [
    # we need the profile scope in order to login
    "https://www.googleapis.com/auth/userinfo.profile",
    "https://www.googleapis.com/auth/userinfo.email",
    # this and other scopes could be added, but match them up with the
    # features you requested in your API Console
    # "https://www.googleapis.com/auth/calendar.events",
    # "https://www.googleapis.com/auth/calendar.readonly"
  ]
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: scopes.join(" ")
  }
end