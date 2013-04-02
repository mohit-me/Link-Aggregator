class AddVotesToLinks < ActiveRecord::Migration
  def change
    add_column :links, :votes_count, :integer
  end
end
