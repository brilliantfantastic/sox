describe Sox::XML::Parser do
  describe '#parse' do
    before do
      document = "<element></element>"
      @parser = Sox::XML::Parser.new document
    end

    it 'yields to the block once parsing has finished' do
      hash = nil
      @parser.parse { |hsh| hash = hsh }
      hash.should != nil
    end

    it 'creates a hash with the element' do
      hash = nil
      @parser.parse { |hsh| hash = hsh }
      hash.should == { element: {} }
    end
  end
end
