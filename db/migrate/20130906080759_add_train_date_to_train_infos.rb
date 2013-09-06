class AddTrainDateToTrainInfos < ActiveRecord::Migration
  def change
    add_column :train_infos, :train_date, :string
  end
end
