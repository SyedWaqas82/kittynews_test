class AddVotesCountToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :votes_count, :integer, null: false, default: 0 
  end
end
