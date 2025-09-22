class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :target_user, class_name: 'User', optional: true
  
  def is_approved?
    account_status == 'approved'
  end
  
  def admin_action?
    !admin_action.blank?
  end
  
  def action_display_name
    return nil unless admin_action?
    
    case admin_action
    when 'deposit'
      'Deposit Funds'
    when 'withdrawal' 
      'Withdraw Funds'
    when 'transfer'
      'Transfer Funds'
    when 'balance_adjustment'
      'Balance Adjustment'
    when 'account_credit'
      'Account Credit'
    when 'account_debit'
      'Account Debit'
    else
      admin_action.humanize
    end
  end

  validates :company_name, presence: true, unless: :admin_action?
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_price, numericality: { greater_than_or_equal_to: 0 }, unless: :admin_action?
  validates :shares, numericality: { greater_than: 0 }, unless: :admin_action?
  validates :action_type, inclusion: { in: ["buy", "sell"], message: "%{value} is not a valid action type" }, unless: :admin_action?
  
  validates :admin_action, presence: true, if: :admin_action?
  validates :description, presence: true, if: :admin_action?

  def self.ransackable_attributes(auth_object = nil)
    ["company_name", "action_type", "admin_action", "description"]
  end
end