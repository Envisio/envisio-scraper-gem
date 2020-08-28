require "envisioscraper/version"
require 'envisioscraper/configuration'
require 'envisioscraper/api_payload'
require 'envisioscraper/api_client'

require 'envisioscraper/api/scrape_api.rb'

module EnvisioScraper
  class Error < StandardError; end

  class << self
    # Customize default settings for the SDK using block.
    #   DocRaptor.configure do |config|
    #     config.api_key = ENV['ENVISIO_SCRAPER_KEY']
    #     config.api_secret = ENV['ENVISIO_SCRAPER_SECRET']
    #   end
    # If no block given, return the default Configuration object.

    def configure
      if block_given?
        yield(Configuration.default)
      else
        Configuration.default
      end
    end
  end
end
