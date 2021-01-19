require 'rails_helper'

RSpec.describe MunchieForecast do
  it "can create a forecast for a road trip" do
    data = {
      :temp=>38.88,
      :description=>"overcast clouds"
    }

    munchie_forecast = MunchieForecast.new(data)

    expect(munchie_forecast.temperature).to eq(data[:temp])
    expect(munchie_forecast.summary).to eq(data[:description])
  end
end
