module Sox
  class RequestOptions
    def request
      "<request method=\"#{@method}\"></request>"
    end

    def initialize(method, options={})
      @method = method
      @options = options
    end
  end
end
