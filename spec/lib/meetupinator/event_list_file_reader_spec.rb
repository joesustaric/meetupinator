require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetupinator/event_list_file_reader'

describe Meetupinator::EventListFileReader do
  include FakeFS::SpecHelpers::All

  let(:file_name) { 'input.csv' }
  let(:input) do
    [
      'Group name,Event name,Day of week,Date,Start time,End time,Event URL',
      'Ruby and Rails Melbourne,Ruby on Rails InstallFest,Thursday,19/02/2015,6:30 pm,9:00 pm,http://www.meetup.com/Ruby-On-Rails-Oceania-Melbourne/events/219051382/',
      'Ruby and Rails Melbourne,Melbourne Ruby,Wednesday,25/02/2015,6:00 pm,9:00 pm,http://www.meetup.com/Ruby-On-Rails-Oceania-Melbourne/events/219387830/'
    ].join("\n")
  end
  let(:expected_output) do
    [
      {
        group_name: 'Ruby and Rails Melbourne',
        event_name: 'Ruby on Rails InstallFest',
        day_of_week: 'Thursday',
        date: Time.new(2015, 2, 19),
        start_time: Time.new(2015, 2, 19, 18, 30),
        end_time: Time.new(2015, 2, 19, 21, 0),
        event_url: 'http://www.meetup.com/Ruby-On-Rails-Oceania-Melbourne/events/219051382/'
      },
      {
        group_name: 'Ruby and Rails Melbourne',
        event_name: 'Melbourne Ruby',
        day_of_week: 'Wednesday',
        date: Time.new(2015, 2, 25),
        start_time: Time.new(2015, 2, 25, 18, 0),
        end_time: Time.new(2015, 2, 25, 21, 0),
        event_url: 'http://www.meetup.com/Ruby-On-Rails-Oceania-Melbourne/events/219387830/'
      }
    ]
  end

  before do
    File.write(file_name, input)
  end

  describe '#read' do
    it 'should read all events from the file' do
      output = subject.read file_name
      expect(output).to eq(expected_output)
    end
  end
end
