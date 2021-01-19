require "rails_helper"

RSpec.describe "Munchies Endpoint" do
  it "can retrieve food and forecast information for a destination city" do

    params = {
      start_city: 'Denver,Co',
      end_city: 'Pueblo,Co',
      food: 'chinese'
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    get '/api/v1/munchies', headers: headers, params: params

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json; charset=utf-8')

    munchies_json = JSON.parse(response.body, symbolize_names: true)
    require "pry"; binding.pry

    expect(munchies_json.class).to eq(Hash)
    expect(munchies_json[:data].size).to eq(3)
    expect(munchies_json[:data]).to have_key(:id)
    expect(munchies_json[:data]).to have_key(:type)
    expect(munchies_json[:data][:type]).to eq('munchie')
    expect(munchies_json[:data]).to have_key(:attributes)
    expect(munchies_json[:data][:attributes].size).to eq(4)
    expect(munchies_json[:data][:attributes]).to have_key(:destination_city)
    expect(munchies_json[:data][:attributes]).to have_key(:travel_time)

    expect(munchies_json[:data][:attributes]).to have_key(:forecast)
    expect(munchies_json[:data][:attributes][:forecast]).to have_key(:summary)
    expect(munchies_json[:data][:attributes][:forecast]).to have_key(:temperature)

    expect(munchies_json[:data][:attributes]).to have_key(:restaurant)
    expect(munchies_json[:data][:attributes][:restaurant]).to have_key(:name)
    expect(munchies_json[:data][:attributes][:restaurant]).to have_key(:address)
  end
end
