require 'spec_helper'
require 'vcr_setup'
require 'meetupinator/meetup_api'

# Query - Return something / change nothing
# Command - Return nothing / change something
# Test the interface not the implementation.
# eg
# Incoming Query Message --> [Test Object].return_balance
# Test incoming query messages, by making assertions about what they send back.

# Incoming Command Message --> [Test Object].set_something(y)
# Test incoming command messages by making assertions about the
# direct public side effects.

# Do not test private method calls, do not make assertions about their result.
# Don't expect to send/call them.
# (Break rule if it saves $$ during development)

# Do not test outgoing query messages.
# Do not make assertions about their result
# Do not expect them to send.

# If a message has no visible side effects the sender should not test it.

# Expect to send outgoing command messages.
# Break rule if side effects are stable and cheap.

describe Meetupinator::MeetupAPI do
  let(:group_id) { 980_007_2 }
  let(:env_api_key) { '1234' } # this key is coupled to the vcr tests

  describe '#new' do # Command
    context 'when there is no Meetup API key in the environment' do
      before { ENV['MEETUP_API_KEY'] = nil }

      it 'raises a no API key error if no API key is explicitly given' do
        expect { subject }.to raise_exception('no MEETUP_API_KEY provided')
      end

      it 'uses the API key given in the constructor' do
        key = 'My super-secret API key'
        subject = Meetupinator::MeetupAPI.new key
        expect(subject.api_key).to eq(key)
      end
    end

    context 'when there is a Meetup API key in the environment' do
      before { ENV['MEETUP_API_KEY'] = env_api_key }
      after { ENV['MEETUP_API_KEY'] = nil }

      it 'uses the API given in the env if no API key is explicitly given' do
        expect(subject.api_key).to eq(env_api_key)
      end

      it 'uses the API key given in the constructor if one is given' do
        key = 'My super-secret API key'
        subject = Meetupinator::MeetupAPI.new key
        expect(subject.api_key).to eq(key)
      end
    end
  end

  describe '#get_meetup_id' do # Query
    context 'when there is a Meetup API key in the environment' do
      before { ENV['MEETUP_API_KEY'] = env_api_key }
      after { ENV['MEETUP_API_KEY'] = nil }

      let(:group_url_name) { 'Ruby-On-Rails-Oceania-Melbourne' }

      it 'returns the id of the meetup' do
        VCR.use_cassette('groups') do
          expect(subject.get_meetup_id(group_url_name)).to eq(group_id)
        end
      end
    end
  end

  describe '#get_upcoming_events' do # Query
    context 'when there is a Meetup API key in the environment' do
      before { ENV['MEETUP_API_KEY'] = env_api_key }
      after { ENV['MEETUP_API_KEY'] = nil }

      context 'single group' do
        let(:expected_number_of_events) { 6 }

        it 'returns all the upcoming events' do
          VCR.use_cassette('events_single_group') do
            expect(subject.get_upcoming_events([group_id], nil).size).to eq(expected_number_of_events)
          end
        end

        it 'returns all the upcoming events for the next week' do
          VCR.use_cassette('events_next_week') do
            expect(subject.get_upcoming_events([group_id], 1).size).to eq(1)
          end
        end
      end

      context 'multiple groups' do
        let(:meetup_ids) { [group_id, 183_050_22] }
        let(:expected_number_of_events) { 73 }

        it 'returns all the upcoming events' do
          VCR.use_cassette('events_multiple_groups') do
            expect(subject.get_upcoming_events([meetup_ids], nil).size).to eq(expected_number_of_events)
          end
        end
      end
    end
  end
end
