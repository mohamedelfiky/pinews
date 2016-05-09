class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  set_pagination_headers :users, only: [:index]
  load_and_authorize_resource

  # GET /api/v1/users
  # GET /api/v1/users.json
  def index
    @users = User.all.paginate(:page => params[:page])
  end


  # POST /api/v1/users
  # POST /api/v1/users.json
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  # PATCH/PUT /api/v1/users/1.json
  def update
    @user = User.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?

    if @user.update_attributes(user_params)
      head :no_content
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  # DELETE /api/v1/users/1.json
  def destroy
    @user.destroy

    head :no_content
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :password, :password_confirmation, :role_id)
  end
end
