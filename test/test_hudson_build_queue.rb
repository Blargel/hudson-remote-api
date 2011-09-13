require 'test/unit'
$LOAD_PATH << File.dirname(__FILE__) + "/../lib"
require 'hudson-remote-api.rb'

class TestHudsonBuildQueue < Test::Unit::TestCase
  
  def test_list
    assert Hudson::BuildQueue.list
  end
  
  def test_load_json_api
    Hudson[:url] = "test.host.com"
    assert_equal("http://test.host.com/queue/api/json",
                 Hudson::BuildQueue.__send__("class_variable_get", "@@json_api_build_queue_info_path"))
  end
end
