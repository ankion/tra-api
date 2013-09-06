class AddTrainDateToTimeInfos < ActiveRecord::Migration
  def change
    add_column :time_infos, :train_date, :string
  end
end
