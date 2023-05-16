class CreateSurveyQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_questions, id: :uuid do |t|
      t.string :description
      t.integer :position
      t.timestamps
    end
  end
end
