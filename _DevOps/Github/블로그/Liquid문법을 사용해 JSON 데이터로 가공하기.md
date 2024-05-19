---
layout: post
title: Liquid -> JSON 데이터 가공하는 방법
---

# 데이터 가공하기
- 데이터를 동적으로 관리하기 위함
- 사용하기 쉽도록 데이터를 JSON 형태로 가공함

## site.documents -> json
script 태그를 사용하여 데이터를 JSON 형태로 만들 수 있다. script 태그도 일종의 객체이니 class나 id를 사용해서 객체에 저장된 값을 가져오거나 관리하는 것이 가능한 거 같다.
```html
    <script id="documents" type="application/json">{% raw %}
    [
        {% for doc in site.documents %}
        {% assign arr = doc.path | split: '/' %}
        {% assign index = arr.size | minus: 2 %}
        {
            "label": "{{ arr[index] }}",
            "image": "{{ doc.img }}",
            "url": "{{ doc.url | relative_url | escape }}",
            "title": "{{ doc.title | escape }}",
            "date": "{{ doc.date | date: '%Y-%m-%d' | escape }}",
            "content": "{{ doc.content | strip_html | strip_newlines | escape | truncatewords: 20 }}"
        }{% unless forloop.last %},{% endunless %}
        {% endfor %}
    ]{% endraw %}
    </script>
    
    <script>
        let jsonData = $('#documents').text()
        jsonData = JSON.parse(jsonData)
    </script>
```
여기서 주의해야 할 것이 있는데 그건 바로 document의 content 항목 처리다 이걸 잘못하면 JSON을 파싱할 수 없다. 주로 따옴표나 엔터로 인해 발생하는 문제 같은데 정확한 건 모르겠지만 일단 strip_html과 strip_newlines 처리를 해줬더니 해결되었다.

strip_html은 html 문법을 텍스트만 남기고 없애는 것이고 strip_newlines는 엔터를 공백으로 바꿔주는 설정으로 알고 있는데 확실하진 않으니 나중에 찾아보도록 하자.