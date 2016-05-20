module V1
  class ArticlesController < ApplicationController
    set_pagination_headers :articles, only: [:index]
    load_and_authorize_resource

    # GET /api/v1/articles
    # GET /api/v1/articles.json
    def index
      @articles = @articles.includes(:role).paginate(page: params[:page])
    end

    # POST /api/v1/articles
    # POST /api/v1/articles.json
    def create
      @article = Article.new(article_params)
      @article.author = current_user
      if @article.save
        render :show, status: :created
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /api/v1/articles/1
    # PATCH/PUT /api/v1/articles/1.json
    def update
      if @article.update(article_params)
        render :show
      else
        render json: { errors: @article.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/articles/1
    # DELETE /api/v1/articles/1.json
    def destroy
      @article.destroy

      head :no_content
    end

    private

    def article_params
      params.require(:article).permit(:title, :description, :image)
    end
  end
end
