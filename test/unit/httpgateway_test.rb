# frozen_string_literal: true

require './test/helper'
require './lib/train-habitat/httpgateway'

describe TrainPlugins::Habitat::HTTPGateway do
  subject { TrainPlugins::Habitat::HTTPGateway.new(host) }

  let(:host) { 'habitat01.inspec.io' }

  it '#new' do
    subject.must_be_kind_of TrainPlugins::Habitat::HTTPGateway
    subject.uri.must_be_kind_of URI
  end
end
