require 'open-uri'
require 'rss'

require_relative 'reviewbase'
require_relative 'database'

module HypeTrain

  # Handles reviews from pitchfork.com's Best New Music
  module Pitchfork
    
    # Represents rewviews from Best New Music
    class Site
      include HypeTrain::Database
      
      def initialize
        @id = 'pitchfork'

        #@uri = 'http://feeds2.feedburner.com/PitchforkBestNewAlbums'
        @uri = "#{Rails.root}/test/data/pitchfork/rss/PitchforkBestNewAlbums"

        @loaded = false
        @reviews = []
      end

      # Parse the RSS feed and store the resulting reviews.
      def load
        open(@uri) do |rss|
          feed = RSS::Parser.parse(rss)
          feed.items.each do |item|
            artist, album = item.title.split(':')

            @reviews << ReviewBase.new(@id, artist, album, item.link, item.description, item.pubDate)
          end
        end
      end

      # Get all reviews (after loading the RSS feed, if that hasn't been done already)
      def reviews
        load unless @loaded
        @reviews
      end
    end
  end

end