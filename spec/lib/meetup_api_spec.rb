require 'spec_helper'
require 'vcr_setup'
require 'meetup_api'

describe MeetupAPI do
  describe '#get_meetup_id' do

    let(:group_id){ '9800072' }
    let(:group_url_name) { 'Ruby-On-Rails-Oceania-Melbourne' }
    let(:response) {'{"results":[{"id":"9800072"}]}'}
    let(:api_key) {'e176f7017712c636d307852216d828'}


    it 'returns the id of the meetup' do
      VCR.use_cassette('test') do
        expect(subject.get_meetup_id(group_url_name)).to eq(group_id)
      end
    end


  end

end
