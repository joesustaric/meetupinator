require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetup_thingy/app'

describe MeetupThingy::App do
  include FakeFS::SpecHelpers::All

  let(:input_file) { 'input.txt' }
  let(:output_file) { 'output.csv' }
  let(:event_finder) { double('event finder') }
  let(:file_writer) { double('file writer') }
  let(:meetup_api) { double('meetup api') }
  let(:group_names) { ['First meetup group', 'Second meetup group'] }

  before do
    allow(MeetupThingy::EventFinder).to receive(:new).and_return(event_finder)
    allow(MeetupThingy::MeetupAPI).to receive(:new).and_return(meetup_api)
    allow(MeetupThingy::EventListFileWriter).to receive(:new).and_return(file_writer)
    stub_const('MeetupThingy::VERSION', '9.123')
    write_input_file
  end

  describe '#version' do
    it { expect { subject.version }.to match_stdout('meetup_thingy v9.123') }
  end

  describe '#extract_events' do
    it 'gets all upcoming events for the given groups and saves them to file' do
      events = [:first_event, :second_event]

      subject.options = { input: input_file, output: output_file }
      expect(event_finder).to receive(:extract_events).with(group_names, meetup_api).and_return(events)
      expect(file_writer).to receive(:write).with(events, output_file)
      subject.extract_events
    end
  end

  def write_input_file
    File.open(input_file, 'wb') do |file|
      group_names.each { |name| file << name + "\n" }
    end
  end
end
