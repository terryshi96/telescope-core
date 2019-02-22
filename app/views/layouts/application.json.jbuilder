# frozen_string_literal: true
json.partial! 'common/response_status', response: @response
if @response.code == Response::Code::SUCCESS
  json.data do
    json.merge! JSON.parse(yield)
  end
end

