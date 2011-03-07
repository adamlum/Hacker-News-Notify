class AddEmailValidationCodeToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email_validation_code, :string
  end

  def self.down
    remove_column :users, :email_validation_code
  end
end
