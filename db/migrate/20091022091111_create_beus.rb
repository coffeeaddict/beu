class CreateBeus < ActiveRecord::Migration
  def self.up
    create_table :beus do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :beus
  end
end
