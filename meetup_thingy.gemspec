lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'meetupanator/version'

Gem::Specification.new do |s|
  s.name = 'meetupanator'
  s.version = Meetupanator::VERSION
  s.date = '2015-02-14'
  s.summary = "Tool to generate weekly meetup emails"
  s.description = "Tool to generate weekly meetup emails using the Meetup API"
  s.authors = ["Joe Sustaric", "John Fulton", "Charles Korn"]
  s.files = Dir['lib/   *.rb'] + Dir['bin/*'] + ['README.md']
  s.test_files = Dir['spec/*']
  s.homepage = 'https://github.com/joesustaric/meetup-thingy'
  # s.license       = '???'
  s.executables = ['meetupanator']

  s.add_development_dependency 'rspec', '~> 3.2.0'
  s.add_development_dependency 'pry', '~> 0.10.1'
  s.add_development_dependency 'guard-rspec', '~> 4.5.0'
  s.add_development_dependency 'webmock', '~> 1.20.4'
  s.add_development_dependency 'fakefs', '~> 0.6.5'
  s.add_development_dependency 'vcr', '~> 2.9.3'
  s.add_development_dependency 'rubocop', '~> 0.29.1'
  s.add_development_dependency 'guard', '~> 2.12.1'
  s.add_development_dependency 'rake', '~> 10.4.2'
  s.add_runtime_dependency 'thor', '~> 0.19.1'
end

