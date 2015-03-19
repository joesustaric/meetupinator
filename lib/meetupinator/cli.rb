require 'thor'
require 'meetupinator'

module Meetupinator
  # class doco
  # rubocop:disable Metrics/LineLength
  class CLI < Thor
    attr_accessor :event_finder
    attr_accessor :event_list_file_writer
    attr_accessor :api

    class_option :meetup_api_key,
                 type: :string, aliases: '-k',
                 desc: 'API key for the meetup.com API, defaults to MEETUP_API_KEY environment variable if not set'

    desc 'getevents', 'Write all upcoming events for the given meetup
                       groups specified in INPUT to OUTPUT'
    map 'getevents' => 'retrieve_events'
    method_option :input, aliases: '-i', required: true, type: :string,
                          desc: 'The location of the input file.'
    method_option :output,
                  aliases: '-o', required: false, type: :string,
                  default: 'output.csv',
                  desc: 'The name of the file you want to output. (default is ./output.csv)'
    method_option :weeks,
                  aliases: '-w', required: false, type: :numeric,
                  desc: 'Number of weeks to retrieve events for.'
    def retrieve_events
      Meetupinator::App.retrieve_events(options)
      puts "Output written to #{options[:output]}"
    end

    desc 'format', 'Write a formatted version of the events listed in INPUT to OUTPUT using TEMPLATE to describe the desired output format.'
    method_option :input,
                  aliases: '-i', required: true, type: :string,
                  desc: 'The location of the input CSV file.'
    method_option :output,
                  aliases: '-o', required: true, type: :string,
                  desc: 'The name of the file you want to output.'
    method_option :template,
                  aliases: '-t', required: true, type: :string,
                  desc: 'The name of the template file.'
    def format
      Meetupinator::App.format(options)
      puts "Output written to #{options[:output]}"
    end

    desc '--version', 'Print version'
    map '--version' => 'version'
    map '-v' => 'version'
    def version
      puts Meetupinator::App.version
    end

    default_task :retrieve_events
  end
end
# rubocop:enable Metrics/LineLength
