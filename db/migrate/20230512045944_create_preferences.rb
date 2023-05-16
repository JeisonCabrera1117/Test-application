class CreatePreferences < ActiveRecord::Migration[6.1]
  def change
    create_table :preferences, id: :uuid do |t|
      t.string :description
      t.timestamps
    end
  end
end
