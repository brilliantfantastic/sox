module Sox
  class RestfulOperation
    attr_reader :prefix

    def initialize(base_url, auth, prefix)
      @base_url = base_url
      @auth = auth
      @prefix = prefix
    end

    def all(options={}, &block)
      payload = RequestOptions.new("#{@prefix}.list", options).request
      opts = { credentials: @auth }
      opts.merge!({ payload: payload })
      BW::HTTP.post(@base_url, opts) do |response|
        XML::Parser.new(response.body).parse do |hash|
          block.call hash
        end
      end
    end
  end
end

