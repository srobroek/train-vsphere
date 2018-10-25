# frozen_string_literal: true

require './test/helper'
require './lib/train-habitat/connection'

# rubocop:disable Metrics/BlockLength
describe TrainPlugins::Habitat::Connection do
  subject { TrainPlugins::Habitat::Connection }

  let(:opt)   { { host: 'habitat01.inspec.io' } }
  let(:conn)  { subject.new(opt) }
  let(:cache) { conn.instance_variable_get(:@cache) }

  describe 'connection definition' do
    it 'should inherit from the Train Connection base' do
      # For Class, '<' means 'is a descendant of'
      (subject < Train::Plugins::Transport::BaseConnection).must_equal(true)
    end

    %i[
      file_via_connection
      run_command_via_connection
      local?
    ].each do |method_name|
      it "should NOT provide a #{method_name}() method" do
        # false passed to instance_methods says 'don't use inheritance'
        subject.instance_methods(false).wont_include(method_name)
      end
    end

    it 'should declare itself as a non-local transport' do
      subject.new(opt).local?.must_equal(false)
    end
  end

  describe '#new' do
    it 'should raise Train::Transport error with empty options' do
      proc do
        TrainPlugins::Habitat::Connection.new({})
      end.must_raise Train::TransportError
    end
  end

  describe '#uri' do
    it 'should have the correct habitat uri' do
      conn.uri.must_equal "habitat://#{opt[:host]}"
    end
  end

  describe '#habitat_client' do
    it 'should return kind of TrainPlugins::Habitat::HTTPGateway' do
      conn.habitat_client.must_be_kind_of TrainPlugins::Habitat::HTTPGateway
    end

    it 'returns a new instance when cache is disabled' do
      conn.disable_cache(:api_call)
      client_one = conn.habitat_client
      client_two = conn.habitat_client

      cache[:api_call].count.must_equal 0
      client_one.object_id.wont_equal client_two.object_id
    end

    it 'returns the same instance when cache is enabled' do
      cache[:api_call].count.must_equal 0
      conn.enable_cache(:api_call)

      client_one = conn.habitat_client
      client_two = conn.habitat_client

      cache[:api_call].count.must_equal 1
      client_one.object_id.must_equal client_two.object_id
    end
  end
end
# rubocop:enable Metrics/BlockLength
