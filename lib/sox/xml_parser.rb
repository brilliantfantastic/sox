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
        @current = ''
        @dictStack = [{}]
      end

      def parser(parser, didStartElement:element, namespaceURI:uri, qualifiedName:name, attributes:attrs)
        parentDict = @dictStack.last

        childDict = {}
        attrs.each { |k, v| childDict[k.to_sym] = v } if attrs

        existingValue = parentDict.objectForKey(element.to_sym)

        if existingValue
          array = []
          if existingValue.is_a? Array
            array = existingValue
          else
            array << existingValue

            parentDict.setObject(array, forKey:element.to_sym)
          end

          array << childDict
        else
          parentDict.setObject(childDict, forKey:element.to_sym)
        end

        @dictStack << childDict

      end

      def parser(parser, didEndElement:element, namespaceURI:uri, qualifiedName:name)
        dictInProgress = @dictStack.last

        if (@current.length > 0)
          trimmedString = @current.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet)
          dictInProgress.setObject(trimmedString.mutableCopy, forKey: :data)

          @current = ''
        end

        @dictStack.removeLastObject
      end

      def parser(parser, foundCharacters:string)
        @current.appendString string
      end

      def parserDidEndDocument(parser)
        @result = @dictStack.first
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
