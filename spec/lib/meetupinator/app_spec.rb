require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetupinator/app'

describe Meetupinator::App do
  describe '#run' do
    let(:input_file) { 'input.txt' }
    let(:output_file) { 'output.csv' }
    let(:event_finder) { double('event finder') }
    let(:file_writer) { double('file writer') }
    let(:meetup_api) { double('meetup api') }
    let(:group_names) { ['First meetup group', 'Second meetup group'] }
    let(:events) { double('events') }
    let(:args) do
      {
        meetup_api_key: 1234,
        input: input_file,
        output: output_file,
        weeks: 1
      }
    end

    context 'when input file / output file / api key / is specified' do
      it 'executes the program' do
        expect(Meetupinator::MeetupAPI).to receive(:new).and_return(meetup_api)
        expect(Meetupinator::InputFileReader).to receive(:group_names).with(input_file).and_return(group_names)
        expect(Meetupinator::EventFinder).to receive(:new).and_return(event_finder)
        expect(Meetupinator::EventListFileWriter).to receive(:new).and_return(file_writer)
        expect(event_finder).to receive(:extract_events).with(group_names, meetup_api, 1).and_return(events)
        expect(file_writer).to receive(:write).with(events, output_file)
        Meetupinator::App.run(args)
      end
    end
  end
end
