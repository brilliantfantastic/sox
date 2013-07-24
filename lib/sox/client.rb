module Sox
  class Client
    attr_reader :client_id

    def self.get(subdomain, api_token, &block)
      BW::HTTP.get("https://#{subdomain}.freshbooks.com/api/#{Sox::API_VERSION}/xml-in") do |response|
        XML::Parser.new(response.body).parse do |hash|
          client = Client.new
          block.call client
        end
      end
    end
  end
end
