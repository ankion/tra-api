class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :no
      t.string :name
      t.string :en_name
      t.string :ticket_no
      t.timestamps
    end
  end
end
