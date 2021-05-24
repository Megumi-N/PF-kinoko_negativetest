class CreateWiseSayings < ActiveRecord::Migration[6.1]
  def change
    create_table :wise_sayings do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.string :person, null: false
      t.belongs_to :result, null: false, foreign_key: true

      t.timestamps
    end
  end
end
