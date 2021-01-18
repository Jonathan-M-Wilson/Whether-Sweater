require 'rails_helper'

RSpec.describe ImageSerializer do
  it "can serialize an image" do

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

    serialized = ImageSerializer.new(image).serializable_hash

    expect(serialized).to have_key(:data)
    expect(serialized[:data]).to have_key(:id)
    expect(serialized[:data]).to have_key(:type)
    expect(serialized[:data]).to have_key(:attributes)
    expect(serialized[:data][:attributes]).to have_key(:image)
    expect(serialized[:data][:attributes][:image]).to have_key(:location)
    expect(serialized[:data][:attributes][:image]).to have_key(:image_url)
    expect(serialized[:data][:attributes][:image]).to have_key(:credit)
    expect(serialized[:data][:attributes][:image][:credit]).to have_key(:source)
    expect(serialized[:data][:attributes][:image][:credit]).to have_key(:author)
    expect(serialized[:data][:attributes][:image][:credit]).to have_key(:logo)
  end
end
