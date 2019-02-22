# frozen_string_literal: true
json.status do |res|
  if response.present?
    res.code response.code || Response::Code::ERROR
    res.message response.message
    res.error_message response.error_message
  else
    res.code Response::Code::ERROR
    res.message ''
    res.error_message ''
  end
end
