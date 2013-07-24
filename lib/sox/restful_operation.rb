module Sox
  class RestfulOperation
    attr_reader :prefix

    def initialize(base_url, auth, prefix)
      @base_url = base_url
      @auth = auth
      @prefix = prefix
    end

    def all(options={}, &block)
      options.merge!({ credentials: @auth })
      options.merge!({ payload: "<request method=\"#{@prefix}.list\"></request>" })
      BW::HTTP.post(@base_url, options) do |response|
        XML::Parser.new(response.body).parse do |hash|
          block.call hash
        end
      end
    end
  end
end

