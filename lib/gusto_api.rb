require "gusto_api/version"
require "gusto_api/configuration"
require "gusto_api/request"
require "gusto_api/token_request"
require "gusto_api/bearer_request"
require "gusto_api/oauth_request"
require "gusto_api/company"
require "gusto_api/oauth"
require "gusto_api/current_user"

module GustoApi
  class Error < StandardError; end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
