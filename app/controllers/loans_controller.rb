class LoansController < ApplicationController
  before_action :require_admin, only: [:overdue]

  def overdue
    @loans = Loan.overdue.includes(:user, :book)
  end

  private
  def require_admin
    redirect_to root_path, alert: "権限がありません" unless current_user&.admin?
  end
end
