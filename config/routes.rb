Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do 
    namespace :v1 do 
      resources :users
      resources :books
      resources :student_books
      resources :characters
      resources :reading_tweets

      post '/login', to: "auth#create"
      post '/current_book', to: "student_books#currently_reading"
      post '/set_character', to: "student_books#set_character"
      post '/add_tweet', to: "reading_tweets#add_tweet"
      post '/load_current_book', to: "student_books#load_current_book"
      post '/remove_from_shelf', to: "student_books#remove_from_shelf"
    end 
  end
end
