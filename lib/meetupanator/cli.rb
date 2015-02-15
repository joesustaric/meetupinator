require 'thor'
require 'meetupanator'

module Meetupanator
  # class doco
  class CLI < Thor
    attr_accessor :event_finder
    attr_accessor :event_list_file_writer
    attr_accessor :api

    class_option :meetup_api_key,
                 type: :string, aliases: '-k',
                 desc: 'API key for the meetup.com API,
                        defaults to MEETUP_API_KEY environment
                        variable if not set'

    desc 'getevents', 'Write all upcoming events for the given meetup
                       groups specified in INPUT to OUTPUT'
    map 'getevents' => 'run_app'

    option :input, aliases: '-i', required: true, type: :string
    option :output, aliases: '-o', required: true, type: :string
    option :week, aliases: '-w', required: false, type: :boolean

    def run_app
      Meetupanator::App.run(options)
      puts "Output written to #{options[:output]}"
    end

    desc '--version', 'Print version'
    map '--version' => 'version'
    map '-v' => 'version'
    def version
      puts Meetupanator::App.version
    end

    default_task :run_app
  end
end
