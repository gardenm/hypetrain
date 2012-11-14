namespace :hypetrain do
  desc "Pull the latest reviews from metacritic/music's RSS feed"
  task :metacritic => :environment do
    require 'metacritic'
    
    # TODO: Probably shouldn't have sooo much code in a rake file
    m = HypeTrain::Metacritic::Site.new
    m.reviews.each do |r|
      
      critics = Critic.where :name => r.source
      if critics.empty?
        critic = Critic.new :name => r.source
      else
        critic = critics.first
      end
      
      artists = Artist.where :name => r.artist
      if artists.empty?
        artist = Artist.new(:name => r.artist)
        artist.save
      else
        artist = artists.first
        # TODO: if artists.length != 1 throw
      end
      
      albums = Album.where(:title => r.album).select {|a| a.artist == artist}
      
      if albums.empty?
        album = Album.new(:title => r.album)
        album.artist = artist
        album.save
      else
        album = albums.first
      end
      
      reviews = album.reviews.select {|a| a.critic == critic}
      
      # Now create the review...
      if reviews.empty?
        review = Review.new :description => r.description.strip, :link => r.link
        review.critic = critic
        review.album = album
        # TODO: Just get rid of this column...
        review.source = critic.name
        
        review.save
      end
    end
  end
  
  desc "Pull the latest reviews from pitchfork.com's Best New Music (Albums)"
  task :pitchfork => :environment do
    require 'pitchfork'
    
    p = HypeTrain::Pitchfork::Site.new
    p.reviews.each do |r|
      puts r
    end
  end
end