class Api::V1::StationInfoController < ApplicationController
  before_filter :restrict_access

  respond_to :json

  def show
    stations = Station.select("ticket_no as id, name as value").where("ticket_no != ''").order("ticket_no ASC")
    hash_stations = {}
    stations.each {|s| hash_stations["%03d-%s"% [s.id, s.value]] = "%03d"% s.id}
    render :json => hash_stations
  end
end
