class CreatePlanes < ActiveRecord::Migration[5.2]
  def change
    create_table :planes do |t|
      t.integer :sits_count
      t.integer :rows
      t.string :row_arrangement

      t.timestamps
    end
  end
end
