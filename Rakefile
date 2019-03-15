# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

RuboCop::RakeTask.new(:lint) do |t|
  require 'train/globals'
  t.options = ['--display-cop-names']
end

namespace(:test) do
  desc 'Run all integration tests'
  task integration: %i(integration:cli_local)

  Rake::TestTask.new(:unit) do |t|
    t.libs.push 'lib'
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

    # desc 'Use some cli transport to talk to supervisor'
    # task :cli_thing => [:sup_start, :cli_thing_actual, :sup_shutdown]
    # task :cli_thing_actual do
    #   # Your code goes here
    # end
  end
end

task default: %i(test:unit lint)
