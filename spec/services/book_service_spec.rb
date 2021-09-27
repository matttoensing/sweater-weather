require 'rails_helper'

 RSpec.describe BookService do
   it 'can get information of books based off of title and quantity arguments', :vcr do
     json = BookService.get_book_info('denver,co', 5)

     expect(json).to have_key(:numFound)
     expect(json[:numFound].class).to eq(Integer)
     expect(json).to have_key(:docs)
     expect(json[:docs].class).to eq(Array)
     expect(json[:docs].count).to eq(5)
     json[:docs].each do |book|
       expect(book).to have_key(:title)
       expect(book[:title].class).to eq(String)
       expect(book).to have_key(:isbn)
       expect(book[:isbn].class).to eq(Array)
       expect(book).to have_key(:publisher)
       expect(book[:publisher].class).to eq(Array)
       expect(book).to have_key(:author_name)
       expect(book[:author_name].class).to eq(Array)
     end
   end
 end
