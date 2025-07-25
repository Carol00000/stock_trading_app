#copy in git
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  
  #allow_browser versions: :modern

  def portfolio
    @transactions = current_user.transactions.order(created_at: :desc)
    # Calculate total shares owned (sum of all shares for the user)
    @total_shares = @transactions.sum(:shares)

    # Group by symbol and calculate total shares and cost price
    @portfolio_summary = current_user.transactions
      .select('symbol, SUM(shares) AS total_shares, SUM(total_price) AS total_cost_price')
      .group(:symbol)
      .order('symbol ASC') # Optional: Order by symbol alphabetically
  end
  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|user| user.permit(:first_name, :last_name, :balance, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) {|user| user.permit(:first_name, :last_name, :balance, :email, :password, :current_password)}
  end

  def after_sign_in_path_for(resource)
    Rails.logger.info "=== REDIRECT DEBUG: after_sign_in_path_for called ==="
    Rails.logger.info "=== Redirecting to: #{root_path} ==="
    root_path
  end

  def after_sign_in_failure_path_for(resource)
    Rails.logger.error "=== SIGN IN FAILED for resource: #{resource} ==="
    new_user_session_path
  end

end