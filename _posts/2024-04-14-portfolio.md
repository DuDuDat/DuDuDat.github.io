---
title: 포트폴리오
---

<h3>☀️ 음악 장르 추천 시스템</h3>
<table>
<tr>
    <td colspan="2">
        <div class="title">프로젝트 개요</div>
        <div class="sub-title">프로젝트 목표</div>
        <ul><div>오늘의 날씨에 맞는 음악 장르 추천</div></ul>
        <div class="sub-title">데이터 소개</div>
        <ul>
            <div>🎤 3만 곡의 상세정보(템포 등), 장르 O</div>
            <div>🎧 2019년 동안 매일 수집된 여러 곡의 음악 청취수와 해당 곡에 대한 상세정보(템포 등), 장르 X</div>
            <div>☔ 수집된 위치를 위도와 경도로 나타낸 날씨 데이터</div>
            <div>🌐 각 좌표가 어느 국가에 속하는지 구분하기 위한 위한 지리 데이터 (도시의 인구수 포함)</div>
            <div>🎼 장르 선호도 분석을 위한 국가별 TOP 100 음악 태그 (음악 특징을 나타내는 단어)</div>
        </ul>
        <div class="sub-title">프로젝트 전제 조건</div>
        <ul>
            <li>음악 선택시 기분이 중요한 요소로 작용한다는 가정하에 이에 영향을 미칠 수 있는 날씨를 기반으로 음악 장르 추천</li>
            <li>하루 동안의 날씨 변화 패턴이 음악 선호도에 영향을 미칠 것으로 가정함</li>
            <li>날씨와는 별개로 국가별 음악 장르 취향이 다를 것으로 가정함</li>
            
        </ul>
    </td>
</tr>
<tr>
    <td colspan="2" style="padding-bottom: 2rem;">
        <div class="title">프로젝트 진행 순서</div>
        <img style="width: 98%; display: block; margin: 0 auto" src="{{root_url}}/public/img/portfolio/프로젝트 진행 순서.png" />
    </td>
</tr>
<tr>
    <td colspan="2">
        <div class="title">데이터 처리/분석</div>
        <div class="sub-title">날씨 데이터 전처리</div>
        <img style="display: block; margin: 2.5rem auto 1.5rem;" src="{{root_url}}/public/img/portfolio/날씨 데이터 전처리.png" />
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
            <div class="desc-sub"><span style="font-size:0.9rem">DBSCAN</span>을 사용하여 거리 기준을 초과하는 도시를 포함한 국가 제외</div>
        </div>
    </td>
</tr>
<tr>
    <td colspan="2" style="border-top: none;">
        <div class="sub-title">국가별 장르 선호도 분석</div>
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
</table>