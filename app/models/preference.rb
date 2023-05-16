class Preference < ApplicationRecord
  validates :description, presence: true
end
