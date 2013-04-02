class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name
      t.string :domain
      t.integer :upVotes, :default => 0
      t.integer :downVotes, :default => 0
      t.text :content
      t.string :imgUrl

      t.timestamps
    end
  end

end
