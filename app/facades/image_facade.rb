class ImageFacade
  def self.create_image(query)
    json = UnsplashService.get_image_results(query)

    return nil if json[:total].zero?
    Image.new(json[:results][0], query)
  end
end
