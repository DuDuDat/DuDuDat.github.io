---
layout: post
title: ANSI-SPARC 아키텍처
date: 2024-03-09 00:08:23 +0900
---
- #### 정의
  <p class="sub">DBMS의 설계와 데이터 독립성을 위해 제안된 추상화 수준의 스키마</p>
- #### 스키마 3단계
  <table>
  <tr>
  <td>외부 스키마</td>
  <td>
  <li>개별 사용자나 사용자 그룹이 DB에 접근할 때 보게 되는 데이터의 뷰(VIEW)</li>
  <li>필요한 데이터만 보여줌</li>
  </td>
  </tr>
  <tr>
  <td>개념 스키마</td>
  <td>
  <li>DB의 전체적인 논리적 구조</li>
  <li>모든 Entity 와 관계, 제약 조건, 무결성 규칙 등</li>
  </td>
  </tr>
  <tr>
  <td>내부 스키마</td>
  <td>
  <li>데이터가 실제로 저장되는 방식(물리적 저장 구조와 접근 경로 등)</li>
  <li>DBMS의 성능 최적화와 관련이 깊고 DBA에 의해 다뤄짐</li>
  </td>
  </tr>
  </table>
- #### 독립성
  <table>
  <tr><td>논리적 독립성</td><td>개념 스키마가 변경되어도 외부 스키마 영향 X</td></tr>
  <tr><td>물리적 독립성</td><td>내부 스키마가 변경되어도 외부/개념 스키마 영향 X</td></tr>
  </table>