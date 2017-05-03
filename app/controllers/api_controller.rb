class ApiController < ApplicationController
  protect_from_forgery with: :exception, unless: -> { request.format.json? }

  def authenticate_user!
    true
  end
end
