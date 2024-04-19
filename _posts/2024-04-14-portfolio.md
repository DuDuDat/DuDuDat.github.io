---
title: 포트폴리오
---

<h3>☀️ 음악 장르 추천 시스템</h3> 
<table>
<tr>
    <td colspan="2">
        <div class="title">프로젝트 개요</div>
        <div class="sub-title">프로젝트 목표</div>
        <ul>
            <li>오늘의 날씨에 맞는 음악 장르 추천</li>
        </ul>
        <div class="sub-title">프로젝트 전제 조건</div>
        <ul>
            <li>음악 선택시 기분이 중요한 요소로 작용한다는 가정하에 이에 영향을 미칠 수 있는 날씨를 기반으로 음악 장르 추천</li>
            <li>하루 동안의 날씨 변화 패턴이 음악 선호도에 영향을 미칠 것으로 가정함</li>
            <li>각 국가의 행정 구역 경계면을 기준으로 날씨 데이터를 분류한 뒤 경계면 내 도시 중 가장 가까운 위치로 날씨를 분류함</li>
            <li>인기 음악의 단어 유사도를 사용해 장르 선호도 가중치를 계산할 때 단어 유사도가 낮은 값들은 부정적인 영향을 미칠 것으로 가정함</li>
        </ul>
    </td>
</tr>
<tr>
    <td colspan="2">
        <div class="title">데이터 소개</div>
        <div class="sub-title">장르 분류 모델</div>
        <ul>
            <li>🎤 음악 특성 데이터 : 다양한 음악 특성(템포, 에너지), 장르 O</li>
            <li>⛅ 캐글 날씨 데이터 : 2019년 동안 수집된 음악 청취수, 유럽의 날씨, 다양한 음악 특성, 장르 X</li>
        </ul>
        <div class="sub-title">장르 추천 모델</div>
        <ul>
            <li>🎧 장르 라벨링된 2019년 음악 청취수 데이터 (캐글 날씨 데이터에서 추출)</li>
            <li>☔ 위치 기반 날씨 (온도, 습도) 데이터</li>
            <li>🌐 국가별 행정 구역 (경계면), 도시 (중심좌표) 등 지리 데이터</li>
            <li>🎼 장르 선호도 분석용 국가별 TOP 100 음악 태그</li>
        </ul>
    </td>
</tr>
<tr>
    <td colspan="2" style="padding-bottom: 2rem;">
        <div class="title">프로젝트 진행 순서</div>
        <img style="width: 95%; display: block; margin: 0 auto;" src="{{root_url}}/public/img/portfolio/워크플로우.png" />
    </td>
</tr>
<tr>
    <td colspan="2">
        <div class="title">데이터 분석/처리</div>
        <div class="sub-title">장르 분류 모델을 통해 라벨링 된 캐글 날씨 데이터 탐색</div>
        <img src="{{root_url}}/public/img/portfolio/장르라벨링된 날씨 데이터 탐색.png" />
        <div style="margin: 0.5rem; font-size: 1rem; font-weight: 600; text-align: center">
            <span style="background: #eeeeee; padding: 0.1rem 1rem;">오스트리아를 제외한 모든 국가가 같은 데이터를 가지고 있음을 확인, 2019년 유럽 날씨 데이터 재수집 진행</span>
        </div>
    </td>
</tr>
<tr>
    <td class="width-60" style="border-right: none; border-top: none; border-bottom: none">
        <div class="sub-title">데이터 필터링을 위한 기후 분류</div>
        <img src="{{root_url}}/public/img/portfolio/데이터 필터링을 위한 기후 분류.png" />
    </td>
    <td style="border-left: none; border-top: none; border-bottom: none">
        <div class="sub-title" style="opacity: 0">데이터 필터링을 위한 기후 분류</div>
        <div style="font-weight: 800; margin-bottom: 0.8rem">데이터의 방대함으로 인한 학습지연 해결 목적</div>        
        <div>
            <div class="desc-title">방법</div>
            <div class="desc-sub">쾨펜의 기후 분류로 한국과 유사한 기후 국가 선별</div>
        </div>
        <div>
            <div class="desc-title">분류 결과</div>
            <div class="desc-sub">유럽이 아닌 대륙 중 유럽 기후로 분류되는 도시가 있음</div>
        </div>
        <div>
            <div class="desc-title">문제 확인</div>
        <div class="desc-sub">인구수 데이터를 사용하기 위해 최근접 알고리즘으로 누락된 데이터를 채웠으므로 거리가 먼 대륙에 도시가 있으면 비정상적인 데이터가 들어갈 수 있음</div>
        </div>
        <div>
            <div class="desc-title">해결</div>
            <div class="desc-sub"><span style="font-size:0.9rem">DBSCAN</span>을 사용해 거리 기준을 초과하는 도시를 포함하는 국가 제외</div>
        </div>
    </td>
