require_relative '../../helper'
require 'train-habitat'

describe 'Listing services via the HTTP Gateway API' do
  let(:conn) { Train.create(:habitat, opts).connection }
  let(:hac) { conn.habitat_api_client }

  describe 'when the auth token is not set' do
    let(:opts) { { api_url: 'http://127.0.0.1:9631' } } # From Vagrantfile
    it 'should fail to fetch /services' do
      resp = hac.get_path('/services')
      resp.code.must_equal 401
    end
  end

  describe 'when the auth token is set' do
    let(:opts) do
      {
        api_url: 'http://127.0.0.1:9631', # From Vagrantfile
        api_auth_token: 'bulk-overripe-bananas-by-autogyro', # From bootstrap.sh
      }
    end

    it 'should be able to fetch /services' do
      resp = hac.get_path('/services')
      resp.code.must_equal 200
      resp.body.count.must_equal 1
      resp.body[0][:spec_identifier].must_equal 'core/httpd'
    end
  end
end
