# frozen_string_literal: true

require './test/helper'
require './lib/train-habitat/httpgateway'

describe TrainPlugins::Habitat::HTTPGateway do
  subject { TrainPlugins::Habitat::HTTPGateway.new(host) }

  let(:host) { 'habitat01.inspec.io' }
  let(:single_service) do
    mock = Minitest::Mock.new
    def mock.body
      File.read('test/unit/data/single_response.json')
    end
    mock
  end
  let(:multiple_services) do
    mock = Minitest::Mock.new
    def mock.body
      File.read('test/unit/data/multiple_response.json')
    end
    mock
  end

  def mock_http(response)
    Net::HTTP.stub(:get_response, response) do
      yield
    end
  end

  it '#new' do
    subject.must_be_kind_of TrainPlugins::Habitat::HTTPGateway
    subject.uri.must_be_kind_of URI
  end

  it 'returns a service' do
    mock_http(single_service) do
      count = subject.services.count

      assert_equal(1, count)
    end
  end

  it 'returns a specific service' do
    mock_http(single_service) do
      service = subject.service('core', 'nginx')

      assert_equal('nginx', service.dig('pkg', 'name'))
    end
  end

  it 'raises error when multiple services' do
    mock_http(multiple_services) do
      err = assert_raises IllegalStateError do
        subject.service('core', 'nginx')
      end

      message = "Expected one service 'core/nginx', but found multiple."
      assert_equal(message, err.message)
    end
  end

  it 'raises error when no services' do
    mock_http(single_service) do
      err = assert_raises IllegalStateError do
        subject.service('foo', 'bar')
      end

      message = "Expected one service 'foo/bar', but found none."
      assert_equal(message, err.message)
    end
  end
end
