# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# bookサンプル
# bookサンプル
book1 = Book.find_or_create_by!(isbn: "1234") do |book|
  book.title = "Rubyの本"
  book.author = "しもはし"
  book.category = "小説"
  book.total_copies = 123
end
book2 = Book.find_or_create_by!(isbn: "17") do |book|
  book.title = "坪内学園の真実"
  book.author = "だいちゃんカンパニー株式会社"
  book.category = "小説"
  book.total_copies = 1
end
book3 = Book.find_or_create_by!(isbn: "1") do |book|
  book.title = "1945年8.9"
  book.author = "JUN"
  book.category = "芸術"
  book.total_copies = 3
end

# Userサンプル
user1 = User.find_or_create_by!(student_no: "12345") do |user|
  user.name = "山田太郎"
  user.role = 0
  user.password = "pass"
end
user2 = User.find_or_create_by!(student_no: "99999") do |user|
  user.name = "管理者"
  user.role = 1
  user.password = "admin"
end

# Loanサンプル（重複防止のために条件に注意）
loan1 = Loan.find_or_create_by!(
  user_id: user1.id,
  book_id: book1.id,
  returned_at: nil
) do |loan|
  loan.borrowed_at = 1.month.ago
  loan.due_at = 10.days.ago
end
