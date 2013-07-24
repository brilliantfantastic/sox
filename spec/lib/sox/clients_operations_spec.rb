describe 'Freshbooks API clients operations' do
  extend WebStub::SpecHelpers

  before do
    disable_network_access!
    @client = Sox::Client.new 'fake', '12345'
    @all_clients_response = '<response xmlns="http://www.freshbooks.com/api/" status="ok"></response>'
  end

  it 'can fetch all of the clients' do
    stub_request(:post, @client.base_url).to_return body: @all_clients_response, content_type: 'application/xml'

    @client.clients.all do |response|
      @response = response
      resume
    end
    wait_max 1.0 do
      @response[:response][:status].should == 'ok'
    end
  end
end