</tr>
<tr>
    <td colspan="2" style="border-top: none">
        <div class="sub-title">날씨 패턴 라벨링 + 인구수 가중치</div>
        <img style="width: 95%; display: block; margin: 1.5rem auto 0;" src="{{root_url}}/public/img/portfolio/시계열클러스터링.png" />
        <div style="margin: 1rem 0 0.5rem; font-size: 1rem; font-weight: 600; text-align: center">
            <span style="padding: 0.1rem 1rem;">시계열 클러스터를 사용해 하루동안의 날씨 패턴에 번호를 붙여 라벨링한 후 그 안의 값은 스케일링된 인구수의 합으로 채움</span>
        </div>        
    </td>
</tr>
<tr>
    <td colspan="2" style="border-top: none;">
        <div class="sub-title">Glove 모델을 사용한 국가별 장르 선호도 가중치</div>
        <div>
            <div class="d-flex" style="padding: 1rem">
                <div class="flex-1" style="padding: 0 2rem">
                    <div class="circle">
                        <div style="font-size: 1.5rem">🔗</div>
                        단어 유사도 추출
                    </div>
                </div>
                <div class="next-arrow"><span class="material-symbols-outlined">arrow_forward_ios</span></div>
                <div class="flex-1" style="padding: 0 2rem">
                    <div class="circle">
                        <div style="font-size: 1.5rem">⚖️</div>
                        가중치 조정
                    </div>
                </div>
                <div class="next-arrow"><span class="material-symbols-outlined">arrow_forward_ios</span></div>
                <div class="flex-1" style="padding: 0 2rem">
                    <div class="circle">
                        <div style="font-size: 1.5rem">🇰🇷</div>
                        한국 취향 반영
                    </div>
                </div>
            </div>
            <div class="d-flex" style="padding: 0 1rem 0.5rem">
                <div class="flex-1" style="padding: 0 2rem">
                    학습된 Glove 모델을 다운받아 장르와 태그 사이의 단어 유사도 값을 추출함
                </div>
                <div style="opacity: 0" class="next-arrow"><span class="material-symbols-outlined">arrow_forward_ios</span></div>
                <div class="flex-1" style="padding: 0 2rem">
                    e 지수함수를 사용하여 연관성 낮은 단어의 영향력을 낮춤
                </div>
                <div style="opacity: 0" class="next-arrow"><span class="material-symbols-outlined">arrow_forward_ios</span></div>
                <div class="flex-1" style="padding: 0 2rem">
                    조정된 가중치를 각 국가의 장르 청취수에 반영한 뒤 한국의 취향을 반영하기 위해 한국의 가중치도 반영함
                </div>
            </div>
        </div>
    </td>
</tr>
<tr>
    <td colspan="2" style="border-top: none;">
        <div class="sub-title">오늘의 추천 장르 출력</div>
        <div class="d-flex" style="padding: 1rem">
            <div>날씨 패턴별 상관계수가 가장 높은 장르 추출</div>
            <div class="next-arrow"><span class="material-symbols-outlined">arrow_right_alt</span></div>
            <div>기상청 API 연동을 통해 오늘의 날씨 패턴 확인</div>
            <div class="next-arrow"><span class="material-symbols-outlined">arrow_right_alt</span></div>
            <div>오늘의 추천 장르 출력</div>
        </div>
    </td>
</tr>
</table>

