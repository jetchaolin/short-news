require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

  test "should not save article without title" do
    article = Article.new
    assert_not article.save
  end

  test "should not save article without published_at" do
    article = Article.new(title: "a")
    assert_not article.save
  end

  test "should not save article without body" do
    article = Article.new(title: "a", published_at: Time.current)
    assert_not article.save
  end

  test "should not save article without category" do
    article = Article.new(title: "a", author: "a", published_at: Time.current, body: "a")

    assert_not article.save
  end

  test "should create article correctly " do
    category = Category.create!(name: "test")
    article = Article.new(title: "a", author: "a", published_at: Time.current, category_id: category.id, body: "a")

    assert article.valid?
  end
end
