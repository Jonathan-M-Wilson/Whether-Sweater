require 'rails_helper'

RSpec.describe MunchieForecast do
  it "can create a forecast for a munchie destination" do

    data = {
      :temp=>38.88,
      :description=>"overcast clouds"
    }

    MunchieForecast.new(data)

    expect(munchie_forecast.summary).to eq(data[:description])
    expect(munchie_forecast.temperature).to eq(data[:temp])
  end
end
