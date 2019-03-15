require_relative '../../helper'
require 'train-habitat'

describe 'Listing services via the HTTP Gateway API' do
  let(:opts) { { api_url: 'http://127.0.0.1:9631' } } # From Vagrantfile
  let(:conn) { Train.create(:habitat, opts).connection }
  let(:hac) { conn.habitat_api_client }

  it 'should be able to fetch /services' do
    resp = hac.get_path('/services')
    resp.code.must_equal 200
    resp.body.count.must_equal 1
    resp.body[0][:spec_identifier].must_equal 'core/httpd'
  end
end
