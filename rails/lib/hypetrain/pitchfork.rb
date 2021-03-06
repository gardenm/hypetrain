require 'open-uri'
require 'rss'

require_relative 'reviewbase'
require_relative 'database'

module HypeTrain

  # Handles reviews from pitchfork.com's Best New Music
  module Pitchfork
    
    CRITIC_ID = 'pitchfork'
    LINK = 'http://pitchfork.com/'
    
    # Represents rewviews from Best New Music
    class Site
      include HypeTrain::Database
      
      def link
        LINK
      end
      
      def initialize(use_test_data)      
        if use_test_data
          @uri = "test/data/pitchfork/rss/PitchforkBestNewAlbums"
        else
          @uri = 'http://feeds2.feedburner.com/PitchforkBestNewAlbums'
        end

        @reviews = []
      end

      # Parse the RSS feed and store the resulting reviews.
      def load
        open(@uri) do |rss|
          feed = RSS::Parser.parse(rss)
          feed.items.each do |item|
            artist, album = item.title.split(':')

            @reviews << ReviewBase.new(CRITIC_ID, artist, album, item.link, item.description, item.pubDate)
          end
        end
      end

      # Get all reviews (after loading the RSS feed, if that hasn't been done already)
      def reviews
        load if @reviews.empty?
        @reviews
      end
    end
  end

end
