# frozen_string_literal: true
class RedisSetting < Settingslogic
  source "#{Rails.root}/config/redis.yml"
  namespace Rails.env
end
