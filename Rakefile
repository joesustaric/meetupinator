require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new :spec
task spec: :rubocop
task :default => :spec

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb','spec/**/*.rb']
end

desc 'Build the gem'
task :build do
  system "gem build meetup_thingy.gemspec"
end
