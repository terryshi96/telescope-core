class Api::V1::UsersController < ApplicationController
  skip_before_action :authentication_user, only: [:sign_in]

  def sign_in
    @response, @user = User.authorize_user params
  end

  def sign_out
    @response = User.delete_token params
  end

  def create
    @response = User.add_user params
  end
end
