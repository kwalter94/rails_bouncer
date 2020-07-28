# frozen_string_literal: true

module DummyPolicy
  def self.update?(_user)
    true
  end

  def self.create?(_user)
    false
  end
end
