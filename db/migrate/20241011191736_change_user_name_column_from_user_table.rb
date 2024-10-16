class ChangeUserNameColumnFromUserTable < ActiveRecord::Migration[7.2]
  change_table :users do |t|
    t.rename :user_name, :username
  end
end
