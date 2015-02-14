lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'meetup_thingy/version'

Gem::Specification.new do |s|
  s.name = 'meetup_thingy'
  s.version = MeetupThingy::VERSION
  s.date = '2015-02-14'
  s.summary = "Tool to generate weekly meetup emails"
  s.description = "Tool to generate weekly meetup emails using the Meetup API"
  s.authors = ["Joe Sustaric", "John Fulton", "Charles Korn"]
  s.files = Dir['lib/   *.rb'] + Dir['bin/*'] + ['README.md']
  s.test_files = Dir['spec/*']
  s.homepage = 'https://github.com/joesustaric/meetup-thingy'
  # s.license       = '???'
  s.executables = ['meetup_thingy']

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'webmock'
  s.add_development_dependency 'fakefs'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'guard'
  s.add_runtime_dependency 'thor'
end


