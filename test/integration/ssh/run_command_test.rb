require 'helper'
require 'logger'
require 'train-habitat'

describe 'Using the SSH CLI transport' do
  let(:transport_opts) do
    {
      # These are determined by the Vagrantfile
      cli_ssh_host: '127.0.0.1',
      cli_ssh_user: 'vagrant',
      cli_ssh_port: '9022',
      cli_ssh_key_files: ['test/integration/shared/.vagrant/machines/default/virtualbox/private_key'],

      logger: Logger.new(STDOUT, level: :warn), # TODO: This is consumed by train/base_connection, but appears to be ignored
      sudo: true, # This is needed on the Vagrantbox setup
    }
  end
  let(:hab_conn) { Train.create(:habitat, transport_opts).connection }

  describe 'when using defaults' do
    it 'should be able to get the hab version' do
      result = hab_conn.run_hab_cli('--version')
      result.exit_status.must_equal 0
      # "hab 0.77.0/20190301212334\n"
      result.stdout.must_match %r{^hab\s+\d+\.\d+\.\d+/\d+\n}
    end
  end

  describe 'when using a setup that requires sudo' do
    it 'should be able to get the hab version' do
      result = hab_conn.run_hab_cli('svc status')
      result.stderr.must_equal ''
      result.exit_status.must_equal 0
      # package                           type        desired  state  elapsed (s)  pid   group\n
      # core/httpd/2.4.35/20190307151146  standalone  up       up     28521        1407  httpd.default\n
      result.stdout.must_match(/^package\s+type\s+/)
    end
  end
end
