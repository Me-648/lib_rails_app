class Loan < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :overdue, -> { where(returned_at: nil).where("due_at < ?", Time.current) }
end
