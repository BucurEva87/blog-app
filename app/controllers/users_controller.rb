class UsersController < ApplicationController
  helper PostsHelper

  def index
    @users = User.all
  end

  def show
    @user = User.find(params['id'])
  end
end
