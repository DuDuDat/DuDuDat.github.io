---
---
> 일반적으론 사용할 일이 거의 없을 거 같긴 한데 원본을 그대로 두고 테스트를 하거나 대용량 데이터 중 일부만 사용할 때 쓰면 괜찮을 거 같기도 하고?   

## 코드 예시
```sql
    INSERT INTO TABLEA (ID, NAME)
    SELECT ID, NAME FROM TABLEB;
```