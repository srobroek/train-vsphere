# frozen_string_literal: true

require_relative 'illegal_state_error'

require 'net/http'
require 'json'

module TrainPlugins
  module Habitat
    class HTTPGateway
      attr_reader :uri

      def initialize(host)
        @uri = URI("http://#{host}:9631/services")
      end

      def services
        JSON.parse(Net::HTTP.get_response(uri).body)
      end

      def service(origin, name)
        selected = services.select(&by_origin(origin))
                           .select(&by_name(name))

        selected.first
      ensure
        raise NoServicesFoundError.new(origin, name) if selected.empty?
        raise MultipleServicesFoundError.new(origin, name) if selected.size > 1
      end

      private

      def by_origin(origin)
        ->(s) { s.dig('pkg', 'origin') == origin }
      end

      def by_name(name)
        ->(s) { s.dig('pkg', 'name') == name }
      end
    end
  end
end
