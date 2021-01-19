require "rails_helper"

RSpec.describe "Road Trip Endpoint" do
  it "Can Post a request and get the forecast for the destination based on eta" do

    user_params = {
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    user = User.create!(user_params)

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "#{user.api_key}"
    }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

    road_trip_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(road_trip_json.class).to eq(Hash)
    expect(road_trip_json[:data].size).to eq(3)
    expect(road_trip_json[:data]).to have_key(:id)

    expect(road_trip_json[:data]).to have_key(:type)
    expect(road_trip_json[:data][:type]).to eq('roadtrip')

    expect(road_trip_json[:data]).to have_key(:attributes)
    expect(road_trip_json[:data][:attributes].size).to eq(4)

    expect(road_trip_json[:data][:attributes]).to have_key(:start_city)
    expect(road_trip_json[:data][:attributes][:start_city]).to be_a(String)

    expect(road_trip_json[:data][:attributes]).to have_key(:end_city)
    expect(road_trip_json[:data][:attributes][:end_city]).to be_a(String)

    expect(road_trip_json[:data][:attributes]).to have_key(:travel_time)
    expect(road_trip_json[:data][:attributes][:travel_time]).to be_a(String)

    expect(road_trip_json[:data][:attributes]).to have_key(:weather_at_eta)
    expect(road_trip_json[:data][:attributes][:weather_at_eta].size).to eq(2)

    expect(road_trip_json[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
    expect(road_trip_json[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
  end

  it "can render a 200 status if request is successful" do
    user_params = {
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    user = User.create!(user_params)

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "#{user.api_key}"
    }

    post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)
    expect(response.status).to eq(200)
  end

  it "can render a 401 status if api key is incorrect or not provided" do
    user_params = {
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    User.create!(user_params)

    params = {
      origin: "Denver,CO",
      destination: "Pueblo,CO",
      api_key: ""
    }

    post '/api/v1/road_trip', params: params

    expect(response.status).to eq(401)
    expect(response.body).to eq("{\"error\":\"Unauthorized request, please check your credentials\"}")
  end

  describe "If a user queries an impossible route" do
    it "can return data with an empty weather block and an impossible travel time" do

      user_params = {
        email: 'whatever@example.com',
        password: 'password',
        password_confirmation: 'password'
      }

      user = User.create!(user_params)

      headers = {
        'content-type': 'application/json',
        'Accept': 'application/json'
      }

      params = {
        "origin": "Denver,CO",
        "destination": "Honolulu,HI",
        "api_key": "#{user.api_key}"
      }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(params)

      road_trip_json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)

      expect(road_trip_json[:data][:attributes][:travel_time]).to eq("impossible")
      expect(road_trip_json[:data][:attributes][:weather_at_eta]).to eq(nil)
    end
  end
end
