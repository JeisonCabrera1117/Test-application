class CreateUserPreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :user_preferences, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :preference, null: false, foreign_key: true, type: :uuid
      t.timestamps
    end
  end
end
