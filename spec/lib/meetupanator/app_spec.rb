require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetupanator/app'

describe Meetupanator::App do
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
        week: false
      }
    end

    context 'when input file / output file / api key / is specified' do
      it 'executes the program' do
        expect(Meetupanator::MeetupAPI).to receive(:new).and_return(meetup_api)
        expect(Meetupanator::InputFileReader).to receive(:group_names).with(input_file).and_return(group_names)
        expect(Meetupanator::EventFinder).to receive(:new).and_return(event_finder)
        expect(Meetupanator::EventListFileWriter).to receive(:new).and_return(file_writer)
        expect(event_finder).to receive(:extract_events).with(group_names, meetup_api, false).and_return(events)
        expect(file_writer).to receive(:write).with(events, output_file)
        Meetupanator::App.run(args)
      end
    end
  end
end
