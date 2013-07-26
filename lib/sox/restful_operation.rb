module Sox
  class RestfulOperation
    attr_reader :prefix

    def initialize(base_url, auth, prefix)
      @base_url = base_url
      @auth = auth
      @prefix = prefix
    end

    def all(options={}, &block)
      post("#{@prefix}.list", options, &block)
    end

    def create(options={}, &block)
      post("#{@prefix}.create", options, &block)
    end

    private

    def post(path, options, &block)
      payload = RequestOptions.new(path, options).request
      opts = { credentials: @auth }
      opts.merge!({ payload: payload })
      BW::HTTP.post(@base_url, opts) do |response|
        XML::Parser.new(response.body).parse { |hash| block.call hash }
      end
    end
  end
end

