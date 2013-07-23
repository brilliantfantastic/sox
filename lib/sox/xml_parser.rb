module Sox
  module XML
    class Parser
      def initialize(data)
        parser = NSXMLParser.alloc.initWithData(data)
        parser.delegate ||= self
        parser.parse
      end

      def parserDidStartDocument(parser)
        puts "************************ STARTED *****************************"
      end
    end
  end
end
