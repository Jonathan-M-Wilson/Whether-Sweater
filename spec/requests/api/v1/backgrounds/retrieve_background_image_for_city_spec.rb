require "rails_helper"

RSpec.describe "Get Background Image for City Endpoint" do
  it "can get backgrounds for a city" do

    params = {
      location: 'Denver City Colorado'
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }
    get '/api/v1/background', headers: headers, params: params

    expect(response).to be_successful
    expect(response.content_type).to eq('application/json; charset=utf-8')

    background_json = JSON.parse(response.body, symbolize_names: true)

    expect(background_json.class).to eq(Hash)
    expect(background_json[:data].size).to eq(3)
    expect(background_json[:data]).to have_key(:id)
    expect(background_json[:data]).to have_key(:type)
    expect(background_json[:data][:type]).to eq('image')
    expect(background_json[:data]).to have_key(:attributes)
    expect(background_json[:data][:attributes].size).to eq(3)
    expect(background_json[:data][:attributes]).to have_key(:image)
    expect(background_json[:data][:attributes][:image]).to have_key(:credit)
    expect(background_json[:data][:attributes][:image]).to have_key(:location)
    expect(background_json[:data][:attributes][:image]).to have_key(:image_url)
    expect(background_json[:data][:attributes][:image][:credit].size).to eq(3)
    expect(background_json[:data][:attributes][:image][:credit]).to have_key(:source)
    expect(background_json[:data][:attributes][:image][:credit]).to have_key(:author)
    expect(background_json[:data][:attributes][:image][:credit]).to have_key(:logo)

    data_attributes = background_json[:data][:attributes]
    data_attributes_credits = background_json[:data][:attributes][:image][:credit]

    credit = background_json[:data][:attributes][:image][:credit]
    expect(credit).to be_a(Hash)
    expect(data_attributes[:credit]).to_not include(nil)

    location = background_json[:data][:attributes][:image][:location]
    expect(location).to be_a(String)
    expect(data_attributes[:location]).to_not eq(nil)

    image_url = background_json[:data][:attributes][:image][:image_url]
    expect(image_url).to be_a(String)
    expect(data_attributes[:image_url]).to_not eq(nil)

    source = background_json[:data][:attributes][:image][:credit][:source]
    expect(source).to be_a(String)
    expect(data_attributes_credits[:source]).to_not eq(nil)

    author = background_json[:data][:attributes][:image][:credit][:author]
    expect(author).to be_a(String)
    expect(data_attributes_credits[:author]).to_not eq(nil)

    logo = background_json[:data][:attributes][:image][:credit][:logo]
    expect(logo).to be_a(String)
    expect(data_attributes_credits[:logo]).to_not eq(nil)
  end

  it "can render a 400 status if no location is specified" do
    params = {
      location: ''
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    get '/api/v1/background', headers: headers, params: params
    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"errors\":\"No location specified\"}")
  end
end
