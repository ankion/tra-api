class CreateCarClasses < ActiveRecord::Migration
  def change
    create_table :car_classes do |t|
      t.string :no
      t.string :name
      t.string :en_name
      t.timestamps
    end
  end
end
