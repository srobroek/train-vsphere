require './test/helper'
require './lib/train-habitat/httpgateway'

describe TrainPlugins::Habitat::HTTPGateway do # rubocop:disable Metrics/BlockLength
  let(:hgw) { TrainPlugins::Habitat::HTTPGateway.new(opts) }
  describe 'when a full URL is provided' do
    let(:opts) { { url: 'http://habitat01.inspec.io:9631' } }

    it 'should make the proper object' do
      hgw.must_be_kind_of TrainPlugins::Habitat::HTTPGateway
    end

    it 'should make a base URI' do
      hgw.base_uri.must_be_kind_of URI
      hgw.base_uri.to_s.must_equal opts[:url]
    end
  end

  describe 'when a URL without port is provided' do
    let(:opts) { { url: 'http://habitat01.inspec.io' } }

    it 'assumes port 9631' do
      hgw.base_uri.port.must_equal 9631
    end
  end

  describe 'when fetching paths' do
    let(:opts) { { url: 'http://habitat01.inspec.io:9631' } }
    let(:service_response_mock) do
      service_mock = mock
      service_mock.expects(:code).returns(200)
      service_mock.expects(:body).returns(File.read('test/unit/data/single_response.json')).at_least_once
      service_mock
    end

    let(:net_http_mock) do
      http_mock = mock
      http_mock.expects(:read_timeout=)
      Net::HTTP.stubs(:start).returns(http_mock)
      http_mock.expects(:get).returns(service_response_mock)
    end

    it 'should be able to get paths' do
      net_http_mock
      response = hgw.get_path('/service') # No exception thrown
      response.wont_be_nil
      response.must_be_kind_of TrainPlugins::Habitat::HTTPGateway::Response
      response.code.must_equal 200
    end

    it 'should automatically unpack JSON responses' do
      net_http_mock

      response = hgw.get_path('/service') # No exception thrown
      response.body.must_be_kind_of Array # Apparently they always send us an array
      response.body[0].keys[0].must_be_kind_of Symbol # We symbolize the keys
      response.raw_response.body.must_be_kind_of String
    end

    describe 'when an auth token is set' do
      let(:opts) do
        {
          url: 'http://habitat01.inspec.io:9631',
          auth_token: 'some-secret',
        }
      end
      it 'should send it as an HTTP header' do
        net_http_mock.with { |_url, headers| headers == { 'Authorization' => 'Bearer some-secret' } }

        response = hgw.get_path('/service') # No exception thrown
        response.wont_be_nil
        response.code.must_equal 200
      end

    end
  end
end
