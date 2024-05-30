---
---

> 제목을 파일명으로 설정했을 때 자동으로 영어가 소문자로 변환되는 문제가 있었음

## 문제 원인
Jekyll 4.1.0 이후 버전에서 pre_render 훅에서 doc.data 를 설정하는 방식에 문제가 있었다 이는 Jekyll 의 Drops 라는 구조가 원인이라는 모양인데 구체적인 것은 잘 모르겠다.

## 해결
Jekyll 훅을 사용하여 pre_render 단계에서 설정하면 된다. 이 방법은 Drops 구조의 영향을 받지 않으므로 데이터 변환 문제를 피할 수 있다 
```ruby
Jekyll::Hooks.register :documents, :pre_render do |doc|
  filename = File.basename(doc.basename, File.extname(doc.basename))
  doc.data['title'] = filename
  puts "filename: #{filename}"
  puts "Stored title: #{doc.data['title']}"
end
```

[참고 사이트](https://humanwhocodes.com/blog/2019/04/jekyll-hooks-output-markdown/)