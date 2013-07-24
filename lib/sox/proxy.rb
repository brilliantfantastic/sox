module Sox
  module Proxy
    def proxy(name)
      unless @proxy
        @proxy = RestfulOperation.new(base_url, auth, name)
      end
      @proxy
    end
  end
end
