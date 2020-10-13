class Api::V1::StudentBooksController < ApplicationController
    
    def index 
        student_books = StudentBook.all
        render json: student_books, include: [:vocab_activities, :reading_tweets =>{include: [:character]}, :book => {include: [:characters]}], methods: :twitter_character
    end

    def show 
        student_book = StudentBook.find_by(id: params[:id])
        render json: student_book, include: [:vocab_activities, :reading_tweets =>{include: [:character]}, :book => {include: [:characters]}], methods: :twitter_character
    end

    def update 
        student_book = StudentBook.find_by(id: params[:id])
        student_book.update(currently_reading: false)
        student_book.save 

        render json: {message: "This book has been finished"}
    end

    def set_character 
        student_book = StudentBook.find_by(id: params[:student_book_id])
        student_book.update(character_id: params[:character_id])
        student_book.save

        render json: student_book, include: [:vocab_activities, :reading_tweets =>{include: [:character]}, :book => {include: [:characters]}], methods: :twitter_character
    end

    def currently_reading
        book_id = params["book_id"]
        student_id = params["user_id"].to_i

        student_book = StudentBook.find_by(student_id: student_id, book_id: book_id)
        student_book.update(currently_reading: true)
        student_book.save

        book = Book.find(book_id)
        render json: student_book, include: [:vocab_activities, :reading_tweets =>{include: [:character]}, :book => {include: [:characters]}], methods: :twitter_character
    end

    def load_current_book
        user = User.find_by(id: params[:user_id])
        student_book = StudentBook.find_by(id: user.current_book.id)
        render json: student_book, include: [:vocab_activities, :reading_tweets =>{include: [:character]}, :book => {include: [:characters]}], methods: :twitter_character
    end

    def remove_from_shelf
        sb = StudentBook.find_by(student_id: params[:student_id], book_id: params[:book_id])
        sb.destroy
        
        render json: {message: "This book has been removed from your shelf!"}
    end

    def change_character
        sb = StudentBook.find_by(id: params[:id])

        sb.character_id = nil
        sb.save

        render json: sb, include: [:vocab_activities, :reading_tweets =>{include: [:character]}, :book => {include: [:characters]}], methods: :twitter_character
    end

end
