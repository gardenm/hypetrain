require 'test_helper'
require 'metacritic'

class MetacriticTest < ActiveSupport::TestCase
  test "Review is created correctly" do
    r = HypeTrain::Metacritic::Review.new('Leona Lewis', 'Glassheart', "http://www.metacritic.com/music/glassheart/leona-lewis", 'Descr', '')

    assert_equal 'Leona Lewis', r.artist
    assert_equal 'Glassheart', r.album
    assert_equal 'Descr', r.description
    assert_equal 'http://www.metacritic.com/music/glassheart/leona-lewis', r.link
  end

  test "Site is created correctly" do
    s = HypeTrain::Metacritic::Site.new(true)

    assert_equal s.link, 'http://www.metacritic.com/music'
  end

  test "Site can load reviews" do
    s = HypeTrain::Metacritic::Site.new(true)

    reviews = s.reviews
    assert_equal reviews.count, 10
  
    r = reviews[6]
    assert_equal 'Emeralds', r.artist
    assert_equal 'Just To Feel Anything', r.album
    assert_equal 'http://www.metacritic.com/music/just-to-feel-anything/emeralds', r.link

    assert_match /^The Cleveland electronic/, r.description.strip
    assert_equal '67', r.metascore.average
    assert_equal '67 (Generally favorable reviews)', r.metascore.to_s
    assert_equal 'Emeralds - Just To Feel Anything: 67 (Generally favorable reviews)', r.to_s
  end

  test "Site can save reviews" do
    s = HypeTrain::Metacritic::Site.new(true)

    assert_equal 2, Review.all.count

    r = s.reviews
    s.save_reviews

    # There are 10 reviews from the site in addition to the 2 in the fixture
    assert_equal 12, Review.all.count
  end
end
