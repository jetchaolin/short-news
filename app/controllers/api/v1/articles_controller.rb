class Api::V1::ArticlesController < ApplicationController
  # before_action :set_article, only: %i[ show update destroy ]
  def index
    @articles = Article.order(published_at: :desc)

    render json: @articles
  end
end
