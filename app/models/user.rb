class User < ApplicationRecord
    has_many :shelves

    #custom initialize that includes creating shelves? everyone should start with a wishlist shelf and a read books shelf


    def add_book(shelf, book)
        shelf.add_book(book)
    end

    def add_book_by_name(shelf, book_name)
        shelf.add_book_by_name
    end

    def books
        self.shelves.collect do |shelf|
            shelf.books
        end.flatten
    end

end
