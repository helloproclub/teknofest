class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.string :username
      t.string :fullname
      t.string :password_digest

      t.timestamps
    end
  end
end
