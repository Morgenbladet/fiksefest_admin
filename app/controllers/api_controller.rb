class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token

  def authenticate_user!
    true
  end
end
