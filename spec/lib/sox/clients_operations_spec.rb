describe 'Freshbooks API clients operations' do
  extend WebStub::SpecHelpers
  extend SpecHelper

  before do
    disable_network_access!
    @response = load_fixture('all_clients_successful_response.xml')
    @client = Sox::Client.new 'fake', '12345'
  end

  it 'can fetch all of the clients' do
    stub_request(:post, @client.base_url).to_return body: @response, content_type: 'application/xml'

    @client.clients.all do |response|
      @response = response
      resume
    end
    wait_max 1.0 do
      @response[:response][:status].should == 'ok'
    end
  end
end
