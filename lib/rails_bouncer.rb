require "rails_bouncer/railtie"
require "rails_bouncer/auth"

module RailsBouncer
  class BouncerError < StandarError; end
  class NotAuthorised < BouncerError; end

  class << ActionController::Base
    include Auth
  end
end
