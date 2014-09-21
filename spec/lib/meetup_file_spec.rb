require 'fakefs/spec_helpers'
require 'meetup_file'
require 'csv'

describe MeetupFile do

  describe '#get_meetups_missing_ids' do
    include FakeFS::SpecHelpers::All

    let(:file_headers) { ['group_urlname', 'group_id'] }
    let(:file_data) { [['a',nil],['b','123'],['c',nil]] }
    let(:file_path) { 'files/meetups.csv'}
    let(:meetups_without_ids) { [{"group_urlname"=>"a", "group_id"=>nil}, {"group_urlname"=>"c", "group_id"=>nil}] }

    def create_test_meetup_file path, data
      FileUtils.mkdir_p File.dirname(path)
      CSV.open(path, "wb", {:force_quotes=>false}) do |csv|
          csv << file_headers
          data.each { |row| csv << row }
      end
    end

    before do
      create_test_meetup_file file_path, file_data
    end

    it 'returns an array of meetup names without ids' do
      expect(subject.get_meetups_missing_ids).to eq(meetups_without_ids)
    end

  end

  describe '#update_file' do

    xit 'updates the rows with new id data' do

    end

  end

end
