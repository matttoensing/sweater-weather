require 'rails_helper'

 RSpec.describe Book do
   it 'exists and has attributes' do
     attributes = {
            title: "Denver, Co",
            title_suggest: "Denver, Co",
            isbn: [
                "9780762507849",
                "0762507845"
            ],
            publisher: [
                "Universal Map Enterprises"
            ]
        }

     book = Book.new(attributes)

    expect(book).to be_an_instance_of(Book)
    expect(book.isbn).to eq(attributes[:isbn])
    expect(book.title).to eq(attributes[:title])
    expect(book.publisher).to eq(attributes[:publisher])
   end
 end
