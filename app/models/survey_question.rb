class SurveyQuestion < ApplicationRecord
  validates :description, presence: true
end
