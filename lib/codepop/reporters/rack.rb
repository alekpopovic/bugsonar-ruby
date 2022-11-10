# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

module Codepop
  module Reporter
    # Rack
    module Rack
      def notify(event)
        uri = URI.parse("https://api.codepop.co.rs/v1/collectors/ruby")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(uri.path, {
                                        "Content-Type" => "application/json",
                                        "api_key" => Codepop.config.api_key,
                                        "api_secret" => Codepop.config.api_secret
                                      })

        request.body = {
          data: {
            errorClass: event[:error_class],
            errorBacktrace: event[:error_backtrace],
            errorFullBacktrace: event[:error_full_backtrace],
            runtimeVersion: event[:runtime_version],
            applicationEnvironment: ENV["RACK_ENV"]
          }
        }.to_json

        http.request(request)
      end
    end
  end
end
