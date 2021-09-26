class UnsplashService < BaseService
  def self.get_image_results(query)
    response = conn('https://api.unsplash.com').get('/search/photos') do |f|
      f.params['client_id'] = ENV['unsplash_key']
      f.params['query'] = query
    end
    get_json(response)
  end
end
