require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetup_thingy/input_file_reader'

describe MeetupThingy::InputFileReader do
  include FakeFS::SpecHelpers::All

  let(:input_file_dir) { '/tmp/input/file/location' }
  let(:file_name) { input_file_dir + '/input_file.txt' }
  let(:group_names) { %w(some_group another_group more_groups) }

  before do
    # need to make dir for fakefs
    FileUtils.mkdir_p(input_file_dir)
    File.open(file_name, 'wb') do |file|
      group_names.each { |items| file << items + "\n" }
    end
  end

  describe '#group_names' do
    it { expect(MeetupThingy::InputFileReader.group_names(file_name)).to eq(group_names) }
  end
end
