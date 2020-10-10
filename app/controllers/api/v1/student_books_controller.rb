class Api::V1::StudentBooksController < ApplicationController
    
    def index 
        student_books = StudentBook.all
        render json: student_books
    end

    def show 
        student_book = StudentBook.find_by(id: params[:id])
        render json: student_book
    end

    def update 
        student_book = StudentBook.find_by(id: params[:id])
        student_book.update(currently_reading: false)
        student_book.save 

        render json: {message: "This book has been finished"}
    end

    def currently_reading
        book_id = params["book_id"]
        student_id = params["user_id"].to_i

        student_book = StudentBook.find_by(student_id: student_id, book_id: book_id)
        student_book.update(currently_reading: true)
        student_book.save

        book = Book.find(book_id)
        render json: student_book, include: [:book => {include: [:characters]}]
    end


end
