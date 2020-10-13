class Api::V1::VocabActivitiesController < ApplicationController

    def index 
        vocab_activities = VocabActivity.all 
        render json: vocab_activities, include: [:student_book => {only: [:id], include: [:book => {only: [:id, :title]}]}]
    end

    def create 
        vocab_activity = VocabActivity.create(vocab_params_1)

        render json: vocab_activity, include: [:student_book => {only: [:id], include: [:book => {only: [:id, :title]}]}]
    end

    private 

    def vocab_params_1
        params.permit(:student_book_id, :word, :definition, :original_sentence)
    end
end
