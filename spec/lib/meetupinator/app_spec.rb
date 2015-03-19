require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetupinator/app'

describe Meetupinator::App do
  describe '#retrieve_events' do
    let(:event_finder) { instance_double(Meetupinator::EventFinder) }
    let(:file_writer) { instance_double(Meetupinator::EventListFileWriter) }
    let(:meetup_api) { instance_double(Meetupinator::MeetupAPI) }
    let(:input_file) { 'input.txt' }
    let(:output_file) { 'output.csv' }
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

    context 'when input file, output file, api key and number of weeks are specified' do
      it 'executes the program' do
        expect(Meetupinator::EventFinder).to receive(:new).and_return(event_finder)
        expect(Meetupinator::EventListFileWriter).to receive(:new).and_return(file_writer)
        expect(Meetupinator::MeetupAPI).to receive(:new).and_return(meetup_api)
        expect(Meetupinator::InputFileReader).to receive(:group_names).with(input_file).and_return(group_names)
        expect(event_finder).to receive(:extract_events).with(group_names, meetup_api, 1).and_return(events)
        expect(file_writer).to receive(:write).with(events, output_file)
        Meetupinator::App.retrieve_events(args)
      end
    end
  end

  describe '#format' do
    let(:file_reader) { instance_double(Meetupinator::EventListFileReader) }
    let(:formatter) { instance_double(Meetupinator::Formatter) }
    let(:input_file) { 'input.csv' }
    let(:output_file) { 'output.md' }
    let(:template_file) { 'template.md.erb' }
    let(:events) { double('events') }
    let(:args) do
      {
        input: input_file,
        output: output_file,
        template: template_file
      }
    end

    context 'when input file, output file and template are specified' do
      it 'formats the given events using the given template and saves the output to the specified output filename' do
        expect(Meetupinator::EventListFileReader).to receive(:new).and_return(file_reader)
        expect(Meetupinator::Formatter).to receive(:new).and_return(formatter)
        expect(file_reader).to receive(:read).with(input_file).and_return(events)
        expect(formatter).to receive(:format).with(events, template_file, output_file)
        Meetupinator::App.format(args)
      end
    end
  end
end
