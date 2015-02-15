require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetupanator/event_list_file_writer'

describe Meetupanator::EventListFileWriter do
  include FakeFS::SpecHelpers::All

  let(:file_name) { 'output.csv' }
  let(:events) do
    [
      {
        'group' => { 'name' => 'The Society of Chocolate Eaters' },
        'name' => 'The Time When We Eat Chocolate',
        'time' => 142_355_160_000_0,
        'utc_offset' => 396_000_00,
        'duration' => 720_000_0
      }
    ]
  end

  let(:expected_csv_output) do
    [
      {
        group_name: 'The Society of Chocolate Eaters',
        event_name: 'The Time When We Eat Chocolate',
        day_of_week: 'Tuesday',
        date: '10/02/2015',
        start_time: '6:00 PM',
        end_time: '8:00 PM'
      }
    ]
  end

  def clean_up
    File.delete(file_name) if File.exist?(file_name)
  end

  before do
    clean_up
  end

  after do
    clean_up
  end

  describe '#write' do
    it 'writes the events to file' do
      subject.write events, file_name

      File.open file_name do |body|
        csv = CSV.new(body, headers: true, header_converters: :symbol,
                            converters: :all)
        actual_csv_output = csv.to_a.map(&:to_hash)
        expect(actual_csv_output).to eq(expected_csv_output)
      end
    end

    context 'when the event does not have a duration' do
      before do
        events[0].delete('duration')
        expected_csv_output[0][:end_time] = '9:00 PM'
      end

      # According to http://www.meetup.com/meetup_api/docs/2/events/,
      # if no duration is specified,
      # we can assume 3 hours.
      it 'writes the event to file assuming the duration is 3 hours' do
        subject.write events, file_name

        File.open file_name do |body|
          csv = CSV.new(body, headers: true, header_converters: :symbol,
                              converters: :all)
          actual_csv_output = csv.to_a.map(&:to_hash)
          expect(actual_csv_output).to eq(expected_csv_output)
        end
      end
    end
  end
end
