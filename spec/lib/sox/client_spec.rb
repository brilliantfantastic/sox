describe Sox::Client do
  extend WebStub::SpecHelpers

  before do
    #disable_network_access!

    @subdomain = 'fake'
    @api_token = '1234'
    @client = Sox::Client.new @subdomain, @api_token
  end

  describe '#initialize' do
    it 'sets the base url' do
      @client.base_url.should == "https://#{@subdomain}.freshbooks.com/api/#{Sox::API_VERSION}/xml-in"
    end
  end

  describe '#auth' do
    it 'sets the auth header using basic auth' do
      @client.auth.should == { username: @api_token, password: 'X' }
    end
  end

  describe 'retrieving a list of clients for the account' do
    it 'retrieves the client id from Freshbooks' do
      @client.get :clients do |response|
        @response = response
        resume
      end
      wait_max 1.0 do
        @response.length.should == '1234'
      end
    end
  end
end
