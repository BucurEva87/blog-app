class UsersController < ApplicationController
  helper PostsHelper

  def index
    @current_user = current_user
    @users = User.all
  end

  def show
    @current_user = current_user
    @user = User.find(params['id'])
  end
end
