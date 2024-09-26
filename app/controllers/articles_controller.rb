class ArticlesController < ApplicationController
  # before_action :set_article, only: %i[ show update destroy ]
  # before_action :load_articles, only: %i[ index ]
  def index
    @pagy, @articles = pagy_countless(Article.order(published_at: :desc), limit: 3)

    render "scrollable_list" if params[:page]
  end

  def show
  end

  def create
  end

  def update
  end

  def delete
  end
end
