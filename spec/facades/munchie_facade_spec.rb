require 'rails_helper'

RSpec.describe MunchieFacade do
  it "can create munchie objects with attributes" do

    start_city = 'Pueblo,Co'
    end_city = 'Denver,Co'
    food = 'chinese'

    munchie = MunchieFacade.munchie(start_city, end_city, food)

    expect(munchie).to be_an_instance_of(Munchie)
  end
end
