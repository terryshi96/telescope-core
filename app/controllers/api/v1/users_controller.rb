class Api::V1::UsersController < ApplicationController
  skip_before_action :authentication_user, only: [:sign_in]

  def sign_in
    @response, @user = User.authorize_user params
  end
end
