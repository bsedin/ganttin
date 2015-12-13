class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.string :id,                 null: false, primary_key: true
      t.string :username
      t.string :name,               null: false, default: ''
      t.string :email
      t.string :encrypted_password, null: false, default: ''

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.datetime :remember_created_at

      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      #t.inet     :current_sign_in_ip
      #t.inet     :last_sign_in_ip

      t.string   :authentication_token
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email

      t.integer  :failed_attempts, default: 0, null: false
      t.string   :unlock_token
      t.datetime :locked_at

      t.timestamps null: false
    end
    add_index :users, :email
    add_index :users, :username
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    add_index :users, :authentication_token, unique: true
  end
end
