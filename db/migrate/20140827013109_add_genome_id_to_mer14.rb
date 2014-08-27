class AddGenomeIdToMer14 < ActiveRecord::Migration
  def change
    add_column :mer14s, :genome_id, :integer
  end
end
