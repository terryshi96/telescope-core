class User < ApplicationRecord

  include BaseModelConcern

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

  def self.authorize_user params
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
    log response
    [response, user]
  end

end
