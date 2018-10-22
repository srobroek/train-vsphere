# frozen_string_literal: true

require 'train/plugins'
require 'train-habitat/connection'

module TrainPlugins
  module Habitat
    class Transport < Train.plugin(1)
      name 'habitat'

      option :host, required: true

      # inspec -t habitat://hostname
      def connection(_instance_opts = nil)
        @connection ||= TrainPlugins::Habitat::Connection.new(@options)
      end
    end
  end
end
