require 'spec_helper'
require 'meetup_thingy/event_finder'
require 'meetup_thingy/meetup_api'

describe MeetupThingy::EventFinder do
  describe '#extract_events' do
    let(:meetups) do
      {
        'first' => 101,
        'second' => 201,
        'third' => 301
      }
    end

    let(:events) { [:first_event, :another_event, :more_events, :final_event] }

    let(:api) { instance_double(MeetupThingy::MeetupAPI) }

    before do
      allow(api).to receive(:get_meetup_id) { |name| meetups[name] }
      allow(api).to receive(:get_upcoming_events).with(meetups.values) { events }
    end

    it { expect(subject.extract_events(meetups.keys, api, nil)).to eq(events) }
  end
end
