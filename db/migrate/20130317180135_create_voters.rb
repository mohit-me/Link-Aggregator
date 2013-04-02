class CreateVoters < ActiveRecord::Migration
  def change
    create_table :voters do |t|
      t.string :upvoted_by
      t.integer :upvoted_link

      t.timestamps
    end
  end
end
