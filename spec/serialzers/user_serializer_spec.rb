require 'rails_helper'

RSpec.describe UserSerializer do

  it "can serialize a user" do
    params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
    user = User.create!(params)
    user_json = UserSerializer.new(user).serializable_hash

    expect(user_json).to have_key(:data)

    expect(user_json[:data]).to have_key(:id)
    expect(user_json[:data][:id]).to eq((user.id).to_s)

    expect(user_json[:data]).to have_key(:type)
    expect(user_json[:data][:type]).to eq(:users)

    expect(user_json[:data]).to have_key(:attributes)
    expect(user_json[:data][:attributes].size).to eq(2)

    expect(user_json[:data][:attributes]).to have_key(:email)
    expect(user_json[:data][:attributes][:email]).to eq(user.email)

    expect(user_json[:data][:attributes]).to have_key(:api_key)
    expect(user_json[:data][:attributes][:api_key]).to be_a(String)
  end
end
