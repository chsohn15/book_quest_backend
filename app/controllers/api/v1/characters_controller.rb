class Api::V1::CharactersController < ApplicationController

    def index
        characters = Character.all 
        render json: characters, include: [:student_books =>{include: [:book]}]
    end
    
    def create 
        character = Character.create(character_params)
        render json: character, include: [:student_books =>{include: [:book]}]
    end

    private 

    def character_params 
        params.require(:character).permit(:name, :image_url)
    end

end
