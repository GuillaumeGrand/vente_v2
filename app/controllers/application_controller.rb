class ApplicationController < ActionController::Base
  before_action :set_js_environment
  skip_before_action :verify_authenticity_token, if: -> { controller_name == 'sessions' && action_name == 'create' || controller_name == 'registrations' && action_name == 'create'}

  protected

  def set_js_environment
    gon.stripe_publishable_key = ENV["STRIPE_PUBLISHABLE_KEY"]
  end

end
