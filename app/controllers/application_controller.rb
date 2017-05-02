class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true
  before_action :authenticate_user!

  layout :pick_layout

  private

    def pick_layout
      devise_controller? ? 'login' : 'application'
    end
end
