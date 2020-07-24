# frozen_string_literal: true

module RailsBouncer
  class BouncerError < StandardError; end
  class MissingBouncer < BouncerError; end
  class NotAuthorised < BouncerError; end
end
