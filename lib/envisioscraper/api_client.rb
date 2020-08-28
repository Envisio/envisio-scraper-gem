require 'uri'

module EnvisioScraper
  class ApiClient
    class ApiTimeOutError < StandardError; end
    class ApiError < StandardError; end

    JWT_SIGNING_ALGORITHM = 'HS512'

    attr_accessor :config

    attr_accessor :default_headers

    def initialize(config = Configuration.default)
      @config = config
      @default_headers = { 'Content-Type' => 'application/json' }
    end

    def self.default
      @@default ||= ApiClient.new
    end

    def ping
      request = Typhoeus::Request.new(
        build_request_url,
        { method: 'get', headers: @default_headers, verbose: @config.debugging }
      )

      request.run
    end

    def request(method:, uri:, payload:)
      auth_token = JWT.encode(
        { token: @config.api_key, signature: payload.payload_signature }.deep_stringify_keys,
        @config.api_secret,
        JWT_SIGNING_ALGORITHM
      )

      Rails.logger.ap('auth token')

      header_params = @default_headers.merge({
        'Authorization' => "BASE #{auth_token}"
      })

      req_opts = {
        method: method,
        headers: header_params,
        params: payload.payload,
        verbose: @config.debugging
      }

      request = Typhoeus::Request.new(build_request_url(path: uri), req_opts)

      response = request.run

      if @config.debugging
        @config.logger.debug "HTTP response body ~BEGIN~\n#{response.body}\n~END~\n"
      end

      unless response.success?
        if response.timed_out?
          raise ApiTimeOutError.new
        elsif response.code == 0
          raise ApiError.new(response.return_message)
        else
          raise ApiError.new("HTTP request failed: " + response.code.to_s)
        end
      end

      response
    end

    private def build_request_url(path: '')
      slashed_path = "/#{path}".gsub(/\/+/, '/')
      URI.encode(@config.base_url + slashed_path)
    end

  end
end
