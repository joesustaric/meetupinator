module Meetupanator
  # doco
  class App
    def self.version
      'meetupanator v' + Meetupanator::VERSION
    end

    def self.run(args = {})
      new.run(args)
    end

    def run(args)
      init(args)
      events = @event_finder.extract_events(@group_names, @api, args[:week])
      @event_list_file_writer.write events, args[:output]
    end

    def init(args)
      @api = Meetupanator::MeetupAPI.new(args[:meetup_api_key])
      @group_names = Meetupanator::InputFileReader.group_names args[:input]
      @event_finder = Meetupanator::EventFinder.new
      @event_list_file_writer = Meetupanator::EventListFileWriter.new
    end
  end
end
