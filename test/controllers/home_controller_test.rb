require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
    Rails.logger.info "=== HOME CONTROLLER: index action called ==="
    Rails.logger.info "=== Current user: #{current_user&.email} ==="
end
