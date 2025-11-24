class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  
  def portfolio
    @transactions = current_user.transactions.order(created_at: :desc)
    @total_shares = @transactions.sum(:shares)

    @portfolio_summary = current_user.transactions
      .select('symbol, SUM(shares) AS total_shares, SUM(total_price) AS total_cost_price')
      .group(:symbol)
      .order('symbol ASC')
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      root_path
    else
      portfolios_show_path
    end
  end

  def ensure_admin
    unless current_user&.admin?
      redirect_to portfolios_show_path
    end
  end

end