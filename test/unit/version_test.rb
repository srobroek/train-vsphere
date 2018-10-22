# frozen_string_literal: true

require './test/helper'
require './lib/train-habitat/version'

class VersionTest < Minitest::Test
  def test_version
    assert TrainPlugins::Habitat::VERSION.is_a?(String)
    assert TrainPlugins::Habitat::VERSION, '0.1.0'
  end
end
