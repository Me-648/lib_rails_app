class ChangeRoleIntegerInUsers < ActiveRecord::Migration[8.0]
  def up
    # 既存のstringをintegerに変換（デフォルトはgeneral=0）
    add_column :users, :role_tmp, :integer, default: 0

    User.reset_column_information
    User.find_each do |user|
      case user.role
      when "admin" then user.update!(role_tmp: 1)
      else user.update!(role_tmp: 0)
      end
    end

    remove_column :users, :role
    rename_column :users, :role_tmp, :role
  end

  def down
    add_column :users, :role_tmp, :string

    User.reset_column_information
    User.find_each do |user|
      case user.role
      when 1 then user.update!(role_tmp: "admin")
      else user.update!(role_tmp: "general")
      end
    end

    remove_column :users, :role
    rename_column :users, :role_tmp, :role
  end
end
