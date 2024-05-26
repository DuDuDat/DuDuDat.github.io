---
---
## 사용자 정의 Liquid 필터 작성
```ruby
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
```

## Liquid 템플릿
```html
    {% raw %}{% assign dir = page.url | url_decode %}{% endraw %}
```