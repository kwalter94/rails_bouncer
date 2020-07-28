# frozen_string_literal: true

require 'test_helper'

module RailsBouncer
  # Tests the behaviour of rails_bouncer in an application.
  #
  # See: /test/dummy/app/policies/dummy_policy.rb,
  #     and /test/dummy/app/controllers/dummy_controller.rb
  class DummyTest < ::ActionDispatch::IntegrationTest
    test '#update should respond with 200 OK' do
      patch dummy_url
      assert_equal 200, status
    end

    test '#create should respond with 403 Forbidden' do
      post dummy_url
      assert_equal 403, status
    end

    test '#show should respond with 200 OK' do
      get dummy_url
      assert_equal 200, status
    end
  end
end
