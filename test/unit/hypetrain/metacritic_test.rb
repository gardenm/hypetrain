require 'test_helper'
require 'metacritic'

class MetacriticTest < ActiveSupport::TestCase
  test "Review is created correctly" do
    r = HypeTrain::Metacritic::Review.new('Leona Lewis', 'Glassheart', "http://www.metacritic.com/music/glassheart/leona-lewis", 'Descr', '')

    assert r.artist == 'Leona Lewis'
    assert r.album == 'Glassheart'
    assert r.link == 'http://www.metacritic.com/music/glassheart/leona-lewis'
    assert r.description == 'Descr'
  end

  test "Site is created correctly" do
    s = HypeTrain::Metacritic::Site.new(true)

    assert s.link == 'http://www.metacritic.com/music'
  end

  test "Site can load data" do
    s = HypeTrain::Metacritic::Site.new(true)

    reviews = s.reviews
    assert reviews.count == 10
  
    r = reviews[6]
    assert r.artist == 'Emeralds'
    assert r.album == 'Just To Feel Anything'
    assert r.link == 'http://www.metacritic.com/music/just-to-feel-anything/emeralds'

    assert r.description.strip.starts_with? 'The Cleveland electronic'
    assert r.metascore.average == '67'
  end
end
