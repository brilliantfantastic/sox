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
        @current = @result
      end

      def parser(parser, didStartElement:element, namespaceURI:uri, qualifiedName:name, attributes:attrs)
        @current = @result[element.to_sym] = {} if element
        attrs.each {|k, v| @current = @current.merge!(k.to_sym => v)} if attrs
      end

      def parser(parser, foundCharacters:string)
        @current = @current.merge! data: string
      end

      def parserDidEndDocument(parser)
        @callback.call(@result) if @callback
      end

      def parser(parser, parseErrorOccurred:parse_error)
        puts "ERROR #{parse_error.localizedDescription}"
      end

      private

      def parse_data(data)
        document = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        parser = NSXMLParser.alloc.initWithData(document)
        parser.shouldProcessNamespaces = true
        parser.delegate = self
        parser.parse
      end
    end
  end
end
