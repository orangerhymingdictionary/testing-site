# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mystore_session',
  :secret      => '5f886d09000d4939dcef651676eee4c6340c5831fe1f700a4e7bc3062efec62e14dbd3697bc9b2806b62e79f8ed79b176163a3f7fc4ac651387eae8b6fbf20dd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store