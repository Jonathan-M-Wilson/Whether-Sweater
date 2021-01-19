class Restaurant
  attr_reader :name,
              :address

  def initialize(params)
    @name = params[:name]
    @address = params[:location][:display_address].join(', ')
  end
end
