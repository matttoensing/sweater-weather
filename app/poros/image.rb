class Image
  attr_reader :id,
              :location,
              :image_url,
              :credit

  def initialize(data, location)
    @id = nil
    @location = location
    @image_url = data[:urls][:full]
    @credit = credit_photographer(data[:user])
  end

  def credit_photographer(data)
    {
      author_profile_url: data[:links][:self],
      author_url: data[:portfolio_url],
      source: 'unsplash.com'
    }
  end
end
