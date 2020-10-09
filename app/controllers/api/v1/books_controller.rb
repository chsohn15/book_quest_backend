class Api::V1::BooksController < ApplicationController

    def index 
        books = Book.all 
        render json: books
    end 

    def create

        book = Book.find_or_create_by(book_params)
        user = User.find_by(id: params[:user_id])

        if user.validate_book(book) 
            render json: book 
        else    
            render json: {error: "You already have this book on your shelf!"}
        end
    end

    private 
    
    def book_params 
        params.permit(:title, :author, :ISBN_number, :image_url, :total_pages)
    end
end
