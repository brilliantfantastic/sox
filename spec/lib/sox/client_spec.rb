describe Sox::Client do
  before do
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

  describe '#clients' do
    it 'returns a proxy object' do
      @client.clients.prefix.should == :client
    end
  end

  describe '#projects' do
    it 'returns a proxy object' do
      @client.projects.prefix.should == :project
    end
  end

  it 'can have multiple proxies' do
    @client.clients.prefix.should == :client
    @client.projects.prefix.should == :project
  end
end
