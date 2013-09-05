class TimeInfo < ActiveRecord::Base
  belongs_to :train_info
  has_one :station_info, :class_name => "Station", :foreign_key => "no", :primary_key => "station"
end
