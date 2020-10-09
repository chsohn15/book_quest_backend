class Api::V1::BooksController < ApplicationController

    def index 
        books = Book.all 
        render json: books
    end 

    def create
        book = Book.create(book_params)
        render json: book 
    end

    private 
    
    def book_params 
        params.permit(:title, :author, :ISBN_number, :image_url, :total_pages)
    end
end
