require 'uri'

module EnvisioScraper
  class Configuration
    attr_accessor :scheme

    attr_accessor :host

    attr_accessor :base_path

    attr_accessor :api_key

    attr_accessor :api_secret

    # Set this to enable/disable debugging. When enabled (set to true), HTTP request/response
    # details will be logged with `logger.debug` (see the `logger` attribute).
    # Default to false.
    #
    # @return [true, false]
    attr_accessor :debugging

    # Defines the logger used for debugging.
    # Default to `Rails.logger` (when in Rails) or logging to STDOUT.
    #
    # @return [#debug]
    attr_accessor :logger

    def initialize
      @scheme = 'https'
      @host = 'envisio-web-scraper.herokuapp.com'
      @base_path = '/'
      @api_key = nil
      @api_secret = nil
      @debugging = false
      @logger = defined?(Rails) ? Rails.logger : Logger.new(STDOUT)

      yield(self) if block_given?
    end

    def base_url
      "#{@scheme}://#{[@host, @base_path].join('/').gsub(/\/+/, '/')}".sub(/\/+\z/, '')
    end

    # The default Configuration object.
    def self.default
      @@default ||= Configuration.new
    end

    def configure
      yield(self) if block_given?
    end
  end
end
