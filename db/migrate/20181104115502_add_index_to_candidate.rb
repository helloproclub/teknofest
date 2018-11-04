class AddIndexToCandidate < ActiveRecord::Migration[5.2]
  def change
    add_index :candidates, :username, unique: true
  end
end
