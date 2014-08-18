class CreateMer14s < ActiveRecord::Migration
  def change
    create_table :mer14s do |t|
      t.string :sequence
      t.string :strand
      t.integer :mer20_id

      t.timestamps
    end
  end
end
