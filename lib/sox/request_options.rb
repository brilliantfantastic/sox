module Sox
  class RequestOptions
    def request
      generate_xml
    end

    def initialize(method, options={})
      @method = method
      @options = options
    end

    private

    def generate_xml
      root = NSXMLElement.alloc.initWithName 'request'
      root.addAttribute NSXMLNode.attributeWithName('method', stringValue: @method)

      # Add all the options if there are any
      @options.each { |key, value| generate_xml_node root, key, value }

      document = NSXMLDocument.alloc.initWithRootElement root
      data = document.XMLDataWithOptions NSXMLDocumentTidyXML
      NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)
    end

    def generate_xml_node(element, key, value)
      if value.is_a? Hash
        parent = NSXMLElement.alloc.initWithName(key)
        value.each do |k, v|
          el = generate_xml_node parent, k, v
        end
      else
        el = NSXMLElement.alloc.initWithName(key, stringValue: value.to_s)
      end
      element.addChild el
      element
    end
  end
end
