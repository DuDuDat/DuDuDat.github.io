---
---

## 코드
```javascript
$(e.target).hasClass('header-btn') // 이벤트가 발생한 객체 자신만 조회
$(e.target).closest('.menu-btn').length > 0 // 이벤트가 발생한 객체의 상위 객체에 존재하는지 조회함
```