# encoding: utf-8
require 'cgi'

module Jekyll
  module UrlDecodeFilter
    def url_decode(url)
      CGI.unescape(url)
    end
  end
end

Liquid::Template.register_filter(Jekyll::UrlDecodeFilter)