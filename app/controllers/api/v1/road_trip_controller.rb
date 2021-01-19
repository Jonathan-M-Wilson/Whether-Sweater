class Api::V1::RoadTripController < ApplicationController
  def create
    if User.exists?(api_key: params[:api_key])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { 'error': 'Unauthorized request, please check your credentials' }, status: :unauthorized
    end
  end

  private

  def road_trip
    RoadTripFacade.road_trip(params[:origin], params[:destination])
  end
end
