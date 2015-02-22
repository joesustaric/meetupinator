require 'spec_helper'
require 'vcr_setup'
require 'meetupinator/cli'

# I wanted to execute these tests by running the exe file
# but it won't engage the vcr gem because I think it might
# spawn a new process? (I think)
describe 'The meetupinator command line interface' do
  let(:meetups) { ['MelbNodeJS', 'Ruby-On-Rails-Oceania-Melbourne'] }

  before do
    FileUtils.mkdir_p('test')
    Dir.chdir('test')
    File.open('input.txt', 'wb') do |file|
      meetups.each { |m| file << m + "\n" }
    end
  end

  after do
    Dir.chdir('..')
    FileUtils.rm_rf('test')
  end

  context 'no arguments' do
  end

  context 'meetup api and input file specified' do
    it 'generates the correct output.csv in the working dir' do
      VCR.use_cassette('functional') do
        Meetupinator::CLI.start(['-i', 'input.txt', '-k', '1234'])
      end
      expect(CSV.read('output.csv')).to eq(CSV.read('../spec/fixtures/functional.csv'))
    end
  end

  context 'meetup api and input file and output file specified' do
    it 'generates the correct output in the specified location' do
      VCR.use_cassette('functional') do
        Meetupinator::CLI.start(['-i', 'input.txt', '-o', 'outputDir/mySpecialOutput.csv', '-k', '1234'])
      end
      expect(CSV.read('outputDir/mySpecialOutput.csv')).to eq(CSV.read('../spec/fixtures/functional.csv'))
    end
  end
end
