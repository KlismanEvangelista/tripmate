class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_my_requests

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :phone, :address, :birth_date, :occupation, :dni, :photo])

    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :phone, :address, :birth_date, :occupation, :dni, :photo])
  end

  def load_my_requests
    if user_signed_in?
      @my_requests_not_viewed = current_user.plans.map(&:travels).flatten.select { |t| !t.viewed && t.status == 'solicitado' }
      @my_requests_not_viewed = @my_requests_not_viewed.sort_by { |t| t.created_at }.reverse
    else
      @my_requests_not_viewed = []
    end
  end
end
