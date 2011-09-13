require 'helper'

class TestHudsonConfig < Test::Unit::TestCase
  def test_get
    assert Hudson[:url]
  end

  def test_set
    test_url = "test.host.com"
    Hudson[:url] = test_url
    assert_equal(Hudson[:url], "http://#{test_url}")
  end

  def test_load_settings_hash
    new_settings = {:url => 'test.com', :user => 'test', :password => 'test', :version => '1.00'}
    Hudson.settings = new_settings
    assert_equal(Hudson[:url], "http://#{new_settings[:url]}")
    assert_equal(Hudson[:user], "test")
    assert_equal(Hudson[:password], "test")
    assert_equal(Hudson[:version], "1.00")
  end

  def test_auto_config
    assert_nothing_thrown{ Hudson.auto_config }
  end

end
