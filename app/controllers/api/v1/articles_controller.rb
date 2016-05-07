class Api::V1::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :update, :destroy]
  before_filter :check_arguments, only: [:create, :update]
  before_action :authenticate_current_user, except: [:index, :show]

  set_pagination_headers :articles, only: [:index]
  load_and_authorize_resource

  # GET /api/v1/articles
  # GET /api/v1/articles.json
  def index
    @articles = Article.includes(:role).paginate(:page => params[:page])
  end


  # POST /api/v1/articles
  # POST /api/v1/articles.json
  def create
    @article = Article.new(article_params)
    @article.author = current_user
    if @article.save
      render json: @article, status: :created
    else
      render json: {errors: @article.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/articles/1
  # PATCH/PUT /api/v1/articles/1.json
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      head :no_content
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/articles/1
  # DELETE /api/v1/articles/1.json
  def destroy
    @article.destroy

    head :no_content
  end

  private
  def check_arguments
    return missing_arguments(:article) unless params[:article]
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description, :image)
  end
end
