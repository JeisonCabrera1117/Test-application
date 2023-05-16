Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  draw :users
  draw :preferences
  draw :preference_users
  draw :surveys
  draw :survey_answers
  draw :survey_questions
  root to: 'dashboard#show'
end
