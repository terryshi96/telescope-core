# frozen_string_literal: true
$redis = Redis::Namespace.new(RedisSetting.name_space, redis: Redis.new(url: "redis://:#{RedisSetting.password}@#{RedisSetting.host}:#{RedisSetting.port}/#{RedisSetting.db}"))
