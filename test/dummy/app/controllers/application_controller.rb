class ApplicationController < ActionController::Base
  include RailsBouncer::Bouncer

  def current_user
    { username: 'fordprefect' }
  end
end
