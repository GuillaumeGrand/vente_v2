class ApplicationController < ActionController::Base
  before_action :set_js_environment

  protected

  def set_js_environment
    gon.stripe_publishable_key = ENV["STRIPE_PUBLISHABLE_KEY"]
  end
end
