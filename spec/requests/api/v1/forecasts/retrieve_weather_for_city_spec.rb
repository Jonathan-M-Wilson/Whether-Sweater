require "rails_helper"

RSpec.describe "Get Weather for City Endpoint" do
  it "can get forecasts for a location" do

    params = {
      location: 'denver,co'
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    get '/api/v1/forecast', headers: headers, params: params

    expect(response).to be_successful

    # I have been unsuccessful at removing charset from content type,
    # will return to fix this later. Check project board
    expect(response.content_type).to eq('application/json; charset=utf-8')

    forecasts_json = JSON.parse(response.body, symbolize_names: true)

    expect(forecasts_json.class).to eq(Hash)
    expect(forecasts_json[:data].size).to eq(3)
    expect(forecasts_json[:data]).to have_key(:id)
    expect(forecasts_json[:data]).to have_key(:type)
    expect(forecasts_json[:data][:type]).to eq('forecast')
    expect(forecasts_json[:data]).to have_key(:attributes)
    expect(forecasts_json[:data][:attributes]).to have_key(:location)
    expect(forecasts_json[:data][:attributes]).to have_key(:current_weather)
    expect(forecasts_json[:data][:attributes]).to have_key(:daily_weather)
    expect(forecasts_json[:data][:attributes]).to have_key(:hourly_weather)

    current = forecasts_json[:data][:attributes][:current_weather]
    expect(current.keys).to eq(
      [
        :datetime,
        :sunrise,
        :sunset,
        :temperature,
        :feels_like,
        :humidity,
        :uvi,
        :visibility,
        :conditions,
        :icon
      ]
    )
    expect(current.values).to_not include(nil)

    expect(current.size).to eq(10)
    expect(current[:datetime]).to be_a(String)
    expect(current[:sunrise]).to be_a(String)
    expect(current[:sunset]).to be_a(String)

    integer_or_float_current = [
      current[:temperature],
      current[:feels_like],
      current[:humidity],
      current[:uvi],
      current[:visibility]
    ]

    integer_or_float_current.each do |attribute|
      unless attribute.class == Integer
        expect(attribute).to be_a(Float)
      end
    end

    expect(current[:icon]).to be_a(String)
    expect(current[:conditions]).to be_a(String)

    daily = forecasts_json[:data][:attributes][:daily_weather][0]
    expect(daily.keys).to eq(
      [
        :date,
        :sunrise,
        :sunset,
        :max_temp,
        :min_temp,
        :conditions,
        :icon
      ]
    )
    expect(daily.values).to_not include(nil)

    expect(daily.size).to eq(7)
    expect(daily[:date]).to be_a(String)
    expect(daily[:sunset]).to be_a(String)
    expect(daily[:sunrise]).to be_a(String)
    expect(daily[:conditions]).to be_a(String)

    unless daily[:max_temp].class == Integer
      expect(daily[:max_temp]).to be_a(Float)
    end

    unless daily[:min_temp].class == Integer
      expect(daily[:min_temp]).to be_a(Float)
    end

    hourly = forecasts_json[:data][:attributes][:hourly_weather][0]
    expect(hourly.keys).to eq(
      [
        :time,
        :temperature,
        :wind_speed,
        :wind_direction,
        :conditions,
        :icon
      ]
    )
    expect(hourly.values).to_not include(nil)

    expect(hourly.size).to eq(6)
    expect(hourly[:time]).to be_a(String)
    expect(hourly[:icon]).to be_a(String)
    expect(hourly[:wind_speed]).to be_a(String)
    expect(hourly[:conditions]).to be_a(String)
    expect(hourly[:wind_direction]).to be_a(String)

    unless hourly[:temperature].class == Integer
      expect(hourly[:temperature]).to be_a(Float)
    end
  end

  it "can render a 400 status if no location is specified " do
    params = {
      location: ''
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    get '/api/v1/forecast', headers: headers, params: params
    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"errors\":\"No location specified\"}")
  end
end
