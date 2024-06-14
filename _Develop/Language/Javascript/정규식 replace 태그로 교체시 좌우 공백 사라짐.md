---
---

## 문제
태그와 태그 사이의 공백 무시됨
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