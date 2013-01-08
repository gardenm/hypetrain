module HypeTrain
  module Database
    
    def save_reviews
      # For each review, create all the necessary model instances.
      self.reviews.each do |r|
        critic = Critic.find_or_initialize_by_name(r.source) do |c|
          c.link = self.link
          c.save!
        end

        artist = Artist.find_or_initialize_by_name(r.artist) do |a|
          a.save!
        end

        album = Album.find_or_initialize_by_title_and_artist_id(r.album, artist.id) do |a|
          a.save!
          a.load_rdio_info!
        end

        reviews = album.reviews.find_or_initialize_by_critic_id(critic.id) do |ar|
          ar.description = r.description.strip
          ar.link = r.link

          ar.save!
        end
      end
    end

  end
end
