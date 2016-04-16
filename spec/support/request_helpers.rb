module Requests
  module JsonHelpers
    def json
      begin
        if response.status != 204
          JSON.parse(response.body)
        else
          true
        end
      rescue
        puts response.inspect
      end
    end
  end
end
