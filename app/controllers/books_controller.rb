class BooksController < ApplicationController
    def index
        
    end
    
    def create
        book = Book.new(title: book_params[title], description: book_params[description])
        book.save
    end
    
    def edit
    
    end
    
    def update
    
    end
    
    def show
    
    end
    
    def destroy
    
    end

    def add_to_shelf(shelf)
        shelf.books << self
    end

    private

    def book_params
        params.require(:book).permit(:title, :description, :id)
    end
end
