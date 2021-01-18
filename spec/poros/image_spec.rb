require 'rails_helper'

RSpec.describe Image do
  it "can create an Image" do
    data = {
      :location=>'Denver City Colorado',
      :image_url=>"https://api.unsplash.com/search/photos?client_id=j-67o8PJj_7AB4rXNXz69ziyIfYQX9Pk162VcxCllYM&order_by=relevent&per_page=1&query=Denver%20City%20Colorado",
      :credit=> {
        :source=>"https://unsplash.com/",
        :author=>"melissamullinator",
        :logo=>"https://unsplash.com/blog/content/images/max/2560/1-VnKoValwGK3-d1bZhD6sVA.jpeg"
      }
    }
    image = Image.new(data)
    expect(image.location).to eq(data[:location])
    expect(image.image_url).to eq(data[:image_url])
    expect(image.credit).to eq(data[:credit])
  end
end
