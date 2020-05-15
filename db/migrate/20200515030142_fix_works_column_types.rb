class FixWorksColumnTypes < ActiveRecord::Migration[6.0]
  def change

    change_column_default :works, :votes, from: nil, to: 0
    
  end
end
