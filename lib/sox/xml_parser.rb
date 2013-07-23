module Sox
  module XML
    class Parser
      def initialize(data)
        @data = data
      end

      def parse(&block)
        @callback = block
        parse_data @data
      end

      def parserDidStartDocument(parser)
        @result = {}
      end

      def parserDidEndDocument(parser)
        @callback.call(@result) if @callback
      end

      private

      def parse_data(data)
        parser = NSXMLParser.alloc.initWithData(data)
        parser.delegate = self
        parser.parse
      end
    end
  end
end
