class LoansController < ApplicationController
  before_action :require_admin, only: [:overdue]

  def overdue
    @loans = Loan.overdue.includes(:user, :book)
  end

  private
  def require_admin
    unless current_user&.admin?
      redirect_to books_path, alert: "権限がありません"
    end
  end
end
