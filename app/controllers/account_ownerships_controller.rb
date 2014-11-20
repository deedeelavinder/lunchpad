class AccountOwnershipsController < ApplicationController
  before_action :set_account_ownership, only: [:destroy]

  def index
    @account_ownerships = AccountOwnership.all
  end

  def create
    @account_ownership = AccountOwnership.new(account_ownership_params)
    return unless @account_ownership.save
  end

  def destroy
    return unless @account_ownerships.destroy
    redirect_to '/welcome'
  end

  private

  def set_account_ownership
    @account_ownerships = AccountOwnership.find(params[:id])
  end

  def account_ownership_params
    params.require(:account_ownership).permit(:account_id, :user_id)
  end
end