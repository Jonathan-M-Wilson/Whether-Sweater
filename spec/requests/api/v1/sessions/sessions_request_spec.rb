require "rails_helper"

RSpec.describe "Sessions Endpoint" do
  before :each do
    User.destroy_all
  end

  it "can Post to sessions and log a user in" do
    user_params = {
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "whatever@example.com",
      "password": "password"
    }

    user = User.create!(user_params)

    post '/api/v1/sessions', headers: headers, params: JSON.generate(params)
    login_json = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(login_json[:data].size).to eq(3)

    expect(login_json[:data]).to have_key(:id)
    expect(login_json[:data][:id]).to eq((user.id).to_s)

    expect(login_json[:data]).to have_key(:type)
    expect(login_json[:data][:type]).to eq('users')

    expect(login_json[:data]).to have_key(:attributes)
    expect(login_json[:data][:attributes].size).to eq(2)

    expect(login_json[:data][:attributes]).to have_key(:email)
    expect(login_json[:data][:attributes][:email]).to eq(user_params[:email])

    expect(login_json[:data][:attributes]).to have_key(:api_key)
    expect(login_json[:data][:attributes][:api_key]).to_not eq(nil)
  end

  it "can render a 400 status if email doesnt exist" do
    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "differentwhatever@example.com",
      "password": "password"
    }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":\"Given email address does not match our records, try again\"}")
  end

  it "can render a 200 status if request is successful" do
    user_params = {
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "whatever@example.com",
      "password": "password"
    }

    user = User.create!(user_params)

    post '/api/v1/sessions', headers: headers, params: JSON.generate(params)
    expect(response.status).to eq(200)
  end


  it "can render a 400 status if email doesnt exist" do
    user = User.create!(
      email: 'whatever@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    params = {
      "email": "#{user.email}",
      "password": "differentpassword"
    }

    post '/api/v1/sessions', headers: headers, params: JSON.generate(params)

    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":\"Something went wrong, Please Try Again\"}")
  end
end
