require 'liquid'
require 'cgi'

module Jekyll
  module URLDecode
    def url_decode(url)
      CGI.unescape(url)
    end
  end
end

Liquid::Template.register_filter(Jekyll::URLDecode)
