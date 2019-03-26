# Verify that loggers get passed around correctly.  This is
# important, because the CLI transports can be very chatty.

require './test/helper'
require './lib/train-habitat/connection'
require './lib/train-habitat/transport'
require 'train/transports/ssh'

describe 'logger facilities' do
  let(:hab_xport) { Train.create(:habitat, opts) }
  let(:hab_xport_logger) { hab_xport.instance_variable_get(:@logger) }
  let(:hab_cxn) { hab_xport.connection }
  let(:hab_cxn_logger) { hab_cxn.instance_variable_get(:@logger) }
  let(:cli_xport) { hab_cxn.cli_transport }
  let(:cli_xport_logger) { cli_xport.instance_variable_get(:@logger) }
  let(:cli_cxn) { hab_cxn.cli_connection }
  let(:cli_cxn_logger) { cli_cxn.instance_variable_get(:@logger) }

  describe 'when not providing a logger' do
    let(:opts) { {} }

    describe 'when instantiating a transport' do
      it 'should create a logger for you' do
        hab_xport_logger.wont_be_nil
        # The default logger allows logging of debug msgs
        hab_xport_logger.debug?.must_equal true
      end
    end

    describe 'when instantiating a connection' do
      let(:opts) { { cli_ssh_host: '127.0.0.1' } }

      it 'should create a logger for you' do
        # Intercept platform detection
        mock_cmd_out = mock
        mock_cmd_out.expects(:stdout).returns('').at_least_once
        mock_cmd_out.expects(:exit_status).returns(0).at_least_once
        Train::Transports::SSH::Connection.any_instance.stubs(:run_command_via_connection).returns(mock_cmd_out)
        Train::Extras::CommandWrapper.stubs(:load)

        # a logger should be created for you in the hab connection
        hab_cxn_logger.wont_be_nil
        hab_cxn_logger.debug?.must_equal true

        # one should be created in the cli transport
        cli_xport_logger.wont_be_nil
        cli_xport_logger.debug?.must_equal true

        # one shuld be created in the cli cxn
        cli_cxn_logger.wont_be_nil
        cli_cxn_logger.debug?.must_equal true

        # and they should all be the same one
        the_logger = hab_cxn_logger
        cli_xport_logger.must_be_same_as the_logger
        cli_cxn_logger.must_be_same_as the_logger
      end
    end
  end
end
