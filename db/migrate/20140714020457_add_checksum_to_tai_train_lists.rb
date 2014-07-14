class AddChecksumToTaiTrainLists < ActiveRecord::Migration
  def change
    add_column :tai_train_lists, :checksum, :string
  end
end
