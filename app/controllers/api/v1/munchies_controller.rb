class Api::V1::MunchiesController < ApplicationController

  def index
    if params[:start_city].nil? || params[:end_city].empty? || params[:food].empty?
      render json: { 'errors': 'Missing required fields, please try again' }, status: 400
    else
      render json: MunchieSerializer.new(munchie)
    end
  end

  private

  def munchie
    MunchieFacade.munchie(params[:start_city], params[:end_city], params[:food])
  end
end