[//]: # ()
[//]: # (<div class="project-container">)

[//]: # ()
[//]: # (<div class="row">)

[//]: # (<div class="col-6">)

[//]: # (    <div class="title">프로젝트 전제 조건</div>)

[//]: # (    <ul>)

[//]: # (        <li>음악 선택시 기분이 중요한 영향 요소로 작용한다는 가정하에 이에 영향을 미칠 수 있는 날씨를 기반으로 음악 장르를 추천합니다.</li>)

[//]: # (        <li>하루 동안의 날씨 변화가 음악 선호도에 영향을 미칠 것으로 가정합니다.</li>)

[//]: # (        <li>각 국가의 인기 음악 태그와 장르 간 단어 유사도를 활용하여 장르 선호도 가중치를 계산합니다. 이 과정에서 단어 유사도가 낮은 값들은 부정적인 영향을 미칠 것으로 추가 가정했습니다.</li>)

[//]: # (    </ul>)

[//]: # (</div>)

[//]: # (<div class="col-6">)

[//]: # (    <div class="title">데이터 소개</div>)

[//]: # (    <div>)

[//]: # (        <div class="sub-title">장르 분류 모델</div>)

[//]: # (        <ul>)

[//]: # (            <li>음악 특성 데이터 : 다양한 음악 특성&#40;템포, 에너지&#41;, 장르 O</li>)

[//]: # (            <li>캐글 날씨 데이터 : 2019년 동안 수집된 음악 청취수, 유럽의 날씨, 다양한 음악 특성, 장르 X</li>)

[//]: # (        </ul>)

[//]: # (    </div>)

[//]: # (    <div>)

[//]: # (        <div class="sub-title">장르 추천 모델</div>)

[//]: # (        <ul>)

[//]: # (            <li>장르 라벨링된 2019년 음악 청취수 데이터 &#40;캐글 날씨 데이터에서 추출&#41;</li>)

[//]: # (            <li>날씨 데이터 : 위치 기반 날씨 &#40;온도, 습도&#41;</li>)

[//]: # (            <li>지리 데이터 : 국가별 행정 구역 &#40;경계면&#41;, 도시 &#40;중심좌표&#41;</li>)

[//]: # (            <li>장르 선호도 분석용 데이터 : 국가별 TOP 100 음악 태그</li>)

[//]: # (        </ul>)

[//]: # (    </div>)

[//]: # (</div>)

[//]: # (</div>)

[//]: # ()
[//]: # (<div class="row">)

[//]: # (    <div class="col-12">)

[//]: # (        <div>샤라랄</div>)

[//]: # (    </div>)

[//]: # (</div>)

[//]: # (</div>)

[//]: # ([//]: # &#40;### 프로젝트 개요&#41;)
[//]: # ()
[//]: # ([//]: # &#40;#### 프로젝트 목표&#41;)
[//]: # ()
[//]: # ([//]: # &#40;- 오늘의 날씨에 추천 시스템 &#41;)
[//]: # ()
[//]: # ([//]: # &#40;&#41;)
[//]: # ([//]: # &#40;#### 프로젝트 전제조건&#41;)
[//]: # ()
[//]: # ([//]: # &#40;- 음악 선택 시 기분이 중요한 영향 요소로 작용한다는 가정 하에, 기분에 영향을 미칠 수 있는 날씨를 기반으로 음악 장르를 추천합니다.&#41;)
[//]: # ()
[//]: # ([//]: # &#40;- 하루 동안의 날씨 변화가 음악 선호도에 영향을 미칠 것으로 가정합니다.&#41;)
[//]: # ()
[//]: # ([//]: # &#40;- 각 국가의 인기 음악 태그와 장르 간의 단어 유사도를 활용하여 장르 선호도를 예측합니다. 이 과정에서 단어 유사도가 낮은 값들은 부정적인 영향을 미칠 것으로 추가 가정하였습니다.&#41;)
[//]: # ()
[//]: # ()
[//]: # (### 프로젝트 진행 순서)

[//]: # ()
[//]: # (### 프로젝트 중 직면한 문제와 해결방법)

[//]: # ()
[//]: # (#### 문제 1: 캐글에서 구했던 날씨 관련 데이터&#40;2019년 동안 수집된 유럽 날씨, 음악 특성, 음악 청취수&#41;에는 장르 정보가 미포함되어있음)

[//]: # (- 장르와 음악 특성 데이터가 있는 데이터를 구해 장르 분류 모델을 만들어 장르 라벨링을 수행함)

[//]: # ()
[//]: # (#### 문제 2: 기존 날씨 데이터에서 오스트리아를 제외한 모든 국가가 같은 날씨 데이터를 가지고 있음을 확인)

[//]: # (- 2019년 유럽 날씨 데이터만 재수집)

[//]: # ()
[//]: # (#### 문제 3: 기후 데이터의 방대함으로 인해 학습 시간이 과도하게 오래 걸리는 문제가 발생)

[//]: # (- 쾨펜의 기후 분류로 한국과 유사한 기후 국가를 선별함)

[//]: # ()
[//]: # (#### 문제 4: 유럽 국가에 해외 자치구가 있는 경우가 있음을 확인했는데 문제는 기존 부족한 기후 데이터의 경우 K-이웃 알고리즘을 사용했기 때문에 비정상적인 값이 들어가는 경우가 발생함)

[//]: # (- DBSCAN을 사용해 거리 기준을 초과하는 도시를 포함한 국가를 제외함)

[//]: # ()
[//]: # (### 데이터 수집/처리/분석)

[//]: # ()
[//]: # (- )

[//]: # ()
[//]: # (### 프로젝트 리뷰 &#40;무엇을 개선할 수 있었나&#41;)

[//]: # (- 데이터 전처리 방식을 좀 더 효율적으로 진행할 수 있었을 거 같음)

[//]: # (- 시간이 부족해 가설 검증 단계를 거치지 못함)

[//]: # (- )