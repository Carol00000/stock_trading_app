class Admin::TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = Transaction.all
  end

  def show
  end

  def edit

  end

  def update

  end

  def create

  end

  def destroy
    
  end
end
