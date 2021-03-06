class Api::V1::TrainController < ApplicationController
  before_filter :restrict_access

  respond_to :json

  def show
    train = TrainInfo.where(train: params[:id]).first
    render :json => train.to_json(:include => :time_info)
  end
end
