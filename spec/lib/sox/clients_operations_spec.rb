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
      response = @response[:response]
      response[:status].should == 'ok'
      response[:clients][:total].should == '2'
      response[:clients][:client][0][:client_id][:data].should == '1'
      response[:clients][:client][0][:first_name][:data].should == 'Jane'
      response[:clients][:client][1][:client_id][:data].should == '2'
      response[:clients][:client][1][:first_name][:data].should == 'John'
    end
  end

  it 'can create a new client' do
    body = load_fixture('new_client_successful_response.xml')
    stub_request(:post, @client.base_url).to_return body: body, content_type: 'application/xml'

    request = { client: {
      first_name: 'Jane',
      last_name: 'Doe',
      organization: 'ABC Corp',
      username: 'janedoe',
      contacts: {
        contact: {
          username: 'alex',
          first_name: '',
          last_name: '',
          email: 'test@freshbooks.com'
        }
      }
    } }

    @client.clients.create(request) do |r|
      @response = r
      resume
    end
    wait_max 1.0 do
      response = @response[:response]
      response[:status].should == 'ok'
      response[:client_id][:data].should == '13'
    end
  end

end
