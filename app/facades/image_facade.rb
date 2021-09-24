class ImageFacade
  def self.create_image(query)
    json = UnsplashService.get_image_results(query)
    Image.new(json)
  end
end
