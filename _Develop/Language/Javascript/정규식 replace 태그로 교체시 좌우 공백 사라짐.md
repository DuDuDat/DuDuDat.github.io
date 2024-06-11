---
---

## 문제
원인은 모르겠지만 replace 할 때 태그로 교체할 경우 좌우 공백이 사라지는 문제가 발생함
```javascript
htmlContent.replace(/(\(([^)]+)\))/g, function(match, p1, p2, offset, string) {
    return `<span>(${p2})</span>`; // 괄호 좌우 공백 사라짐
});
```

## 해결
좌우에 문자열을 추가하면 해결됨
```javascript
const zeroWidthSpace = '\u200B'; // &nbsp와는 달리 실제로 공간을 차지하지 않음
htmlContent.replace(/(\(([^)]+)\))/g, function(match, p1, p2, offset, string) {
    return `${zeroWidthSpace}<span>(${p2})</span>${zeroWidthSpace}`;
});
```