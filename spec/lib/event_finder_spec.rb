require 'spec_helper'
require 'event_finder'

describe EventFinder do

  describe '#get_events_for_meetups' do
    let (:meetups) {
      {
          'first' => 101,
          'second' => 201,
          'third' => 301
      }
    }

    let (:events) { [:first_event, :another_event, :more_events, :final_event] }

    let (:api) { double() }

    before do
      allow(api).to receive(:get_meetup_id) { |name| meetups[name] }
      allow(api).to receive(:get_upcoming_events).with(meetups.values) { events }
    end

    it 'returns the future events for all meetups given' do
      expect(subject.get_events_for_meetups(meetups.keys, api)).to eq(events)
    end
  end
end