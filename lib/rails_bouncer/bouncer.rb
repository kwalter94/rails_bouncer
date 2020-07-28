# frozen_string_literal: true

require 'active_support/concern'

module RailsBouncer
  module Bouncer
    extend ActiveSupport::Concern

    included do
      cattr_accessor :bouncer
      cattr_accessor :bouncer_fallback_policy # :allow_then_deny or :deny_then_allow

      before_action :authorise

      # Limits access to a particular action to users having a privilige
      # to perform that action (see method bind_privilege).
      def authorise
        raise MissingBouncer, 'No bouncer assigned to controller' unless bouncer

        query = "#{action_name}?".to_sym

        unless bouncer.respond_to?(query)
          raise NotAuthorised if bouncer_fallback_policy == :deny

          return true
        end

        return true if bouncer.send(query, current_user)

        raise NotAuthorised
      end

      rescue_from NotAuthorised, with: :render_not_authorised

      def render_not_authorised(exception)
        respond_to do |format|
          format.json { render json: { exception: exception }, status: :forbidden }
          format.html { render file: "#{Rails.root}/public/403.html", status: :forbidden }
        end
      end
    end

    class_methods do
      # Assign a bouncer to a controller.
      #
      # Example:
      #
      #   module FoobarBouncer
      #     def self.create?(user)
      #       user.admin?
      #     end
      #
      #     def self.update?(user)
      #       user.admin?
      #     end
      #
      #     def self.destroy?(user)
      #       user.admin?
      #     end
      #   end
      #
      #   class FoobarController < ApplicationController
      #     ...
      #     authorise_through FoobarBouncer, fallback_policy: :allow
      #     ...
      #
      # This will limit access to #create, #update, and #destroy actions to
      # administrators and :index, however, all actions without a corresponding
      # query in the bouncer will be allowed (to deny set fallback_policy to :deny)
      def authorise_through(bouncer, fallback_policy: :deny)
        unless %i[allow deny].include?(fallback_policy)
          raise InvalidFallbackPolicy, "Invalid fallback_policy #{fallback_policy}, allowed values are :deny and :allow"
        end

        self.bouncer = bouncer
        self.bouncer_fallback_policy = fallback_policy
      end
    end
  end
end
