---
layout: post
title: 모니터 기획서 정리용
date: 2024-03-04 15:13:23 +0900
---

### 우리 프로젝트는 회귀/분류/추천시스템/기타 중?
?
<enter></enter>

### 어떤 문제를 해결?
- **합리적인 가격 책정을 위한 모니터 가격 예측**
  <p class="sub">이 프로젝트의 주 목적은 모니터의 다양한 특성을 기반으로 그 가격을 예측하는 머신러닝 모델을 개발하는 것입니다. 이를 통해, 제품 특성이 가격 결정에 미치는 구체적인 영향을 분석하고, 이해관계자들이 보다 정확하고 합리적인 가격 책정을 할 수 있도록 지원합니다.</p>

### 프로젝트 주제
- 다양한 제품 특성을 기반으로 한 모니터 가격 예측 모델

### 데이터
  - **Serp API - Google Shopping API**
    - [https://app.valueserp.com/playground](https://app.valueserp.com/playground)
    - 이메일 인증 가입 (처음 100회 요청에 대한 무료 체험을 제공, 신용카드 정보가 필요없고 언제든 취소 가능)
    - 한 번 요청할 때 5 페이지까지 가능(5 페이지당 84 ~ 100개)
    - 실제 요청한 제품 데이터 예시<enter><enter/>
    ```shell
    {
        "title": "Onn. 49 inch Curved Dual FHD (3840 x 1080p) 144Hz 1ms Gaming Monitor with Cables, Black, New",
        "id": "6479875462535964703",
        "link": "https://www.google.com/shopping/product/6479875462535964703",
        "rating": 4,
        "reviews": 38,
        "merchant_count": 4,
        "price": 617.63,
        "price_raw": "$617.63",
        "price_parsed": {
          "symbol": "$",
          "value": 617.63,
          "currency": "USD",
          "raw": "$617.63"
        },
        "merchant": "Tech Royale",
        "snippet": "It's got a widescreen, bezel-less display for more realistic immersion and visual comfort. It comes with a slender, adjustable ...",
        "extensions": [
          "Curved",
          "1080p",
          "LED",
          "HDMI",
          "DisplayPort"
        ],
        "delivery": "Free delivery by Fri, Mar 8",
        "has_compare_prices": true,
        "image": "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTOhSj9Xj7vHz0wMixAip2J_IOY3gFDRERT2gUlAD2yRo4D3M-1GVQvi8pkb5r8BVBKInNCSavujUzm1Y-L050Ys70AeuoCI67AaM1UJi3f44WEwa-NEcdQ&usqp=CAE",
        "position": 41,
        "has_product_page": true
    },
    ```
<br />

  - **Real-Time Product Search**
    - [https://rapidapi.com/letscrape-6bRBa3QguO5/api/real-time-product-search/pricing](https://rapidapi.com/letscrape-6bRBa3QguO5/api/real-time-product-search/pricing)
    - 페이지 당 29개
    - 스펙과 리뷰는 제품 하나씩 따로 요청이 필요
    - 기본 100번 Hard Limit
    - 페이지 당 가져오는 제품 데이터 예시 <enter><enter/>
    ```shell
    {
        store_name:"Tanga.com"
        store_rating:4.6
        offer_page_url:"https://www.tanga.com/deals/44dd09324f9f/tracfone-nokia-2760-flip-4gb-black-prepaid-feature-phone?srsltid=AfmBOoqGArxPGYAfImB_xpNseKSuHmOp5P5NQJt1AO0FwwCO7v3vpUt1kpo"
        store_review_count:9437
        store_reviews_page_url:"https://www.google.com/shopping/ratings/account/metrics?q=tanga.com&c=US&v=19&hl=en"
        price:"$21.49"
        shipping:"Free delivery"
        tax:"+$1.85 est. tax"
        on_sale:false
        original_price:null
        product_condition:"NEW"
        top_quality_store:false
      }
    ```
<br />

  - **Amazon Product Data**<enter></enter>
    - [https://rapidapi.com/opus-serve-opus-serve-default/api/amazon-product-data6/pricing](https://rapidapi.com/opus-serve-opus-serve-default/api/amazon-product-data6/pricing)
    - 페이지 당 15개? 추가 요금 가능성 있음 기본 20번
    - 스펙과 리뷰는 제품 하나씩 따로 요청이 필요 
    - 페이지 당 가져오는 제품 데이터 예시 <enter><enter/>
    ```shell
    {
        title:"Apple iPhone 12, 128GB, Black - Fully Unlocked (Renewed)"
        image:"https://m.media-amazon.com/images/I/41bIlvE1rdL._AC_UY218_.jpg"
        url:"https://www.amazon.com/dp/B08PNCYYVZ"
        asin:"B08PNCYYVZ"
        star_rating:"4.2"
        global_ratings:"12,359"
        bought_in_past_month:"2K+"
        price_symbol:"$"
        price:"357.00"
        is_prime:true
        is_climate_pledge_friendly:false
        is_best_seller:false
        is_sponsored:false
        is_limited_time_deal:false
    }
    ```

### 입력과 출력
- 입력 데이터 : 평점, 리뷰 수, Curved 여부, 해상도, 디스플레이 종류, 포트 종류 등

- 출력 데이터 : 가격

### 프로젝트 기획서
?