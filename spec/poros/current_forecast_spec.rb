require 'rails_helper'

RSpec.describe CurrentForecast do
  it "can create a CurrentForecast" do

    data = {
      :datetime=>1610915666,
      :sunrise=>1610893087,
      :sunset=>1610928108,
      :temperature=>47.77,
      :feels_like=>41.88,
      :humidity=>28,
      :uvi=>1.13,
      :visibility=>10000,
      :conditions=>"overcast clouds",
      :icon=>"04d"
    }

    current_forecast = CurrentForecast.new(data)

    expect(current_forecast.uvi).to be_a(Float)
    expect(current_forecast.icon).to be_a(String)
    expect(current_forecast.sunset).to be_a(String)
    expect(current_forecast.sunrise).to be_a(String)
    expect(current_forecast.datetime).to be_a(String)
    expect(current_forecast.humidity).to be_a(Integer)
    expect(current_forecast.feels_like).to be_a(Float)
    expect(current_forecast.temperature).to be_a(Float)
    expect(current_forecast.conditions).to be_a(String)
    expect(current_forecast.visibility).to be_a(Integer)
  end
end
