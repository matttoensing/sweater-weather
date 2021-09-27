class Weather
  attr_reader :summary, :temperature

  def initialize(data)
    @summary = data[:weather][0][:description]
    @temperature = data[:temp].round(1)
  end
end
