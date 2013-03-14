ActiveRecord::Schema.define do
  create_table :people, force: true do |t|
    t.string :name
    t.string :location
    t.string :email
    t.integer :age
    t.timestamps
  end

  create_table :posts, force: true do |t|
    t.string :title
    t.text :body
    t.timestamps
  end

  create_table :pidgeons, force: true do |t|
    t.string :name
    t.string :location
    t.timestamps
  end

  create_table :users, force: true do |t|
    t.string :username
    t.string :email
    t.string :password_digest
    t.boolean :is_superuser
    t.datetime :last_login
    t.timestamps
  end
end
