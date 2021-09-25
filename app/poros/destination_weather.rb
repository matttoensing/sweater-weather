class DestinationWeather
  attr_reader :temperature, :conditions

  def initialize(data)
    @temperature = data[:current][:temp].round(1)
    @conditions = data[:current][:weather][0][:description]
  end
end
