class ChangeRoleToIntegerInUsers < ActiveRecord::Migration[8.0]
  def up
    # 一時カラムを作成（enum用にinteger）
    add_column :users, :role_tmp, :integer, default: 0

    # Userモデルを直接使わずにSQLで変換（enumのせいで呼べないから）
    execute <<-SQL
      UPDATE users SET role_tmp = 
        CASE role
          WHEN 'admin' THEN 1
          WHEN 'user'  THEN 0
          ELSE 0
        END;
    SQL

    remove_column :users, :role
    rename_column :users, :role_tmp, :role
  end

  def down
    add_column :users, :role_tmp, :string

    execute <<-SQL
      UPDATE users SET role_tmp = 
        CASE role
          WHEN 1 THEN 'admin'
          WHEN 0 THEN 'user'
          ELSE 'user'
        END;
    SQL

    remove_column :users, :role
    rename_column :users, :role_tmp, :role
  end
end
