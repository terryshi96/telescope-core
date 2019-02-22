# 标准化接口返回格式
class Response
  include BaseModelConcern
  # 添加属性
  attr_accessor :code, :message, :error_message

  module Code
    ERROR = 50000
    SUCCESS = 20000
  end

  def initialize(code = Code::SUCCESS, message = '', error_message = '')
    @code = code
    @message = message
    @error_message = error_message
  end

  def raise_error(message = '')
    self.code = Code::ERROR
    self.message = message
  end

  def self.rescue
    response = self.new
    begin
      yield(response)
    rescue => e
      log e
      response.code = Code::ERROR
      response.error_message = e.message
    end
    response
  end
  
end

