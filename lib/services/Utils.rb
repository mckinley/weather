module Services
  class Utils
    def self.parse_json(response)
      unless response.success?
        raise ApiError.new(response.status, response.body)
      end
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
