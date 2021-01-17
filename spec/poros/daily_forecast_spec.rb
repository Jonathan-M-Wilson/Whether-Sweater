require 'rails_helper'

RSpec.describe DailyForecast do
  it "can create a DailyForecast" do

    data = {
      :date=>1610996400,
      :sunrise=>1610979458,
      :sunset=>1611014575,
      :max_temp=>41.85,
      :min_temp=>29.14,
      :conditions=>"clear sky",
      :icon=>"01d"
    }

    daily_forecast = DailyForecast.new(data)

    expect(daily_forecast.date).to be_a(String)
    expect(daily_forecast.icon).to be_a(String)
    expect(daily_forecast.sunset).to be_a(String)
    expect(daily_forecast.sunrise).to be_a(String)
    expect(daily_forecast.max_temp).to be_a(Float)
    expect(daily_forecast.min_temp).to be_a(Float)
    expect(daily_forecast.conditions).to be_a(String)
  end
end
