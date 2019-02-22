# frozen_string_literal: true
module BaseModelConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def execute_sql(sql)
      ActiveRecord::Base.connection.select_all sql.to_s
    end

    def current_user(user_session_key)
      user_string = $redis.get(user_session_key)
      user = JSON.parse(user_string, object_class: OpenStruct)
      user
    end

    # 区分化显示数据的信息
    #
    # @param message [String, nil] ruby 对象
    # @param block [Block] 块
    #
    def log(message = nil, &block)
      Rails.logger.info '-' * 80
      Rails.logger.info message.to_json, &block
      Rails.logger.info '-' * 80
    end
  end

end