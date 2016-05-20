module V1
  class PinsController < ApplicationController
    before_action :set_pin, only: :destroy
    skip_before_action :check_arguments

    load_and_authorize_resource :article
    load_and_authorize_resource through: :article

    # GET /api/v1/articles/:article_id/pins
    # GET /api/v1/articles/:article_id/pins
    def index
      @pins = @pins.page(params[:page])
    end

    # GET /api/v1/articles/:article_id/pins/count
    # GET /api/v1/articles/:article_id/pins/count.json
    def count
      render json: { count: @article.pins.count }
    end

    # POST /api/v1/articles/:article_id/pins
    # POST /api/v1/articles/:article_id/pins.json
    def create
      @pin = Pin.new(user: current_user, article: @article)

      if @pin.save
        render json: @pin, status: :created
      else
        render json: { errors: @pin.errors }, status: :unprocessable_entity
      end
    end

    # DELETE /api/v1/articles/:article_id/pins/1
    # DELETE /api/v1/articles/:article_id/pins/1.json
    def destroy
      @pin.destroy

      head :no_content
    end

    private

    def set_pin
      @pin = Pin.find(params[:id])
    end
  end
end
