class RemoveTitleToWiseSayings < ActiveRecord::Migration[6.1]
  def change
    remove_column :wise_sayings, :title, :string
  end
end
