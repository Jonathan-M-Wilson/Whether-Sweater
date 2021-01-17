require "rails_helper"

RSpec.describe "Get Weather for City Endpoint" do
  it "can get forecasts for a location" do

    location = 'denver,co'
    # get "/api/v1/forecast?location=#{location}"
    #
    # expect(response).to be_successful
    # expect(response.content_type).to eq('application/json')
    #
    # forecasts_json = JSON.parse(response.body, symbolize_names: true)

    #MapQuestGeocodingService.search(location)
    x = ForecastFacade.daily_weather(location)

    #x = ForecastFacade.new(location)
    require "pry"; binding.pry

    # expect(forecasts_json.class).to eq(Hash)
    # expect(forecasts_json[:data].size).to eq(3)
    # expect(forecasts_json[:data][0]).to have_key(:id)
    # expect(forecasts_json[:data][0]).to have_key(:type)
    # expect(forecasts_json[:data][0][:attributes]).to have_key(:name)
    # expect(forecasts_json[:data][0][:attributes]).to have_key(:description)
    # expect(forecasts_json[:data][0][:attributes]).to have_key(:unit_price)
    # expect(forecasts_json[:data][0][:attributes]).to have_key(:merchant_id)
  end
end
