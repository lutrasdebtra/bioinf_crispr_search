class CreateMer20s < ActiveRecord::Migration
  def change
    create_table :mer20s do |t|
      t.string :sequence
      t.string :strand

      t.timestamps
    end
  end
end
