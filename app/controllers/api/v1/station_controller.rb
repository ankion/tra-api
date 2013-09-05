class Api::V1::StationController < ApplicationController
  #before_filter :authenticate_user!

  respond_to :json

  def show
    trains = TrainInfo.where("train_infos.car_class < 1110 and (select count(time_infos.id) from time_infos inner join stations on stations.no=time_infos.station where time_infos.train_info_id=train_infos.id and (stations.ticket_no=? or stations.ticket_no=?)) = 2", params[:dep], params[:arr])
    render :json => trains
  end
end
