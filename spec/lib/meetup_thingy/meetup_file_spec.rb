require 'fakefs/spec_helpers'
require 'meetup_thingy/meetup_file'
require 'csv'

describe MeetupThingy::MeetupFile do
  include FakeFS::SpecHelpers::All

  let(:file_data) { [['a', nil], %w(b '123'), ['c', nil]] }
  let(:file_path) { 'files/meetups.csv' }
  let(:file_headers) { %w(group_urlname group_id) }

  def create_test_meetup_file(path, data)
    FileUtils.mkdir_p File.dirname(path)
    CSV.open(path, 'wb', force_quotes: false) do |csv|
      csv << file_headers
      data.each { |row| csv << row }
    end
  end

  describe '#new' do
    let(:expected_initial_content) do
      [{ 'group_urlname' => 'a', 'group_id' => nil },
       { 'group_urlname' => 'b', 'group_id' => '\'123\'' },
       { 'group_urlname' => 'c', 'group_id' => nil }]
    end
    before do
      create_test_meetup_file file_path, file_data
    end

    it 'loads all the file data' do
      expect(subject.file_content).to eq(expected_initial_content)
    end
  end

  describe '#fill_meetups_missing_ids' do
    let(:meetups_without_ids) do
      [{ 'group_urlname' => 'a', 'group_id' => nil },
       { 'group_urlname' => 'c', 'group_id' => nil }]
    end

    before do
      create_test_meetup_file file_path, file_data
    end

    it 'returns an array of meetup rows without ids' do
      expect(subject.fill_meetups_missing_ids).to eq(meetups_without_ids)
    end
  end

  describe '#update_file' do
    let(:meetups_with_updated_ids) do
      [{ 'group_urlname' => 'a', 'group_id' => '123' },
       { 'group_urlname' => 'c', 'group_id' => '321' }]
    end

    before do
      create_test_meetup_file file_path, file_data
    end

    it 'updates the rows with new id data' do
      subject.update_file meetups_with_updated_ids
      expect(subject.fill_meetups_missing_ids).to eq([])
    end
  end
end
