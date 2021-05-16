class CreateResults < ActiveRecord::Migration[6.1]
  def change
    create_table :results do |t|
      t.string :name, null: false
      t.string :feature, null: false
      t.text :contents, null: false

      t.timestamps
    end
  end
end
