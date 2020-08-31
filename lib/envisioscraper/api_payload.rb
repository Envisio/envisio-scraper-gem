module EnvisioScraper
  class ApiPayload
    class InvalidPayloadError < StandardError; end

    attr_reader :payload

    def initialize(payload, payload_signature_keys)
      @payload                = payload
      @payload_signature_keys = payload_signature_keys
    end

    def self.for_check_status(payload)
      required_keys = [:id]

      raise InvalidPayloadError.new("Required payload keys: #{required_keys}") if (required_keys - payload.keys).count > 0

      new(payload, required_keys)
    end

    def self.for_scrape(payload)
      required_keys = [:scrape_url, :async, :callback_url]

      raise InvalidPayloadError.new("Required payload keys: #{required_keys}") if (required_keys - payload.keys).count > 0

      new(payload, required_keys)
    end

    def payload_signature
      Digest::SHA256.hexdigest(payload_string)
    end

    private def payload_string
      @payload_signature_keys.map { |k| "#{k}=#{@payload[k]}" }.join('::')
    end
  end
end
