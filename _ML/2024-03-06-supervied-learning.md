---
layout: post
title: 지도학습(Supervised Learning) 
date: 2024-03-06 01:37:23 +0900
---
### Decision Tree(결정 트리)
- 정의
  <p class="sub">분류와 회귀 문제에 널리 사용되는 머신러닝 알고리즘으로 데이터를 분석하여 데이터의 패턴을 학습하고, 학습된 패턴을 기반으로 결정 규칙을 Tree 구조로 구성하여 예측을 수행합니다.
  </p>
- 분할 기준(Split Criterion) : 트리의 각 노드에서 데이터를 분할할 때 사용하는 기준
  <table>
  <tr>
  <td>지니 계수 (Gini Impurity)</td>
  <td>한 노드가 포함하고 있는 샘플들을 무작위로 뽑았을 때 잘못 분류될 확률</td>
  </tr>
  <tr>
  <td>엔트로피 (Entropy)</td>
  <td>노드의 불순도를 측정하는 또 다른 방법으로 엔트로피가 높을 수록 데이터의 불확실성이 높다는 뜻이다.</td>
  </tr>
  <tr>
  <td>정보 이득 (Information Gain)</td>
  <td>부모와 자식 노드 간의 엔트로피 차이로 얼마나 많은 정보를 얻었는지 측정합니다.</td>
  </tr>
  </table>
- 장단점
  <p class="sub">장점 : 이해하기 쉽고 분류와 회귀 모두에 사용할 수 있다.
  단점 : 과적합 문제가 발생하기 쉽고 안정성이 낮다.
  </p>

### 앙상블(Ensemble)
- 정의
  <p class="sub">여러 학습 알고리즘을 조합하여 사용하는 방법으로, 기법 자체는 지도학습에 국한되진 않지만 주로 지도학습 문제를 해결하기 위해 사용되됩니다. 해당 기법은 단일 모델을 사용할 때보다 더 좋은 예측 성능을 얻는 것을 목적으로 합니다.</p>
- 학습 유형
  <table>
  <tr>
  <td>배깅 (Bagging)</td>
  <td>
  <li>동일한 유형의 알고리즘을 여러 개 사용</li>
  <li>훈련 데이터를 무작위로 다르게 샘플링 하여 각 모델을 다르게 학습</li>
  <li>예시 : 랜덤 포레스트(Random Forest) 등</li>
  </td>
  </tr>
  <tr>
  <td>부스팅 (Boosting)</td>
  <td>
  <li>여러 약한 학습기(Weak Learner)를 순차적으로 학습시키면서 잘못 예측된 데이터에 많은 가중치를 부여하여 오류를 개선해나가는 방식</li>
  <li>예시 : AdaBoost, Gradlent Boosting 등</li>
  </td>
  </tr>
  </table>