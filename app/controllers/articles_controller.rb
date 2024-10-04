class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show update destroy ]
  # before_action :load_articles, only: %i[ index ]
  def index
    # @pagy, @articles = pagy_countless(Article.order(published_at: :desc), limit: 3)

    # render "scrollable_list" if params[:page]
    if params[:search]
      @search = Article.search(params[:search])
      @pagy, @articles = pagy_countless(@search.order(published_at: :desc), limit: 3)

      render "scrollable_list" if params[:page]
    elsif params[:category_id]
        @category = Category.includes(:articles).find(params[:category_id])
        @articles = @category.articles.order(published_at: :desc)

        @pagy, @articles = pagy_countless(@articles, limit: 3)

        render "scrollable_list" if params[:page]
    else
      @pagy, @articles = pagy_countless(Article.order(published_at: :desc), limit: 3)

      render "scrollable_list" if params[:page]
    end
  end

  def show
    @article
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(params.require(:article).permit(:title, :author, :published_at, :category_id, :body))
    @article.save!
    redirect_to root_path
  end

  def update
  end

  def destroy
  end

  def user
  end

  def admin
  end


  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :author)
  end
end
