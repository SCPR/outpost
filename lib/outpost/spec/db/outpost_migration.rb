class OutpostMigration < ActiveRecord::Migration
  def up
    create_table "people", force: true do |t|
      t.string  "name"
      t.string  "email"
      t.string  "location"
      t.string  "age"
      t.timestamps
    end
    
    create_table "pidgeons", force: true do |t|
      t.string "chirp"
      t.string "squak"
      t.string "cockadoodledoo"
    end
  end
  
  def down
    drop_table "people"
    drop_table "pidgeons"
  end
end
