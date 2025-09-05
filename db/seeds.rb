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
Book.create!(title: "Rubyの本", author: "しもはし", isbn: "1234", category: "小説", total_copies: 123)

# Userサンプル
User.create!(student_no: "12345", name: "山田太郎", role: 0, password: "pass")
User.create!(student_no: "99999", name: "司書花子", role: 1, password: "admin")
