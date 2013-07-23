describe Sox::Client do
  describe '#get' do
    it 'retrieves the client id from Freshbooks' do
      client = Sox::Client.get subdomain, api_token
      client.client_id.should == '1234'
    end
  end
end
