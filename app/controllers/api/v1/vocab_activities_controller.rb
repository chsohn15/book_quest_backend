class Api::V1::VocabActivitiesController < ApplicationController

    def index 
        vocab_activities = VocabActivity.all 
        render json: vocab_activities, include: [:student_book => {only: [:id], include: [:book => {only: [:id, :title]}]}]
    end

    def create 
        vocab_activity = VocabActivity.create(vocab_params_1)
        user = User.find_by(id: params[:user_id])
        all_vocab = user.all_vocab
        render json: all_vocab
    end

    private 

    def vocab_params_1
        params.permit(:student_book_id, :word, :definition, :original_sentence, :sentence_from_book, :point_value)
    end
end
