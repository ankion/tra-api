class TrainInfo < ActiveRecord::Base
  belongs_to :tai_train_list
  has_many :time_info
end
