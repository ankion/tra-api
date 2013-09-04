class CreateTaiTrainLists < ActiveRecord::Migration
  def change
    create_table :tai_train_lists do |t|
      t.string :train_date
      t.string :status
      t.timestamps
    end
  end
end
