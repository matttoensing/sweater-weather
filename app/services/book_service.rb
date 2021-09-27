class BookService < BaseService
  def self.get_book_info(query, quantity)
    response = conn('http://openlibrary.org').get('/search.json') do |f|
      f.params['q'] = query
      f.params['limit'] = quantity
    end
    get_json(response)
  end
end
