# Tests the ability of the transport to use SSH as a CLI subtransport
require 'helper'
require 'train-habitat/connection'
require 'train'
require 'train/transports/ssh'

describe TrainPlugins::Habitat::Connection do
  subject { TrainPlugins::Habitat::Connection }
  let(:conn) { subject.new(opt) }

  describe 'recognizing basic SSH options with prefixes' do
    let(:opt) do
      {
        cli_ssh_host: 'localhost',
        cli_ssh_port: 8022,
        cli_ssh_user: 'hab_user',
      }
    end
    it 'should be able to make a SSH Transport object' do
      Train::Transports::SSH.any_instance.stubs(:connection)
      conn.cli_transport_name.must_equal :ssh
      conn.cli_transport.wont_be_nil
      conn.cli_transport.must_be_kind_of(Train::Transports::SSH)
    end
  end
end
