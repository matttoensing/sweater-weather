class Image
  attr_reader :id, :image_url, :author, :author_url, :source

  def initialize(data)
    @id = nil
    @image_url = data[:results][0][:urls][:full]
    @author = data[:results][0][:user][:name]
    @author_url = data[:results][0][:user][:portfolio_url]
    @source = 'unsplash.com'
  end
end
