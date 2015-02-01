require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetup_thingy/app'

describe MeetupThingy::App do
  include FakeFS::SpecHelpers::All

  let(:file_writer) { instance_double(MeetupThingy::EventListFileWriter) }
  let(:input_file) { 'input.txt' }
  let(:output_file) { 'output.csv' }

  describe '#version' do
    it { expect { subject.version }.to match_stdout('meetup_thingy v0.1') }
  end

  describe '#extract_events' do
    it 'gets all upcoming events for the given groups and saves them to file' do
      group_names = ['First meetup group', 'Second meetup group']
      events = [:first_event, :second_event]

      File.open(input_file, 'wb') do |file|
        group_names.each { |name| file << name + "\n" }
      end

      subject.options = {
        input: input_file,
        output: output_file
      }

      subject.event_finder = instance_double(MeetupThingy::EventFinder)
      subject.event_list_file_writer = file_writer
      subject.api = instance_double(MeetupThingy::MeetupAPI)

      expect(subject.event_finder).to receive(:extract_events).with(group_names, subject.api) { events }
      expect(subject.event_list_file_writer).to receive(:write).with(events, output_file)
      expect { subject.extract_events }.to match_stdout('')
    end
  end
end
