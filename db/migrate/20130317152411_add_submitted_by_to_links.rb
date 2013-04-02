class AddSubmittedByToLinks < ActiveRecord::Migration
  def change
    add_column :links, :submitted_by, :string
  end
end
