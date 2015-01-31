require 'spec_helper'
require 'vcr_setup'
require 'meetup_thingy/meetup_api'

describe MeetupThingy::MeetupAPI do

  let(:group_id) { 9800072 }

  describe '#new' do
    context 'when there is no MEETUP api key in the environment' do

      before do
        stub_const('ENV', {'MEETUP_API_KEY' => nil})
      end

      it 'raises a no api key error' do
        expect { subject }.to raise_exception
      end
    end

  end

  describe '#get_meetup_id' do

    let(:group_url_name) { 'Ruby-On-Rails-Oceania-Melbourne' }

    describe '#get_meetup_id' do

      it 'returns the id of the meetup' do
        VCR.use_cassette('groups') do
          expect(subject.get_meetup_id(group_url_name)).to eq(group_id)
        end
      end
    end

  end

  describe '#get_upcoming_events' do

    context 'single group' do
      let(:expected_number_of_events) { 6 }

      it 'returns all the upcoming events' do
        VCR.use_cassette('events_single_group') do
          expect(subject.get_upcoming_events([group_id]).size).to eq(expected_number_of_events)
        end
      end
    end

    context 'multiple groups' do
      let(:meetup_ids) { [group_id, 18305022] }
      let(:expected_number_of_events) { 73 }

      it 'returns all the upcoming events' do
        VCR.use_cassette('events_multiple_groups') do
          expect(subject.get_upcoming_events([meetup_ids]).size).to eq(expected_number_of_events)
        end
      end
    end

  end
end
