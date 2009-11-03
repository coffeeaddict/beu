require File.dirname(__FILE__) + '/../test_helper'
require 'ws_controller'

class WSController; def rescue_action(e) raise e end; end

class WSControllerApiTest < Test::Unit::TestCase
  def setup
    @controller = WSController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  def test_login
    result = invoke :login
    assert_equal nil, result
  end

  def test_add
    result = invoke :add
    assert_equal nil, result
  end

  def test_list
    result = invoke :list
    assert_equal nil, result
  end
end
