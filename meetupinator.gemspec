lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'meetupinator/version'

Gem::Specification.new do |s|
  s.name = 'meetupinator'
  s.version = Meetupinator::VERSION
  s.date = '2015-02-22'
  s.summary = "Tool to generate weekly meetup emails"
  s.description = "Tool to generate weekly meetup emails using the Meetup API"
  s.authors = ["Joe Sustaric", "John Fulton", "Charles Korn"]
  s.email = ['joe8307@gmail.com','jfulton@thoughtworks.com', 'me@charleskorn.com']
  s.files = Dir['lib/**/*'] + Dir['bin/*'] + ['README.md']
  s.test_files = Dir['spec/**/*']
  s.homepage = 'https://github.com/joesustaric/meetupinator'
  s.license       = 'MIT'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'pry', '~> 0.10'
  s.add_development_dependency 'guard-rspec', '~> 4.5'
  s.add_development_dependency 'webmock', '~> 1.20'
  s.add_development_dependency 'fakefs', '~> 0.6'
  s.add_development_dependency 'vcr', '~> 2.9'
  s.add_development_dependency 'rubocop', '~> 0.29'
  s.add_development_dependency 'guard', '~> 2.12'
  s.add_development_dependency 'rake', '~> 10.4'
  s.add_runtime_dependency 'thor', '~> 0.19'
end
