class MunchieForecast
  attr_reader :temperature,
              :summary

  def initialize(params)
    @temperature = params[:temp]
    @summary = params[:weather][0][:description]
  end
end
