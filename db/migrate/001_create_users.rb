class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :type, default: User.name
      t.string :email, null: false, unique: true
      t.string :password_hash, null: false
      t.string :salt, null: false
      t.timestamps
    end
  end
end
