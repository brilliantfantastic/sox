module Sox
  class Client
    attr_reader :base_url

    def initialize(subdomain, api_token)
      @base_url = "https://#{subdomain}.freshbooks.com/api/#{Sox::API_VERSION}/xml-in"
      @api_token = api_token
    end

    def auth
      { username: @api_token, password: 'X' }
    end

    def get(request, &block)
      options = { credentials: auth }
      options.merge!({ payload: '<request method="client.list"></request>' })
      BW::HTTP.post(@base_url, options) do |response|
        #XML::Parser.new(response.body).parse do |hash|
        block.call response.body
        #end
      end
    end
  end
end
