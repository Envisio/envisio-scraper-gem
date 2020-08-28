module EnvisioScraper
  class ApiPayload
    attr_reader :payload

    def initialize(payload, payload_signature_keys)
      @payload                = payload
      @payload_signature_keys = payload_signature_keys
    end

    def payload_signature
      Digest::SHA256.hexdigest(payload_string)
    end

    private def payload_string
      @payload_signature_keys.map { |k| "#{k}=#{@payload[k]}" }.join('::')
    end
  end
end
