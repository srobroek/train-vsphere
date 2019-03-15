# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:lint) do |t|
  require 'train/globals'
  t.options = ['--display-cop-names']
end

namespace(:test) do
  desc 'Run all integration tests'
  task integration: %i(integration:sup_start integration:api_actual integration:cli_ssh_actual integration:sup_shutdown)

  Rake::TestTask.new(:unit) do |t|
    t.libs.concat %w{test lib}
    t.test_files = FileList[
      'test/unit/*_test.rb',
    ]
    t.verbose = true
    t.warning = false
  end

  namespace(:integration) do
    {
      # A hidden task to start a vagrant vm with a running supervisor
      # It will expose SSH, httpd, and hab-sup
      sup_start: 'vagrant up',
      # A hidden task to shutdown the vagrant vm with the supervisor
      sup_shutdown: 'vagrant destroy -f',
      # Utility for debugging - Login to to the supervisor
      sup_login: 'vagrant ssh',
    }.each do |task_name, cmd|
      task task_name do
        Dir.chdir('test/integration/shared') do
          sh cmd
        end
      end
    end

    desc 'Use HTTP API to talk to supervisor'
    task api: [:sup_start, :api_actual, :sup_shutdown]
    Rake::TestTask.new(:api_actual) do |t|
      t.description = nil # Hide this task
      t.libs.push 'lib'
      t.test_files = FileList[
        'test/integration/http-api/*_test.rb',
      ]
      t.verbose = true
      t.warning = false
    end

    desc 'Use ssh cli transport to talk to supervisor'
    task cli_ssh: [:sup_start, :cli_ssh_actual, :sup_shutdown]
    Rake::TestTask.new(:cli_ssh_actual) do |t|
      t.description = nil
      t.libs.concat %w{test lib}
      t.test_files = FileList[
        'test/integration/ssh/*_test.rb',
      ]
      t.verbose = true
      t.warning = false
    end
  end
end

task default: %i(test:unit lint)
