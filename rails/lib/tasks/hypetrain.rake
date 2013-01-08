namespace :hypetrain do
  desc "Pull the latest reviews from metacritic/music's RSS feed"
  task :metacritic, [:test] => :environment do |t, args|
    require 'metacritic'
    args.with_defaults(:test => false)

    m = HypeTrain::Metacritic::Site.new(args[:test])
    m.save_reviews
  end
  
  desc "Pull the latest reviews from pitchfork.com's Best New Music (Albums)"
  task :pitchfork, [:test] => :environment do |t, args|
    require 'pitchfork'
    args.with_defaults(:test => false)
    
    p = HypeTrain::Pitchfork::Site.new(args[:test])
    p.save_reviews
  end

  desc "Load Rdio info for each of the albums in the database"
  task :rdio, [:test] => :environment do |t, args|
    Album.where(:link => nil).each {|a| a.load_rdio_info!}
  end
end
