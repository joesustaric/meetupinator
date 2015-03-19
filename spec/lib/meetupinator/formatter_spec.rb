require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetupinator/formatter'

describe Meetupinator::Formatter do
  include FakeFS::SpecHelpers::All

  let(:template) { 'template content' }
  let(:template_file) { 'template.erb' }
  let(:events) { double('events') }
  let(:output) { 'output' }
  let(:output_file) { 'output.blah' }
  let(:erb) { instance_double(ERB) }

  describe '#format' do
    before do
      File.write(template_file, template)
    end

    it 'passes the events to the formatter and saves the result to file' do
      expect(ERB).to receive(:new).with(template).and_return(erb)
      expect(erb).to receive(:result) do |binding|
        expect(eval('events', binding)).to eq(events) # rubocop:disable Lint/Eval
        output
      end

      subject.format(events, template_file, output_file)

      expect(File.read(output_file)).to eq(output)
    end
  end
end
