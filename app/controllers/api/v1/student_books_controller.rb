class Api::V1::StudentBooksController < ApplicationController
    def index 
        student_books = StudentBook.all
        render json: student_books
    end
end
