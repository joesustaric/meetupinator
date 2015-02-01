require 'spec_helper'
require 'meetup_thingy/app'

describe MeetupThingy::App do

  describe '#version' do
    it 'prints the app version' do
      expect { subject.version() }.to match_stdout('meetup_thingy v0.1')
    end

  end
end