class User < ApplicationRecord
  # モデルの関連付け
  has_many :loans
  has_many :books, through: :loans
end
