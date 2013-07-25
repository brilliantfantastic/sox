describe Sox::RequestOptions do
  it 'specifies the request method in the xml' do
    request = Sox::RequestOptions.new('client.list').request
    request.should == '<request method="client.list"></request>'
  end

  #it 'converts a simple hash to xml' do
  #end
end
