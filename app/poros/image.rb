class Image
  attr_reader :id,
              :location,
              :image_url,
              :author,
              :author_url,
              :source

  def initialize(data, location)
    @id = nil
    @location = location
    @image_url = data[:urls][:full]
    @author = data[:user][:name]
    @author_url = data[:user][:portfolio_url]
    @source = 'unsplash.com'
  end
end
