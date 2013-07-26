describe Sox::RequestOptions do
  it 'specifies the request method in the xml' do
    request = Sox::RequestOptions.new('client.list').request
    request.should == '<request method="client.list"></request>'
  end

  it 'converts a simple hash to xml' do
    request = Sox::RequestOptions.new('client.list', { client_id: 1 }).request
    request.should == '<request method="client.list"><client_id>1</client_id></request>'
  end

  it 'converts an embedded hash to xml' do
    request = Sox::RequestOptions.new('client.list', { client: { client_id: 1 } }).request
    request.should == '<request method="client.list"><client><client_id>1</client_id></client></request>'
  end

  it 'converts a super duper embedded hash to xml' do
    request = Sox::RequestOptions.new('client.list', { client: { address: { street: '123 Main St.' } } }).request
    request.should == '<request method="client.list"><client><address><street>123 Main St.</street></address></client></request>'
  end

  it 'converts a converts a child list to xml' do
    request = Sox::RequestOptions.new('client.list', { client: { attribute_one: 1, attribute_two: 2 } }).request
    request.should == '<request method="client.list"><client><attribute_one>1</attribute_one><attribute_two>2</attribute_two></client></request>'
  end
end
