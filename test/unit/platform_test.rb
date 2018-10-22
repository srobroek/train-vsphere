# frozen_string_literal: true

require './test/helper'
require './lib/train-habitat/platform'

describe TrainPlugins::Habitat::Platform do
  subject { TrainPlugins::Habitat::Platform }

  it 'should implement a platform method' do
    subject.instance_methods(false).must_include(:platform)
  end

  describe '.platform' do
    let(:plat) do
      TrainPlugins::Habitat::Connection.new(host: 'hab01.inspec.io')
                                       .platform
    end

    it 'in_family should be api' do
      plat.family.must_equal 'api'
    end

    it 'should force platform to habitat' do
      plat.name.must_equal 'habitat'
    end
  end
end
