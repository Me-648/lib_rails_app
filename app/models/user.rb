class User < ApplicationRecord
  # モデルの関連付け
  has_many :loans
  has_many :books, through: :loans
  # enumを使用
  enum :role, { user: 0, admin: 1 }
end
