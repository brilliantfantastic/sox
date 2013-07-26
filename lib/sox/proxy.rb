module Sox
  module Proxy
    def proxy(name)
      @proxies = {} unless @proxies
      unless @proxies.key? name
        @proxies[name] = RestfulOperation.new(base_url, auth, name)
      end
      @proxies[name]
    end
  end
end
