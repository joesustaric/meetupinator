require 'spec_helper'
require 'test'

describe Test do

  describe '#hello' do

    it 'says Hello' do
      expect(subject.hello).to eq('Hello World!')
    end

  end

end
