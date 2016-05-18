module Requests
  module JsonHelpers
    def json
      if response.status != 204
        JSON.parse(response.body)
      else
        true
      end
    end
  end
end
