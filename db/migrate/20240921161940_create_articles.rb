class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :author
      t.datetime :published_at, null: false
      t.string :body, null: false
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
