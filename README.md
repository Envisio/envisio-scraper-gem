# Envisioscraper

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/envisioscraper`. To experiment with that code, run `bin/console` for an interactive prompt.

This is a Ruby wrapper to the Envisio Web Scraper Service.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'envisioscraper'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install envisioscraper

## Usage

To config EnvisioScraper, first obtain `api_key` and `api_secret` from Envisio Web Scraper Service. Record both values as ENV vars, e.g. `ENV['ENVISIO_SCRAPER_API_KEY']` and `ENV['ENVISIO_SCRAPER_API_SECRET']`.

Create `config/initializers/envisio_scraper.rb` with the following content.

```ruby
EnvisioScraper.configure do |c|
  c.api_key    = ENV['ENVISIO_SCRAPER_API_KEY']
  c.api_secret = ENV['ENVISIO_SCRAPER_API_SECRET']
end
```

### Service ping

```ruby
EnvisioScraper::ScrapeApi.new.ping
```

### Create a new scrape request

```ruby
EnvisioScraper::ScrapeApi.new.scrape(scrape_url: 'https://example.com', callback_url: 'https://callback.sender.com?with_sender_determined_params')
```

The `scrape` method will return a `typhoeus` response object. You can obtain response body by referring to `typhoeus` API. Part of the response body includes the newly created scrape API's ID, which can be used by `check_status`.

With the new scrape created, the Envisio Web Scraper Service will send the scraped HTML content from `scrape_url` to `callback_url` as a "POST" requst. The scraped content will be included as the post body under the `content` key.

### Check scrape request status

```ruby
EnvisioScraper::ScrapeApi.new.check_status(scrape_id: 1)
```
