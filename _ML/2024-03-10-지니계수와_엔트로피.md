---
layout: post
title: 지니 계수와 엔트로피
date: 2024-03-10 02:07:00 +0900
---
### 지니 계수
<table>
<tr>
<td class="letex">$$Gini = 1 - \sum^m_{k=1}p^2_k$$</td>
<td class="letex-desc">
$p_k$ : 특정 노드에서 클래스 $k$ 에 속하는 샘플의 비율 <br />
클래스 : 지도학습에서 사용되는 용어로 label 또는 카테고리를 의미한다. <br />
$k$ : 클래스의 인덱스
$m$ : 전체 클래스 개수
</td>
</tr>
</table>


### 엔트로피
<table>
<tr>
<td class="letex">$$Entropy = -\sum^m_{i=1}p_i\log_2p_i$$</td>
<td class="letex-desc">
$p_i$ : 특정 클래스 $i$ 에 속하는 샘플의 비율<br />
$m$ : 클래스의 총 개수
</td>
</tr>
</table>