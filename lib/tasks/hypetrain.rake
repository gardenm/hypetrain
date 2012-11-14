namespace :hypetrain do
  desc "Pull the latest reviews from metacritic/music's RSS feed"
  task :metacritic => :environment do
    require 'metacritic'
    
    m = HypeTrain::Metacritic::Site.new
    m.reviews.each do |r|
      puts r
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