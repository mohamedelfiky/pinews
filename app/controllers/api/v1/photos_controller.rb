class Api::V1::PhotosController < ApplicationController
  before_action :set_photo, only: [:update, :destroy]
  load_and_authorize_resource :article
  load_and_authorize_resource :through => :article


  # GET /api/v1/articles/:article_id/photos
  # GET /api/v1/articles/:article_id/photos.json
  def index
    render json: @article.photos
  end


  # POST /api/v1/articles/:article_id/photos
  # POST /api/v1/articles/:article_id/photos.json
  def create
    @photo = Photo.new(photo_params)
    @photo.article = @article

    if @photo.save
      render json: @photo, status: :created
    else
      render json: {errors: @photo.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/articles/:article_id/photos/1
  # PATCH/PUT /api/v1/articles/:article_id/photos/1.json
  def update
    @photo = Photo.find(params[:id])

    if @photo.update(photo_params)
      head :no_content
    else
      render json: {errors: @photo.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/articles/:article_id/photos/1
  # DELETE /api/v1/articles/:article_id/photos/1.json
  def destroy
    @photo.destroy

    head :no_content
  end

  private
  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :image)
  end


end
