class Book < ApplicationRecord
  # 空でないことを確認するバリデーション
  validates :title, :author, :isbn, :category, presence: true
  # 整数かつ0以上であることを確認するバリデーション
  validates :total_copies, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # モデルの関連付け
  has_many :loans
  has_many :users, through: :loans
end
