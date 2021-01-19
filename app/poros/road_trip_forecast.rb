class RoadTripForecast
  attr_reader :temperature,
              :conditions

  def initialize(params)
    @temperature = params[:temp]
    @conditions = params[:description]
  end
end
