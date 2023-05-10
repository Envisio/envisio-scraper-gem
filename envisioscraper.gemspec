$:.push File.expand_path("../lib", __FILE__)
require "envisioscraper/version"

Gem::Specification.new do |s|
  s.name = "envisioscraper"
  s.version = EnvisioScraper::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Jim Li"]
  s.email = ["jli@envisio.com"]

  s.summary = "Envisio Web Scraper Ruby client"
  s.description = "Envisio Web Scraper Ruby client"
  s.homepage = "https://envisio.com"
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  s.add_runtime_dependency "jwt", "~> 2.2", ">= 2.2.0"
  s.add_runtime_dependency "typhoeus", "~> 1.0", ">= 1.0.1"
  s.add_runtime_dependency "json", "~> 2.1", ">= 2.1.0"

  s.files = `git ls-files`.split("\n").uniq.sort.select { |f| !f.empty? }
  s.test_files = `git ls-files spec test`.split("\n")
  s.executables = []
  s.require_paths = ["lib"]
end
