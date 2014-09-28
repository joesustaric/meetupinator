require 'spec_helper'
require 'vcr_setup'
require 'meetup_api'

describe MeetupAPI do
  describe '#get_meetup_id' do

    let(:group_id){ '9800072' }
    let(:group_url_name) { 'Ruby-On-Rails-Oceania-Melbourne' }

    describe 'getting the meetup id'

      it 'returns the id of the meetup' do
        VCR.use_cassette('groups') do
          expect(subject.get_meetup_id(group_url_name)).to eq(group_id)
        end
      end

      context 'no api key exported' do
        before do
          stub_const('ENV', {'MEETUP_API_KEY' => nil})
        end

        it 'raises a no api key error' do
            expect { subject.get_meetup_id(group_url_name) }.to raise_exception
        end

      end
    end


end
