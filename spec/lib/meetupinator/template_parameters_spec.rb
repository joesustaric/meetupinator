require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetupinator/formatter'

describe Meetupinator::TemplateParameters do
  let(:events) do
    [
      {
        event_name: 'Event A',
        start_time: Time.new(2015, 03, 21, 7, 0)
      },
      {
        event_name: 'Event B',
        start_time: Time.new(2015, 03, 19, 7, 0)
      },
      {
        event_name: 'Event C',
        start_time: Time.new(2015, 03, 19, 8, 0)
      }
    ]
  end

  subject do
    Meetupinator::TemplateParameters.new(events)
  end

  describe '#get_start_of_week' do
    it 'returns the given day if it is a Monday' do
      expect(subject.get_start_of_week(Time.new(2015, 3, 16))).to eq(Time.new(2015, 3, 16))
    end

    it 'returns the previous Monday if the day is not a Monday' do
      expect(subject.get_start_of_week(Time.new(2015, 3, 22))).to eq(Time.new(2015, 3, 16))
    end
  end

  describe '#sorted_events' do
    it 'returns the events in order sorted by start time' do
      expect(subject.sorted_events.map { |e| e[:event_name] }).to eq(['Event B', 'Event C', 'Event A'])
    end
  end
end
