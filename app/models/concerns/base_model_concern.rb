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

    def search_by_params(options= {})
      result = self.all
      if options.present?
        keys = options.keys
        keys.delete(:page)
        keys.delete(:per)
        keys.each do |key|
          value = options[key]
          if value.present? || value.to_s.length > 0

            # 排序
            if key == :order || key == 'order'
              # todo 实现排序查询
            # 模糊查询
            elsif key.to_s.include?('like_')
              attr_key = key.to_s.gsub('like_', '')
              result = result.where("#{self.name.tableize}.#{attr_key} like ?", "%#{value}%") if self.attribute_names.include?(attr_key)
            else
              result = result.where(key.to_sym => value) if self.instance_methods.include?(key) || self.attribute_names.include?(key.to_s)
            end

          end
        end
      end
      result
    end

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