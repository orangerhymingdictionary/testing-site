class AddAdditionalFieldsToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.date :birthday
      t.boolean :prefer_plain_text, :default => false, :null => false
      t.integer :gender
    end                          
  end

  def self.down
    change_table :users do |t|
      t.remove :birthday
      t.remove :prefer_plain_text
      t.remove :gender
    end      
  end
end
