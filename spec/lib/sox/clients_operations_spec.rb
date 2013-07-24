describe 'Freshbooks API clients operations' do
  extend WebStub::SpecHelpers

  before do
    disable_network_access!
  end

  describe 'fetching all of the clients' do
    @client.clients.all do |response|
      @response = response
      resume
    end
    wait_max 1.0 do
      puts @response
      #@response.length.should == '1234'
    end
  end
end
