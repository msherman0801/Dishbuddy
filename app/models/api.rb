require 'net/http'
require 'uri'
class Api < ActiveRecord::Base

    def self.fetch(search)
        uri = URI.parse(search)
        request = Net::HTTP::Get.new(uri)
        request["Accept"] = "application/json"
        request["User-Key"] = "39afd3aaab582bc7b43ec509328c39dc"
        req_options = {
          use_ssl: uri.scheme == "https",
        }
        response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
          http.request(request)
        end
        JSON.parse(response.body)
      end

end