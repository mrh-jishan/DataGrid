class ProfilesController < ApplicationController

  before_action :set_user

  def index

  end

  def edit

  end

  def update

  end

  def generate_token
    @user.generate_api_token
    respond_to do |format|
      if @user.save
        format.html { redirect_to profiles_path, notice: 'Api token added successfully.' }
      else
        format.html { redirect_to profiles_path, error: 'Api token added unsuccessfully.' }
      end
    end

    # if @user.save
    #   render json: { token: @user.token }, status: :ok
    # else
    #   render json: @user.errors, status: :unprocessable_entity
    # end
  end

  private

  def set_user
    @user = current_user
  end

end
