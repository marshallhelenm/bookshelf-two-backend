class Shelf < ApplicationRecord
    belongs_to :user
    has_many :shelfjoins
    has_many :books, through: :shelfjoins

    def rename(name)
        self.name = name
        self.save
    end

    def authors
        authors = self.books.collect do |book|
            book.author
        end
        authors.uniq
    end

    def remove_book_from_shelf(book)
        connection = Shelfjoin.all.find do |join|
            join.shelf_id == self.id && join.book_id == book.id
        end
        connection.delete
        self.books.delete(book)
    end

    def add_book_to_shelf(book)#accepts a book instance - so this is really a helper method
        self.books << book
        self.save
    end

    def edit_description(description)
        self.description = description
        self.save
    end
end
