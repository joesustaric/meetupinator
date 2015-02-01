require 'thor'
require 'meetup_thingy'

module MeetupThingy
  class App < Thor

    desc "version", "Print version and exit"
    def version
      puts "meetup_thingy v" + MeetupThingy::VERSION
    end

  end
end
