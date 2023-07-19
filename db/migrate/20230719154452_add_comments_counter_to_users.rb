class AddCommentsCounterToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :comments_counter, :integer
  end
end
