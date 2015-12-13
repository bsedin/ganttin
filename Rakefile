require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'ganttin/environment'

APP_RAKEFILE = File.join(Ganttin::Environment.dummy_path, 'Rakefile')
load 'rails/tasks/engine.rake'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
