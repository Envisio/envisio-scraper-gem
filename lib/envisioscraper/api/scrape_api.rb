module EnvisioScraper
  class ScrapeApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end

    def ping
      @api_client.ping
    end

    def check_status(scrape_id:)
      @api_client.request(
        method: :get,
        uri: "scrapes/#{scrape_id}",
        payload: ApiPayload.new({ id: scrape_id }, [:id])
      )
    end

    def scrape(scrape_url:, callback_url:)
      @api_client.request(
        method: :post,
        uri: "scrapes/",
        payload: ApiPayload.new(
          { scrape_url: scrape_url, async: true, callback_url: callback_url },
          [:scrape_url, :async, :callback_url]
        )
      )
    end

  end
end
