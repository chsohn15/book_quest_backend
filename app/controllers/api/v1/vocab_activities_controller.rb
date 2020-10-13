class Api::V1::VocabActivitiesController < ApplicationController

    def index 
        vocab_activities = VocabActivity.all 
        render json: vocab_activities
    end
end
