describe 'Freshbooks API time entries operations' do
  extend WebStub::SpecHelpers
  extend SpecHelper

  before do
    disable_network_access!
    @client = Sox::Client.new 'fake', '12345'
  end

  it 'can fetch all of the time entries' do
    body = load_fixture('all_time_entries_successful_response.xml')
    stub_request(:post, @client.base_url).to_return body: body, content_type: 'application/xml'

    @client.time_entries.all do |r|
      @response = r
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

  it 'can create a new time entry' do
    body = load_fixture('new_time_entry_successful_response.xml')
    stub_request(:post, @client.base_url).to_return body: body, content_type: 'application/xml'

    request = { time_entry: {
      project_id: 1,
      task_id: 1,
      hours: 4.5,
      notes: 'Phone consultation'
    } }

    @client.time_entries.create(request) do |r|
      @response = r
      resume
    end
    wait_max 1.0 do
      response = @response[:response]
      response[:status].should == 'ok'
      response[:time_entry_id][:data].should == '211'
    end
  end
end
