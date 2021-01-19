class MunchieForecast
  attr_reader :temperature,
              :summary

  def initialize(params)
    @temperature = params[:temp]
    @summary = params[:description]
  end
end
