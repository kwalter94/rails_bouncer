# frozen_string_literal: true

module RailsBouncer
  module Generators
    class InstallGenerator < Rails::Generator::Base
      desc 'Create initializer for rails_bouncer at config/initializers/bouncer.rb'

      source_root File.expand_path('templates', __dir__)

      def copy_forbidden_page
        copy_file '403.html', 'public/403.html'
      end
    end
  end
end
