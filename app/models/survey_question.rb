class SurveyQuestion < ApplicationRecord
  before_destroy :check_for_dependencies
  validates :description, presence: true

  has_many :survey_answers

  def check_for_dependencies
    if survey_answers.any?
      errors.add(:base, 'This post cannot be deleted because there are users who have these survey answrs selected')
      throw :abort
    end
  end
end
