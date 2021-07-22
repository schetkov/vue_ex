# frozen_string_literal: true

module JsonResponseHelper
  def response_json
    JSON.parse(response.body)
  rescue StandardError
    {}
  end
end
