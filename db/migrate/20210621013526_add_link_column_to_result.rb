class AddLinkColumnToResult < ActiveRecord::Migration[6.1]
  def change
    add_column :results, :link, :text, null: false
  end
end
