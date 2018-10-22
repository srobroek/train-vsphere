# frozen_string_literal: true

require './test/helper'
require './lib/train-habitat/transport'

describe TrainPlugins::Habitat::Transport do
  subject { TrainPlugins::Habitat::Transport }

  let(:option)    { { host: 'habitat-02.inspec.io' } }
  let(:transport) { subject.new(option) }

  describe 'plugin definition' do
    it 'should be registered with the plugin registry without the train- prefix' do
      Train::Plugins.registry.keys.wont_include('train-habitat')
      Train::Plugins.registry.keys.must_include('habitat')
    end

    it 'should inherit from the Train plugin base' do
      # For Class, '<' means 'is a descendant of'
      (subject < Train.plugin(1)).must_equal(true)
    end

    it 'should provide a connection() method' do
      # false passed to instance_methods says 'don't use inheritance'
      subject.instance_methods(false).must_include(:connection)
    end
  end

  it '#connection' do
    transport.connection.must_be_instance_of TrainPlugins::Habitat::Connection
  end
end
