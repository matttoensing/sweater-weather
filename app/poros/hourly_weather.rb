class HourlyWeather
  attr_reader :time, :temperature, :conditions, :icon

  def initialize(info)
    @time = info[:time]
    @temperature = info[:temp_f]
    @conditions = info[:condition][:text]
    @icon = info[:condition][:icon]
  end
end
