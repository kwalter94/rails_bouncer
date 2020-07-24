# frozen_string_literal: true

require 'ostruct'
require 'test_helper'

module RailsBouncer
  class BouncerTest < ActiveSupport::TestCase
    test 'it triggers before_action with value :authorise on include' do
      clazz = Class.new do
        cattr_accessor :action

        def self.before_action(name)
          self.action = name
        end

        include RailsBouncer::Bouncer
      end

      assert_equal(clazz.new.action, :authorise)
    end

    test 'authorise raises MissingBouncer if bouncer is not set' do
      clazz = Class.new do
        def self.before_action(_action); end

        include RailsBouncer::Bouncer
      end

      assert_raises(RailsBouncer::MissingBouncer) { clazz.new.authorise }
    end

    test 'authorise raises NotAuthorised when a bouncer predicate fails' do
      bouncer = Class.new do
        def self.index?(_user)
          false
        end
      end

      clazz = Class.new do
        def self.before_action(_action); end

        def action_name
          :index
        end

        def current_user; end

        include RailsBouncer::Bouncer

        authorise_through bouncer
      end

      assert_raises(RailsBouncer::NotAuthorised) { clazz.new.authorise }
    end

    test 'authorise raises NotAuthorized when a bouncer predicate is missing' do
      clazz = Class.new do
        def self.before_action(_action); end

        def action_name
          :index
        end

        def current_user; end

        include RailsBouncer::Bouncer

        authorise_through Class.new
      end

      assert_raises(RailsBouncer::NotAuthorised) { clazz.new.authorise }
    end

    test 'authorise returns when a bouncer predicate is missing but fallback_policy is set to :allow' do
      clazz = Class.new do
        def self.before_action(_action); end

        def action_name
          :index
        end

        def current_user; end

        include RailsBouncer::Bouncer

        authorise_through Class.new, fallback_policy: :allow
      end

      assert(clazz.new.authorise)
    end

    test 'authorise_through raises InvalidFallbackPolicy when fallback_policy is neither :allow nor :deny' do
      assert_raises(RailsBouncer::InvalidFallbackPolicy) do
        Class.new do
          def self.before_action(_action); end

          def action_name
            :index
          end

          def current_user; end

          include RailsBouncer::Bouncer

          authorise_through Class.new, fallback_policy: :something_else
        end
      end
    end

    test 'authorise returns true when a bouncer predicate succeeds' do
      bouncer = Class.new do
        def self.index?(_user)
          true
        end
      end

      clazz = Class.new do
        def self.before_action(_action); end

        def action_name
          :index
        end

        def current_user; end

        include RailsBouncer::Bouncer

        authorise_through bouncer
      end

      assert clazz.new.authorise
    end
  end
end
