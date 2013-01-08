hypetrain
=========

Aggregator for music reviews, with links to Rdio for more info, streaming, etc.

Includes some rake tasks (lib/tasks/hypetrain.rake) for pulling review info from Metacritic and Pitchfork, and for 
linking those reviewed albums to Rdio.

The hypetrain:rdio rake task assumes you have Rdio hooked up.  To enable that add a file 
config/initializers/01_rdio_environment_vars.rb, and in it set values for ENV['RDIO_API_KEY'] and ENV['RDIO_SECRET'] using
your Rdio developer info.

TODO: Lots...
- Spruce up (...create, really) the UI
- More tests
- Allow a user to log in and link to their Rdio account
- Maybe some recommendation stuff
