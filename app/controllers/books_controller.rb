class BooksController < ApplicationController
    def remove_book(shelf, active_user)
        if shelf.books.empty?
            puts "\nThis shelf is empty!"
        else
            puts `clear`
            puts "Which book should we remove? Please enter a number:"
            shelf.view_shelf_contents
            book_index = STDIN.gets.chomp.to_i - 1
            book = shelf.books[book_index] #grab that book instance off their shelf
            shelf.remove_book_from_shelf(book) #calling the shelf instance method called remove_book_from_shelf
            active_user = update_user_variable(active_user)
            puts "\nYou have successfully removed #{book.title} from #{shelf.name}."
            puts "\nShelf contents: "
            shelf.view_shelf_contents
        end
        active_user
    end
    
    def add_book(shelf)#takes a shelf instance, and calls on the shelf instance method, add_book
        book = Book.find_book #will return a book instance if the user was successful, or nil if they gave up
        shelf.add_book_to_shelf(book) if book
        STDIN.gets.chomp
    end

end
