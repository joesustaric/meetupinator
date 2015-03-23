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

  def prepare_html_for_comparison(html)
    # Replace consecutive spaces with a single space, remove leading spaces at the start of a line, remove multiple blank lines
    html.gsub(/[ ]+/, ' ').gsub(/^[ ]+/, '').gsub(/\n+/, "\n")
  end

  context 'meetup api and input file specified' do
    it 'generates the correct output.csv in the working dir' do
      VCR.use_cassette('functional') do
        Meetupinator::CLI.start(['-i', 'input.txt', '-k', '1234'])
      end
      expect(CSV.read('output.csv')).to eq(CSV.read('../spec/fixtures/retrieveOutput.csv'))
    end
  end

  context 'meetup api and input file and output file specified' do
    it 'generates the correct output in the specified location' do
      VCR.use_cassette('functional') do
        Meetupinator::CLI.start(['-i', 'input.txt', '-o', 'outputDir/mySpecialOutput.csv', '-k', '1234'])
      end
      expect(CSV.read('outputDir/mySpecialOutput.csv')).to eq(CSV.read('../spec/fixtures/retrieveOutput.csv'))
    end
  end

  context 'formatting output' do
    it 'generates the correct output in the specified location' do
      Meetupinator::CLI.start(['format', '-i', '../spec/fixtures/formatInput.csv',
                               '-o', 'outputDir/formattedOutput.md',
                               '-t', '../files/templates/default.html.erb'])
      output = prepare_html_for_comparison(IO.read('outputDir/formattedOutput.md'))
      expected_output = prepare_html_for_comparison(IO.read('../spec/fixtures/formatOutput.html'))
      expect(output).to eq(expected_output)
    end

    it 'generates the correct output in the default location using the default template' do
      Meetupinator::CLI.start(['format', '-i', '../spec/fixtures/formatInput.csv'])
      output = prepare_html_for_comparison(IO.read('output.html'))
      expected_output = prepare_html_for_comparison(IO.read('../spec/fixtures/formatOutput.html'))
      expect(output).to eq(expected_output)
    end
  end
end
