class CreateSurveyAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :survey_answers, id: :uuid do |t|
      t.references :survey, null: false, foreign_key: true, type: :uuid
      t.references :survey_question, null: false, foreign_key: true, type: :uuid
      t.string :answer
      t.timestamps
    end
  end
end
