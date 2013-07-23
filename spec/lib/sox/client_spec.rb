describe Sox::Client do
  describe '#get' do
    before do
      @subdomain = 'fake'
      @api_token = '12345'
    end

    it 'retrieves the client id from Freshbooks' do
      Sox::Client.get @subdomain, @api_token do |client|
        @client = client
        resume
      end
      wait_max 1.0 do
        @client.client_id.should == '1234'
      end
    end
  end
end
