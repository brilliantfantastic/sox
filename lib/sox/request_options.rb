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
      document = NSXMLDocument.alloc.initWithRootElement root
      data = document.XMLDataWithOptions NSXMLDocumentTidyXML
      NSString.alloc.initWithData(data, encoding: NSUTF8StringEncoding)
    end
  end
end
