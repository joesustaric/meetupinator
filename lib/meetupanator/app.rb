require 'thor'
require 'meetupanator'

module Meetupanator
  # class doco
  class App < Thor
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
    map 'getevents' => 'extract_events'

    option :input, aliases: '-i', required: true, type: :string
    option :output, aliases: '-o', required: true, type: :string
    option :week, aliases: '-w', required: false, type: :boolean

    def extract_events
      output_file = options[:output]
      week = options[:week]
      init
      events = @event_finder.extract_events @group_names, @api, week
      @event_list_file_writer.write events, output_file
      puts "Output written to #{output_file}"
    end

    desc '--version', 'Print version and exit'
    map '--version' => 'version'
    map '-v' => 'version'
    def version
      puts 'meetupanator v' + Meetupanator::VERSION
    end

    private

    # FIXME: This is a horribly gross attempt at dependency injection
    def init
      @api = Meetupanator::MeetupAPI.new(options[:meetup_api_key])
      @group_names = Meetupanator::InputFileReader.group_names options[:input]
      @event_finder = Meetupanator::EventFinder.new
      @event_list_file_writer ||= Meetupanator::EventListFileWriter.new
    end
  end
end
