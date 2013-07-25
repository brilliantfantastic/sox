module Sox
  module XML
    class ParserError < StandardError; end

    class Parser
      def initialize(data)
        @data = data
      end

      def parse(&block)
        puts
        @callback = block
        parse_data @data
      end

      def parserDidStartDocument(parser)
        puts "**** STARTING TO PARSE DOCUMENT ****"
        @result = {}
        @current = @result
        @parents = []
      end

      def parser(parser, didStartElement:element, namespaceURI:uri, qualifiedName:name, attributes:attrs)
        if element
          puts "**** FOUND ELEMENT #{element}, current: #{@current}, result: #{@result} ****"
          if @current.key? element.to_sym
            @parents.pop
            newValue = [@current[element.to_sym], {}]
            @current = @parents.last
            @current[@current.keys[0]] = newValue
            #@current[@current.key] = []
            puts "**** NUMBER OF PARENTS #{@parents.inspect} ****"
            puts "**** MODIFIED CURRENT FOR #{element}, current: #{@current}, result: #{@result} ****"
          else
            @current = @current[element.to_sym] = {}
            @parents << @current
            puts "**** MODIFIED CURRENT FOR #{element}, current: #{@current}, result: #{@result} ****"
          end
        end

        if attrs
          attrs.each {|k, v| @current = @current.merge!(k.to_sym => v)}
        end
      end

      def parser(parser, didEndElement:element, namespaceURI:uri, qualifiedName:name)
        @parents.pop
        @current = @parents.last
        puts "**** ELEMENT ENDED #{element}, result: #{@result.inspect} ****" if element
        #@current = @result[@result.keys[-1]]
      end

      def parser(parser, foundCharacters:string)
        @current = @current.merge! data: string
      end

      def parserDidEndDocument(parser)
        puts "**** ENDED PARSING OF DOCUMENT ****"
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
