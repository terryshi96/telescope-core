class User < ApplicationRecord

  include BaseModelConcern
  acts_as_paranoid
  before_create :generate_authentication_token
  # activemodel方法 需要bcrypt支持
  has_secure_password

  # 每个用户创建时会有一个token
  def generate_authentication_token
    loop do
      self.authentication_token = SecureRandom.base64(32)
      break if !User.find_by(authentication_token: authentication_token)
    end
  end

  def reset_auth_token!
    generate_authentication_token
    save
  end

  class << self
    def add_user params
      response = Response.rescue do |res|
        username, password, email = params[:username], params[:password], params[:email]
        self.create!(name: username, password: password, email: email)
      end
      response
    end

    def delete_users params
      response = Response.rescue do |res|
        users = User.find(params[:ids])
        users.each do |item|
          item.destroy
        end
      end
      response
    end

    def search_users params
      users = []
      count = 0
      response = Response.rescue do |res|
        page = params[:page] || 1
        per = params[:per] || 10
        users = search_by_params(params).page(page).per(per)
        count = User.all.count
      end
      [response, users, count]
    end

    def authorize_user params
      user = nil
      response = Response.rescue do |res|
        # Returns values that were assigned to the given keys
        account, password = params.values_at(:account, :password)
        user = User.where("users.email = :keyword or users.name = :keyword", keyword: account).first
        res.raise_error('User does not exist!') if user.blank?
        res.raise_error('Password Error!') if user.authenticate(password) == false
        # 根据用户的user_id生成对应的redis_key, 进行对象缓存
        object_key = user.authentication_token
        cache_object = user.to_json
        $redis.set("user_#{object_key}", cache_object) # 缓存拼接的user_session_key
        $redis.expire("user_#{object_key}", 720_000)
      end
      # log response
      [response, user]
    end

    def delete_token params
      response = Response.rescue do |res|
        User.transaction do
          user_session_key = params[:user_session_key]
          res.raise_error('No token found!') if user_session_key.blank?
          redis_user_key = "user_#{user_session_key}"
          res.raise_error('Token deleted error') if $redis.del(redis_user_key).to_s != '1'
        end
      end
    end



  end
end
