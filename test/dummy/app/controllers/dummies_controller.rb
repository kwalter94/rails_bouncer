# frozen_string_literal: true

class DummiesController < ApplicationController
  authorise_through DummyPolicy, fallback_policy: :allow
  def create
    render json: { dummy: 'Dummy' }, status: :created
  end

  def update
    render json: [{ dummy: 'Dummy' }], status: :ok
  end

  def show
    render json: { dummy: 'Dummy' }, status: :ok
  end
end
