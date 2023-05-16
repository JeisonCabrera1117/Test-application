class Preference < ApplicationRecord
  before_destroy :check_for_dependencies

  validates :description, presence: true
  has_many :user_preferences

  def check_for_dependencies
    if user_preferences.any?
      errors.add(:base, 'This post cannot be deleted because there are users who have these preferences selected')
      throw :abort
    end
  end
end
