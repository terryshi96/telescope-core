# frozen_string_literal: true
module BaseModelConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def execute_sql(sql)
      ActiveRecord::Base.connection.select_all sql.to_s
    end

    # 用于在model中获取user
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

    # 利用openssl获取过期日期
    def get_expire_date(domain)
       expire_date = `echo | openssl s_client -servername #{domain} -connect #{domain}:443 2>/dev/null | openssl x509 -noout -dates | grep 'After' | awk -F '=' '{print $2}' | awk -F ' +' '{print $1,$2,$4 }'`
    end

    # 计算跟过期日期相差的天数
    def expire_days(expire_date)
       days = (expire_date.to_date - Time.now.to_date).to_i
    end

  end

end