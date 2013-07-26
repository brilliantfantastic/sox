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
        @result = [{}]
      end

      def parser(parser, didStartElement:element, namespaceURI:uri, qualifiedName:name, attributes:attrs)
        element = element.to_sym
        parent = @result.last

        child = {}
        attrs.each { |k, v| child[k.to_sym] = v } if attrs

        existing = parent[element]

        if existing
          values = existing.is_a?(Array) ? existing << child : [existing, child]
          parent[element] = values
        else
          parent[element] = child
        end

        @result << child
      end

      def parser(parser, didEndElement:element, namespaceURI:uri, qualifiedName:name)
        @result.pop
      end

      def parser(parser, foundCharacters:string)
        @result.last[:data] = string.strip
      end

      def parserDidEndDocument(parser)
        @callback.call(@result.first) if @callback
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
