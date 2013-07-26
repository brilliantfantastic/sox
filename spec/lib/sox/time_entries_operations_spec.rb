describe 'Freshbooks API time entries operations' do
  extend WebStub::SpecHelpers
  extend SpecHelper

  before do
    disable_network_access!
    @response = load_fixture('all_time_entries_successful_response.xml')
    @client = Sox::Client.new 'fake', '12345'
  end

  it 'can fetch all of the time entries' do
    stub_request(:post, @client.base_url).to_return body: @response, content_type: 'application/xml'

    @client.time_entries.all do |response|
      @response = response
      resume
    end
    wait_max 1.0 do
      response = @response[:response]
      response[:status].should == 'ok'
      response[:time_entries][:total].should == '2'
      response[:time_entries][:time_entry][0][:project_id][:data].should == '1'
      response[:time_entries][:time_entry][0][:hours][:data].should == '2'
    end
  end
end
