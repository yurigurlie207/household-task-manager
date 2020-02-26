class CreateUsers < ActiveRecord::Migration[6.0]
  def change
  create_table :users do |t|
    t.string :username
    t.text :email
    t.string :password_digest

    t.string :firstname
    t.string :lastname
    t.string :role
    t.date :birthdate
  end
end
end
