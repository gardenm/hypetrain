require 'rdio/rdio'

class Album < ActiveRecord::Base
  belongs_to :artist
  has_many :reviews
  attr_accessible :release_date, :title, :link, :icon, :player

  def load_rdio_info!
    return if link != nil

    # Search Rdio by album name.
    parms = {'query' => title, 'types' => 'Album'}

    rdio = Rdio.new([ENV['RDIO_API_KEY'], ENV['RDIO_SECRET']])

    albums_found = rdio.call('search', parms)['result']['results'].select {|found| found['artist'] == artist.name}

    # if more than one album is found, log a warning because that's unexpected
    if albums_found.length > 1
      Rails.logger.warn "Rdio has more than one album for #{title} by #{artist.name}"
    elsif not albums_found.empty?
      info = albums_found.first

      update_attributes(:icon => info['icon'], :link => info['shortUrl'], :player => info['embedUrl'])
    end
  end
end
