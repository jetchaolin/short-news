class ChangeColumnCategoryNullFromArticle < ActiveRecord::Migration[7.2]
  def change
    change_column_null :articles, :category_id, false
  end
end
