# frozen_string_literal: true

require "uri"
require "net/http"
require "json"

module Bugsify
  # Client
  module Client
    # Api
    class Api
      # rubocop:disable Metrics/AbcSize
      # rubocop:disable Metrics/MethodLength
      def request(uri, method, body = nil)
        uri = URI.parse("https://api.codepop.co.rs/v1/#{uri}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        klass = "Net::HTTP::#{method}"
        constantized = Object.const_get(klass)

        request = constantized.new(uri)
        request["Content-Type"] = "application/json"
        request["apikey"] = Bugsify.config.api_key
        request.body = { payload: body }.to_json if body

        response = http.request(request)

        obj = JSON.pretty_generate(
          JSON.parse(response.read_body)
        )

        yield(obj) if block_given?
      end
      # rubocop:enable Metrics/AbcSize
      # rubocop:enable Metrics/MethodLength
    end
  end
end
