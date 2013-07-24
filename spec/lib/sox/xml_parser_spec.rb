describe Sox::XML::Parser do
  describe '#parse' do
    describe 'with a simple single element' do
      before do
        document = "<element></element>"
        @parser = Sox::XML::Parser.new document
      end

      it 'yields to the block once parsing has finished' do
        hash = nil
        @parser.parse { |hsh| hash = hsh }
        hash.should != nil
      end

      it 'creates a hash representing the document' do
        hash = nil
        @parser.parse { |hsh| hash = hsh }
        hash.should == { element: {} }
      end
    end

    describe 'with a simple single element and data' do
      before do
        document = "<element>value</element>"
        @parser = Sox::XML::Parser.new document
      end

      it 'creates a hash representing the document' do
        hash = nil
        @parser.parse { |hsh| hash = hsh }
        hash.should == { element: { data: 'value' } }
      end
    end

    describe 'with a simple single element and an attribute' do
      before do
        document = "<element attribute=\"attribute one\"></element>"
        @parser = Sox::XML::Parser.new document
      end

      it 'creates a hash representing the document' do
        hash = nil
        @parser.parse { |hsh| hash = hsh }
        hash.should == { element: { attribute: 'attribute one' } }
      end
    end

    describe 'with a simple single element and multiple attribute' do
      before do
        document = "<element attribute_one=\"attribute one\" attribute_two=\"attribute two\"></element>"
        @parser = Sox::XML::Parser.new document
      end

      it 'creates a hash representing the document' do
        hash = nil
        @parser.parse { |hsh| hash = hsh }
        hash.should == { element: { attribute_one: 'attribute one', attribute_two: 'attribute two' } }
      end
    end

    describe 'with a simple single element, multiple attribute, and a value' do
      before do
        document = "<element attribute_one=\"attribute one\" attribute_two=\"attribute two\">value</element>"
        @parser = Sox::XML::Parser.new document
      end

      it 'creates a hash representing the document' do
        hash = nil
        @parser.parse { |hsh| hash = hsh }
        hash.should == { element: { attribute_one: 'attribute one', attribute_two: 'attribute two', data: 'value' } }
      end
    end

    describe 'with a simple embedded element' do
      before do
        document = "<element_one><element_two></element_two></element_one>"
        @parser = Sox::XML::Parser.new document
      end

      it 'creates a hash representing the document' do
        hash = nil
        @parser.parse { |hsh| hash = hsh }
        hash.should == { element_one: { element_two: {} } }
      end
    end

    describe 'with a simple embedded element and a value' do
      before do
        document = "<element_one><element_two>value two</element_two></element_one>"
        @parser = Sox::XML::Parser.new document
      end

      it 'creates a hash representing the document' do
        hash = nil
        @parser.parse { |hsh| hash = hsh }
        hash.should == { element_one: { element_two: { data: 'value two' } } }
      end
    end

    describe 'with a simple embedded element, a value, and some attributes' do
      before do
        document = "<element_one attribute_one=\"attribute one\"><element_two attribute_two=\"attribute two\">value two</element_two></element_one>"
        @parser = Sox::XML::Parser.new document
      end

      it 'creates a hash representing the document' do
        hash = nil
        @parser.parse { |hsh| hash = hsh }
        hash.should == { element_one: { attribute_one: 'attribute one', element_two: { attribute_two: 'attribute two', data: 'value two' } } }
      end
    end

    describe 'with an invalid xml document' do
      before do
        document = '<element value></element>'
        @parser = Sox::XML::Parser.new document
      end

      it 'raises a parser error' do
        should.raise(Sox::XML::ParserError) { @parser.parse }
      end
    end
  end
end
