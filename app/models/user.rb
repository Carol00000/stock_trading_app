class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_many :transactions, dependent: :destroy
  has_many :stocks, dependent: :destroy

  after_create :set_pending_status_and_notify

  private
  def set_pending_status_and_notify
    update_column(:account_status, 'pending')
    #UserMailer.registration_pending(self).deliver_now
  end
  
end
