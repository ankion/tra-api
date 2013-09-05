class CreateTrainInfos < ActiveRecord::Migration
  def change
    create_table :train_infos do |t|
      t.integer :tai_train_list_id
      t.string :car_class
      t.string :cripple
      t.string :dinning
      t.string :line
      t.string :line_dir
      t.string :note
      t.string :over_night_stn
      t.string :package
      t.string :route
      t.string :train
      t.string :train_type
      t.timestamps
    end
    add_index :train_infos, :tai_train_list_id
  end
end
