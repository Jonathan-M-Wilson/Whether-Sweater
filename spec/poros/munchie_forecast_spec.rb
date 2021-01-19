require 'rails_helper'

RSpec.describe MunchieForecast do
  it "can create a forecast for a munchie destination" do

    data = {
      :temp=>34.23,
      :weather=>
      [
    {
      :id=>804,
      :main=>"Clouds",
      :description=>"overcast clouds",
      :icon=>"04d"}
      ]
    }

    munchie_forecast = MunchieForecast.new(data)

    expect(munchie_forecast.summary).to eq(data[:weather][0][:description])
    expect(munchie_forecast.temperature).to eq(data[:temp])
  end
end
