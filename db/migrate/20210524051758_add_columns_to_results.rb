class AddColumnsToResults < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :image, :string
    add_column :results, :level, :integer
    add_column :results, :description, :text
  end
end
