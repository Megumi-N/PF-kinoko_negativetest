class CreateResultWiseSayings < ActiveRecord::Migration[6.1]
  def change
    create_table :result_wise_sayings do |t|
      t.references :result, null: false, foreign_key: true
      t.references :wise_saying, null: false, foreign_key: true

      t.timestamps
    end
  end
end
