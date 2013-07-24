module Sox
  module XML
    class ParserError < StandardError; end

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
        @current = @current[element.to_sym] = {} if element
        attrs.each {|k, v| @current = @current.merge!(k.to_sym => v)} if attrs
      end

      def parser(parser, didEndElement:element, namespaceURI:uri, qualifiedName:name)
        @current = @result[@result.keys[-1]]
      end

      def parser(parser, foundCharacters:string)
        @current = @current.merge! data: string
      end

      def parserDidEndDocument(parser)
        @callback.call(@result) if @callback
      end

      def parser(parser, parseErrorOccurred:parse_error)
        raise ParserError.new(parse_error.localizedDescription)
      end

      private

      def parse_data(data)
        parser = NSXMLParser.alloc.initWithData(data)
        parser.shouldProcessNamespaces = true
        parser.delegate = self
        parser.parse
      end
    end
  end
end
