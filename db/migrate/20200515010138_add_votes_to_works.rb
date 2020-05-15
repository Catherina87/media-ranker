class AddVotesToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :votes, :integer
  end
end
