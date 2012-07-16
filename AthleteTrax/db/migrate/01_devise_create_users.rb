class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :first_name ,        :null => false, :default => ""
      t.string :last_name ,         :null => false, :default => ""
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Encryptable
      # t.string :password_salt

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token

      t.timestamps
    end
	
	execute "INSERT INTO `users` VALUES ('1', 'Brian', 'Gross', 'brian@gmail.com', '$2a$10$VBe2PIjdU4MmEIZI5UJb4O5VmtjVQB64.UbRwsgXNRgbu5vs8GLOC', null, null, null, null, null, null, null, null, '2012-07-06 00:36:05', '2012-07-11 12:42:47');"
	
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
