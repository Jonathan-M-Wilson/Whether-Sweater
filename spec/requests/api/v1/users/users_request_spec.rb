require "rails_helper"

RSpec.describe "User Endpoint" do
  before :each do
    User.destroy_all
  end

  it "can Post to users and create a user in db" do
    params = {
      email: 'testing@example.com',
      password: 'password',
      password_confirmation: 'password'
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    user = User.last
    expect(user.email).to eq(params[:email])

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(response.content_type).to eq('application/json; charset=utf-8')

    user_json = JSON.parse(response.body, symbolize_names: true)

    expect(user_json[:data][:type]).to eq('users')
    expect(user_json[:data]).to have_key(:id)
    expect(user_json[:data][:attributes][:email]).to eq(params[:email])
    expect(user_json[:data][:attributes]).to have_key(:api_key)
  end

  it "can render a 400 status if fields are left blank " do
    params = {
      email: 'testing@example.com',
      password: '',
      password_confirmation: 'password'
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":\"Missing required information: Fields cannot be blank\"}")
  end

  it "can render a 400 status if email is in use" do
    user = User.create!(
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'password'
    )

    params = {
      email: "#{user.email}",
      password: 'password',
      password_confirmation: 'password'
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":\"Account with this email already exists\"}")
  end

  it "can render a 400 status if passwords do not match" do
    params = {
      email: 'user@example.com',
      password: 'password',
      password_confirmation: 'differentpassword'
    }

    headers = {
      'content-type': 'application/json',
      'Accept': 'application/json'
    }

    post '/api/v1/users', headers: headers, params: JSON.generate(params)

    expect(response.status).to eq(400)
    expect(response.body).to eq("{\"error\":\"Passwords do not match\"}")
  end
end
