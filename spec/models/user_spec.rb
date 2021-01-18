require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end

  describe 'methods' do
    it "When a user is created, it is created with an api key" do
      user = User.create!(
        email: 'user@example.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.api_key.nil?).to eq(false)
    end
  end
end
