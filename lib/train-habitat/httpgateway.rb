# frozen_string_literal: true

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
        JSON.parse(Net::HTTP.get_response(uri))
      end
    end
  end
end
