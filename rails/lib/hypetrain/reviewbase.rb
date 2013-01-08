module HypeTrain
  
  # Base class for all music reviews.
  class ReviewBase
    
    attr_reader :artist, :album, :source, :link, :description, :pub_date
    
    # @param [Symbol] source Where the review came from (e.g. pitchfork, ...)
    # @param [String] artist Who recorded the album
    # @param [String] link Locates the full review online
    # @param [String] description Text of the review
    # @param [Date] pub_date When the review was published
    def initialize(source, artist, album, link, description, pub_date)
      @source = source
      @artist = artist.strip
      @album = album.strip
      @link = link.strip
      @description = description
      @pub_date = pub_date
    end

    def to_s
      @artist + ' - ' + @album
    end
  end

end