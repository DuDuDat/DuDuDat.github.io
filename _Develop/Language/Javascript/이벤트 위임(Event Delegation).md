---
---

> jquery 와 같은 라이브러리에서 자주 사용되는 기술로 부모 요소에 이벤트 리스너를 설정하여 동적으로 생성되거나 존재하는 자식 요소에 이벤트를 효율적으로 처리할 수 있게 한다.

## 언제 사용하는가
- 페이지 로드 후에 동적으로 추가된 요소에 이벤트를 적용하고 싶을 때
- 각 요소에 이벤트 리스너를 추가하는 대신 하나의 이벤트 리스너를 추가하여 성능을 향상시킬 수 있음

## 코드 예시
```javascript
   $(document).on('click', 'div.highlight .copy-button', function() { // 이벤트 위임
       const div = $(this).closest('div.highlight');
       const index = div.index('div.highlight');

       const codeText = div.find('code').text();
       navigator.clipboard.writeText(codeText).then(function() {
           $('div.highlight .copy-button').eq(index).html('<i class="fa-regular fa-copy"></i> Copied');
       }).catch(function(err) {
                console.error('텍스트 복사에 실패했습니다: ', err);
        });
   });
```