# frozen_string_literal: true

module TrainPlugins::Habitat
  module Platform
    def platform
      Train::Platforms.name('habitat').in_family('api')
      force_platform!('habitat', release: TrainPlugins::Habitat::VERSION)
    end
  end
end
