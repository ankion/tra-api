class Api::V1::StationController < ApplicationController
  before_filter :restrict_access

  respond_to :json

  def show
    #trains = TrainInfo.where("train_infos.car_class < 1110 and (select count(time_infos.id) from time_infos inner join stations on stations.no=time_infos.station where time_infos.train_date=? and time_infos.train_info_id=train_infos.id and (stations.ticket_no=? or stations.ticket_no=?)) = 2", params[:date], params[:dep], params[:arr])
    sql_string = <<SQL
select 
trains.id,
trains.train_date, 
trains.train, 
trains.car_class,
from_info.dep_time,
to_info.arr_time
from train_infos as trains
join time_infos as from_info on from_info.train_info_id=trains.id
join stations as from_station on from_station.no=from_info.station
join time_infos as to_info on to_info.train_info_id=trains.id
join stations as to_station on to_station.no=to_info.station
where trains.train_date='#{params[:date]}' and from_station.ticket_no='#{params[:dep]}' and to_station.ticket_no='#{params[:arr]}' and (to_info.order - from_info.order > 0)
order by from_info.dep_time;
SQL
    trains = TrainInfo.find_by_sql(sql_string)
    render :json => trains
  end
end
