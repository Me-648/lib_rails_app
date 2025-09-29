class Book < ApplicationRecord
  # 空でないことを確認するバリデーション
  validates :title, :author, :isbn, :category, presence: true
  # 整数かつ0以上であることを確認するバリデーション
  validates :total_copies, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # モデルの関連付け
  has_many :loans, dependent: :destroy
  has_many :users, through: :loans

  # まだ返却されていない貸出数を数える
  def borrowed_count
    loans.where(returned_at: nil).count
  end

  def available_count
    total_copies - borrowed_count
  end

  def stock_status
    "#{available_count}/#{total_copies}"
  end
end
