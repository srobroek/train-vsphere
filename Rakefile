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
  train_rubocop_yml = File.join(Train.src_root, '.rubocop.yml')

  t.options = ['--display-cop-names', '--config', train_rubocop_yml]
end

task default: %i(test lint)
