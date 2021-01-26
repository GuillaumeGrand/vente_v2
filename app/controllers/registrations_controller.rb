# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    if resource.instance_of?(User)
      info_path
    else
      trader_info_path
    end
  end
end
