---
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
        let jsonData = $('#documents').text().trim().replace(/\\/g, '\\\\') // \ 하나 -> \\ 로 변환
        // jsonData = new Function('return' + jsonData)() 권장 X js 명령문이면 전부 실행되기 때문에 보안 문제가 생길 수 있음 
        // jsonData = eval(jsonData) 권장 X js 명령문이면 전부 실행되기 때문에 보안 문제가 생길 수 있음
        // jsonData = JSON.parse(jsonData)
    </script>
```
!! "\\" 는 반드시 별도로 escape 처리를 해줘야 한다.

++ strip_html 은 html 문법을 텍스트만 남기고 없애는 것이고 strip_newlines 는 엔터를 공백으로 바꿔주는 설정으로 알고 있는데 확실하진 않으니 나중에 찾아보도록 하자.