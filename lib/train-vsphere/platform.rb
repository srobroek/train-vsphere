# frozen_string_literal: true

module TrainPlugins
  module Vsphere
    module Platform
      def platform
        Train::Platforms.name('vsphere').in_family('cloud')
        force_platform!('vsphere', release: TrainPlugins::Vsphere::VERSION)
      end
    end
  end
end


