class CreateTimeInfos < ActiveRecord::Migration
  def change
    create_table :time_infos do |t|
      t.integer :train_info_id
      t.string :arr_time
      t.string :dep_time
      t.string :order
      t.string :route
      t.string :station
      t.timestamps
    end
    add_index :time_infos, :train_info_id
  end
end
