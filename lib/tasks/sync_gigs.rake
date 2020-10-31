# frozen_string_literal: true

# This simple bot responds to every "Ping!" message with a "Pong!"

desc 'Sync all gigs with the users linked .ics file'
task sync_gigs: :environment do
  User.all.map &:sync_gigs_with_ics!
end
