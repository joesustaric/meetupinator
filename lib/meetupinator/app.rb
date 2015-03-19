module Meetupinator
  # doco
  class App
    def self.version
      'meetupinator v' + Meetupinator::VERSION
    end

    def self.retrieve_events(args = {})
      new.retrieve_events(args)
    end

    def self.format(args = {})
      new.format(args)
    end

    def retrieve_events(args)
      init_retrieve(args)
      events = @event_finder.extract_events(@group_names, @api, args[:weeks])
      @event_list_file_writer.write events, args[:output]
    end

    def init_retrieve(args)
      @api = Meetupinator::MeetupAPI.new(args[:meetup_api_key])
      @group_names = Meetupinator::InputFileReader.group_names args[:input]
      @event_finder = Meetupinator::EventFinder.new
      @event_list_file_writer = Meetupinator::EventListFileWriter.new
    end

    def format(args)
      reader = Meetupinator::EventListFileReader.new
      formatter = Meetupinator::Formatter.new

      events = reader.read(args[:input])
      formatter.format(events, args[:template], args[:output])
    end
  end
end
