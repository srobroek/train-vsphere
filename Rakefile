# frozen_string_literal: true

require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.libs.push 'lib'
  t.test_files = FileList[
    'test/unit/*_test.rb',
    'test/integration/*_test.rb',
    'test/function/*_test.rb',
  ]
  t.verbose = true
  t.warning = false
end

RuboCop::RakeTask.new(:lint) do |t|
  require 'train/globals'
  t.options = ['--display-cop-names']
end

task default: %i[test lint]
