require 'spec_helper'
require 'vcr_setup'
require 'meetup_thingy/meetup_api'

describe MeetupThingy::MeetupAPI do
  let(:group_id) { 980_007_2 }

  describe '#new' do
    context 'when there is no Meetup API key in the environment' do
      before { ENV['MEETUP_API_KEY'] = nil }

      it 'raises a no API key error if no API key is explicitly given' do
        expect { subject }.to raise_exception
      end

      it 'uses the API key given in the constructor' do
        key = 'My super-secret API key'
        subject = MeetupThingy::MeetupAPI.new key
        expect(subject.api_key).to eq(key)
      end
    end

    context 'when there is a Meetup API key in the environment' do
      let(:env_api_key) { '1234' }

      before { ENV['MEETUP_API_KEY'] = env_api_key }

      it 'uses the API given in the env if no API key is explicitly given' do
        expect(subject.api_key).to eq(env_api_key)
      end

      it 'uses the API key given in the constructor if one is given' do
        key = 'My super-secret API key'
        subject = MeetupThingy::MeetupAPI.new key
        expect(subject.api_key).to eq(key)
      end
    end
  end

  describe '#get_meetup_id' do
    let(:group_url_name) { 'Ruby-On-Rails-Oceania-Melbourne' }

    it 'returns the id of the meetup' do
      VCR.use_cassette('groups') do
        expect(subject.get_meetup_id(group_url_name)).to eq(group_id)
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
      let(:meetup_ids) { [group_id, 183_050_22] }
      let(:expected_number_of_events) { 73 }

      it 'returns all the upcoming events' do
        VCR.use_cassette('events_multiple_groups') do
          expect(subject.get_upcoming_events([meetup_ids]).size).to eq(expected_number_of_events)
        end
      end
    end
  end
end
