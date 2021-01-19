class Api::V1::ForecastController < ApplicationController
  def index
    if params[:location].blank?
      render json: { 'errors': 'No location specified' }, status: :bad_request
    else
      render json: ForecastSerializer.new(weather)
    end
  end

  private

  def weather
    ForecastFacade.weather(params[:location])
  end
end
