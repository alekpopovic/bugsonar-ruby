# frozen_string_literal: true

module Bugsonar
  module Config
    class << self
      def included(base)
        base.extend(ClassMethods)
      end
    end

    module ClassMethods
      def config
        @config ||= Configuration.new
      end

      def configure
        yield config
      end
    end

    class Configuration
      attr_accessor :api_url, :api_key_name, :api_key
    end

    specs = {
      name: "bugsonar",
      version: "2.0.0",
      authors: ["Aleksandar Popovic"],
      email: ["aleksandar.popovic@linux.com"],
      summary: "Ruby notifier for custom monitoring apps",
      description: "Bugsonar error monitoring & exception reporter for Ruby",
      homepage: "https://github.com/alekpopovic/bugsonar",
      license: "MIT",
      required_ruby_version: ">= 2.6.0",
      source_code_uri: "https://github.com/alekpopovic/bugsonar",
      changelog_uri: "https://github.com/alekpopovic/bugsonar/blob/main/CHANGELOG.md",
    }

    specs.each { |k, v| const_set(k.upcase, v) }
  end
end
