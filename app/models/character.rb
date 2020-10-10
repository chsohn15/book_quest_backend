class Character < ApplicationRecord
    belongs_to :book, optional: true
    has_many :reading_tweets
end
