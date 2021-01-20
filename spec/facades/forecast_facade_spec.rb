require 'rails_helper'

RSpec.describe ForecastFacade do
  it "can make Forecast", :vcr do
    VCR.use_cassette('/facade/denver_forecast_json.yml') do
      forecast = ForecastFacade.weather('denver,co')
      expect(forecast).to be_an_instance_of(Forecast)
    end
  end
end
