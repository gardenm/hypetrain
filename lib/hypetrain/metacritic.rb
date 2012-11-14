require 'open-uri'
require 'rss'

require_relative 'reviewbase'

module HypeTrain
 
  # Handles reviews from metacritic.com
  module Metacritic
        
    # Represents the metascore ratings used on metacritic.
    class Metascore
      
      attr_reader :average
      attr_reader :description

      # @param [Float] avgerage The average rating for the item from all critics aggregated by metacritic.
      # @param [String] description The textual description assigned to this average rating by metacritic.
      def initialize(average, description)        
        @average = average
        @description = description
      end

      def to_s
        "#{@average} (#{@description})"
      end
    end

    # A music review from metacritic.com
    class Review < ReviewBase
      
      attr_reader :metascore
      
      # (see ReviewBase#initialize)
      def initialize(source, artist, album, link, description, pub_date)
        super(source, artist, album, link, description, pub_date)

        # Switch the link to point to a local file (only for testing)
        @link.sub!('http://www.metacritic.com/music', Site::review_root_uri)

        # Get the metascore
        full_review = Nokogiri::HTML(File.open(@link, 'rb').read())

        metascore_html = full_review.css('div.metascore_summary')
        avg = metascore_html.css('span.score_value').text.strip
        desc = metascore_html.css('span.desc').text.strip

        @metascore = Metascore.new(avg, desc)
      end

      def to_s
        super + ': ' + @metascore.to_s
      end
    end

    # Represents metacritic.com/music
    class Site
      
      def self.review_root_uri
        @@review_root_uri
      end
      
      def initialize
        @@id = 'metacritic'

        @rss_uri = "#{Rails.root}/test/data/metacritic/rss/music"
        @@review_root_uri = "#{Rails.root}/test/data/metacritic/music"
        
        #@rss_uri = 'http://www.metacritic.com/rss/music'

        @loaded = false
        @reviews = []
      end

      # Loads all reviews in the RSS feed.
      def load        
        open(@rss_uri) do |rss|
          feed = RSS::Parser.parse(rss, do_validate=false)
          feed.items.each do |item|
            album, artist = item.title.split('by')
            puts 'artist: ' + artist

            @reviews << Review.new(@@id, artist, album, item.link, item.description, item.pubDate)
          end
        end
      end

      # Get all reviews (after parsing the RSS feed, if that hasn't been done already)
      def reviews
        load unless @loaded
        @reviews
      end
    end
  end

end