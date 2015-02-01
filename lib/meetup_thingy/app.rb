require 'thor'
require 'meetup_thingy'

module MeetupThingy
  # calss doco
  class App < Thor
    attr_accessor :event_finder
    attr_accessor :event_list_file_writer
    attr_accessor :api

    class_option :meetup_api_key,
                 type: :string,
                 aliases: '-k',
                 desc: 'API key for the meetup.com API,
                        defaults to MEETUP_API_KEY environment
                        variable if not set'

    desc 'getevents', 'Write all upcoming events for the given meetup
                       groups specified in INPUT to OUTPUT'
    map 'getevents' => 'extract_events'
    option :input, aliases: '-i', required: true, type: :string
    option :output, aliases: '-o', required: true, type: :string
    def extract_events
      init

      input_file = options[:input]
      output_file = options[:output]
      group_names = read_group_names_from_file input_file

      events = @event_finder.extract_events group_names, @api
      @event_list_file_writer.write events, output_file
    end

    desc '--version', 'Print version and exit'
    map '--version' => 'version'
    def version
      puts 'meetup_thingy v' + MeetupThingy::VERSION
    end

    private

    # FIXME: This is a horribly gross attempt at dependency injection
    def init
      @event_finder ||= MeetupThingy::EventFinder.new
      @event_list_file_writer ||= MeetupThingy::EventListFileWriter.new
      @api ||= MeetupThingy::MeetupAPI.new(options[:meetup_api_key])
    end

    def read_group_names_from_file(file_name)
      group_names = []

      File.open(file_name, 'rb') do |file|
        file.each_line { |line| group_names << line.strip }
      end

      group_names
    end
  end
end
