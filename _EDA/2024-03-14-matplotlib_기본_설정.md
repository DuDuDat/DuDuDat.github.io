---
layout: post
title: matplotlib 기본 설정 
date: 2024-03-14 19:37:23 +0900
---
### matplotlib 한글 미지원
- matplotlib 의 기본 폰트가 한글을 지원하지 않기 때문에 한글이 지원되는 폰트로 변경할 필요가 있음
    ```python
    # 내 컴퓨터에서 한글이 지원되는 폰트 이름 확인 (Windows)
    from matplotlib import font_manager
    f_path = 'C:\Windows\Fonts\malgun.ttf' 
    font_manager.FontProperties(fname=f_path).get_name()
  
    # 폰트 이름을 알아낸 후 설정
    from matplotlib import rc # 폰트 이름알면 위 코드 실행 필요 X
    rc('font', family='Malgun Gothic')
    ```