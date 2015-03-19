require 'fakefs/spec_helpers'
require 'spec_helper'
require 'meetupinator/formatter'

describe Meetupinator::TemplateParameters do
  let(:events) { [] }

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
end
