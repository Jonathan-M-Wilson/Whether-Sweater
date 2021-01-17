require 'rails_helper'

RSpec.describe ForecastFacade do
  it "can make Forecast", :vcr do
    VCR.use_cassette('/forecast_facade/denver_forecast.json') do
      forecast = ForecastFacade.weather('denver,co')
      expect(forecast).to be_an_instance_of(Forecast)
    end
  end
end
