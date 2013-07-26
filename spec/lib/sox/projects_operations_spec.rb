describe 'Freshbooks API projects operations' do
  extend WebStub::SpecHelpers
  extend SpecHelper

  before do
    disable_network_access!
    @response = load_fixture('all_projects_successful_response.xml')
    @client = Sox::Client.new 'fake', '12345'
  end

  it 'can fetch all of the projects' do
    stub_request(:post, @client.base_url).to_return body: @response, content_type: 'application/xml'

    @client.projects.all do |response|
      @response = response
      resume
    end
    wait_max 1.0 do
      response = @response[:response]
      response[:status].should == 'ok'
      response[:projects][:total].should == '2'
      response[:projects][:project][0][:project_id][:data].should == '6'
      response[:projects][:project][0][:name][:data].should == 'Super Fun Project'
      response[:projects][:project][0][:client_id][:data].should == '119'
    end
  end

  it 'can create a new project' do
    body = load_fixture('new_project_successful_response.xml')
    stub_request(:post, @client.base_url).to_return body: body, content_type: 'application/xml'

    request = { project: {
      name: 'Website Redesign',
      bill_method: 'project-rate',
      client_id: 21,
      rate: 45.00,
      description: 'A new website for ABC Corp',
      tasks: {
        task: {
          task_id: 5
        },
        task: {
          task_id: 3
        }
      }
    } }

    @client.projects.create(request) do |r|
      @response = r
      resume
    end
    wait_max 1.0 do
      response = @response[:response]
      response[:status].should == 'ok'
      response[:project_id][:data].should == '15'
    end
  end

end
