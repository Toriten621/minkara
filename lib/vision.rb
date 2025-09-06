require 'net/http'
require 'json'
require 'base64'

module Vision
  class << self
    def get_image_data(image_file)
      api_url = URI("https://vision.googleapis.com/v1/images:annotate?key=#{ENV['GOOGLE_API_KEY']}")

      base64_image =
        if image_file.respond_to?(:read)
          Base64.strict_encode64(image_file.read)
        else
          Base64.strict_encode64(image_file)
        end

      params = {
        requests: [
          {
            image: { content: base64_image },
            features: [{ type: "LABEL_DETECTION", maxResults: 5 }]
          }
        ]
      }

      http = Net::HTTP.new(api_url.host, api_url.port)
      http.use_ssl = true
      request = Net::HTTP::Post.new(api_url.request_uri, { "Content-Type" => "application/json" })
      request.body = params.to_json

      response = http.request(request)
      result = JSON.parse(response.body)

      Rails.logger.info("Vision API response: #{result}")

      if result["responses"].present? &&
         result["responses"][0].present? &&
         result["responses"][0]["labelAnnotations"].present?
        result["responses"][0]["labelAnnotations"].map { |ann| ann["description"] }
      else
        []
      end
    end
  end
end
