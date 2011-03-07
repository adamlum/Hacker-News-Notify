# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_hnnotify_session',
  :secret      => '7af79712e692b3f19f4caeae1d85814f471bbb5029ce9796c2f9e14d4155ed2b931cdd5a500f9a536b9c447a12214d2f29ce6e65644b49804664ab7964e18711'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
