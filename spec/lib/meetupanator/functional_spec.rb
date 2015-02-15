require 'vcr_setup'
require 'spec_helper'
require 'meetupanator/cli'

describe 'meetupanator' do
  # In an ideal world, we'd use FakeFS here.
  # Unfortunately, FakeFS and VCR don't coexist very well.
  # Something like the solution proposed in https://github.com/vcr/vcr/issues/234 could work,
  # but for the time being we can just use temp files instead.
  let(:input_file) { Dir::Tmpname.make_tmpname(['input', '.txt'], nil) }
  let(:output_file) { Dir::Tmpname.make_tmpname(['output', '.csv'], nil) }

  let(:expected_csv_output) do
    [
      {
        group_name: 'The Melbourne Node.JS Meetup Group',
        event_name: 'Feb meetup: io.js & ES6 & more',
        day_of_week: 'Wednesday',
        date: '4/02/2015',
        start_time: '6:30 PM',
        end_time: '9:30 PM'
      },
      {
        group_name: 'Ruby and Rails Melbourne',
        event_name: 'Hack Night',
        day_of_week: 'Tuesday',
        date: '10/02/2015',
        start_time: '6:00 PM',
        end_time: '9:00 PM'
      },
      {
        group_name: 'Ruby and Rails Melbourne',
        event_name: 'Ruby on Rails InstallFest',
        day_of_week: 'Thursday',
        date: '19/02/2015',
        start_time: '6:30 PM',
        end_time: '9:00 PM'
      },
      {
        group_name: 'Ruby and Rails Melbourne',
        event_name: 'Melbourne Ruby',
        day_of_week: 'Wednesday',
        date: '25/02/2015',
        start_time: '6:00 PM',
        end_time: '9:00 PM'
      }
    ]
  end

  def clean_up(file)
    File.delete(file) if File.exist?(file)
  end

  before do
    clean_up input_file
    clean_up output_file
    create_input_file
  end

  after do
    clean_up input_file
    clean_up output_file
  end

  context 'when given minimal correct arguments' do
    it 'will fetch and save events for all meetups' do
      VCR.use_cassette('getevents_functional_test') do
        args = ['getevents', '-i', input_file, '-o', output_file, '-k', '1234']
        expect { Meetupanator::CLI.start(args) }.to match_stdout("Output written to #{output_file}")
        expect(read_output_file).to eq(expected_csv_output)
      end
    end
  end

  context 'when given the --version argument' do
    before { stub_const('Meetupanator::VERSION', '9.23') }

    it 'returns the version' do
      args = ['--version']
      expect { Meetupanator::CLI.start(args) }.to match_stdout('meetupanator v9.23')
    end
  end

  context 'when given the -v argument' do
    before { stub_const('Meetupanator::VERSION', '9.23') }

    it 'returns the version' do
      args = ['-v']
      expect { Meetupanator::CLI.start(args) }.to match_stdout('meetupanator v9.23')
    end
  end

  def create_input_file
    group_names = ['MelbNodeJS', 'Ruby-On-Rails-Oceania-Melbourne']
    File.open(input_file, 'wb') do |file|
      group_names.each { |name| file << name + "\n" }
    end
  end

  def read_output_file
    actual_csv_output = nil
    File.open output_file do |body|
      csv = CSV.new(body, headers: true, header_converters: :symbol, converters: :all)
      actual_csv_output = csv.to_a.map(&:to_hash)
    end
    actual_csv_output
  end
end
