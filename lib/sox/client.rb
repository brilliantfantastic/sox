module Sox
  class Client
    include Sox::Proxy

    attr_reader :base_url

    def initialize(subdomain, api_token)
      @base_url = "https://#{subdomain}.freshbooks.com/api/#{Sox::API_VERSION}/xml-in"
      @api_token = api_token
    end

    def auth
      { username: @api_token, password: 'X' }
    end

    def clients
      proxy(:client)
    end

    def projects
      proxy(:project)
    end
  end
end
