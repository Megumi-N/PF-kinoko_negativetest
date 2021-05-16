class CreateTwitterAnalyses < ActiveRecord::Migration[6.1]
  def change
    create_table :twitter_analyses do |t|

      t.timestamps
    end
  end
end
