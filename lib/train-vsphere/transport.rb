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

      option :host, required: true #{ ENV['VC_HOSTNAME'] }
      option :user, required: true # { ENV['VC_USERNAME'] }
      option :password, required: true # { ENV['VC_PASSWORD'] }
      option :insecure, required: false, default: false # { ENV['VC_INSECURE'] }


      # inspec -t vsphere://
      def connection(_instance_opts = nil)
        @connection ||= TrainPlugins::Vsphere::Connection.new(@options)
      end
    end
  end
end
