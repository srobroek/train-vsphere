require 'train'
require 'train/plugins'
require 'train-vsphere/connection'

# Train Plugins v1 are usually declared under the TrainPlugins namespace.
# Each plugin has three components: Transport, Connection, and Platform.
# We'll only define the Transport here, but we'll refer to the others.

module TrainPlugins
  module Vsphere
    class Transport < Train.plugin(1)
      name 'vsphere'

      option :hostname, required: true
      option :username, required: true
      option :password, required: true
      option :insecure, default: 'true', required: false


      # inspec -t vsphere://
      def connection(_instance_opts = nil)
        @connection ||= TrainPlugins::Vsphere::Connection.new(@options)
      end
    end
  end
end
