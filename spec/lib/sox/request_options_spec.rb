describe Sox::RequestOptions do
  it 'specifies the request method in the xml' do
    request = Sox::RequestOptions.new('client.list').request
    request.should == '<request method="client.list"></request>'
  end

  it 'converts a simple hash to xml' do
    request = Sox::RequestOptions.new('client.list', { client_id: 1 }).request
    request.should == '<request method="client.list"><client_id>1</client_id></request>'
  end
end
