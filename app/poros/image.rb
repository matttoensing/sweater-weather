class Image
  attr_reader :id, :image_url, :author, :author_url, :source

  def initialize(data)
    @id = nil
    @image_url = data[:urls][:full]
    @author = data[:user][:name]
    @author_url = data[:user][:portfolio_url]
    @source = 'unsplash.com'
  end
end
