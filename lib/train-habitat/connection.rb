# frozen_string_literal: true

require 'net/http'
require 'json'
require 'train-habitat/httpgateway'
require 'train-habitat/platform'

module TrainPlugins
  module Habitat
    class Connection < Train::Plugins::Transport::BaseConnection
      include TrainPlugins::Habitat::Platform

      def initialize(options = {})
        if options.nil? || options[:host].nil?
          raise Train::TransportError, 'Habitat HTTP Gateway host required'
        end

        super(options)
        @cache_enabled[:api_call] = true
        @cache[:api_call]         = {}

        enable_cache :api_call
      end

      def uri
        "habitat://#{@options[:host]}"
      end

      def habitat_client
        cached_client(:api_call, :HTTPGateway) do
          HTTPGateway.new(@options[:host])
        end
      end
    end
  end
end
