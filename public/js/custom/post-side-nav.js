const fixedHeaderHeight = $('header').height() // 상단 고정 헤더
let lastScrollY = 0; // 현재 위치
let isDown = false; // 스크롤 방향
let initObserver =  true // observer 첫 실행 여부
const indexInfo = [] // {'mainIndex': h1 인덱스, 'subIndex': h2 인덱스, 'referenceHeight': checkpoint 위치}
let interval // index 선택 class 딜레이
let click = false // click 했을 땐 딜레이 더 길게

$(window).on('scroll', function() {
    let currentScrollY = window.scrollY;
    isDown = currentScrollY > lastScrollY;
    lastScrollY = currentScrollY;
})

/* ------------------ navItem 생성 ------------------ */
function makeNavItem(obj, mainIndex, subIndex) { // obj: this 객체, index: main 또는 sub 인덱스
    const navItem = $(`<index class="main-${mainIndex} ${!isNaN(subIndex)? 'sub' : ''}"></index>`)
        .html($(obj).text())
        .attr('title', $(obj).text())
        .on('click', function() {
            click = true
            $('html, body').animate({
                scrollTop: $(`#${obj.id}`).offset().top - fixedHeaderHeight
            }, 10)
            setTimeout(() => {
                click = false
            }, 500)
        })

    $('navItem').append(navItem)

    const checkPoint = $(`<check></check>`)
    const nextObj = $(obj).nextAll('h1, h2').first(); // 다음 h1 또는 h2 구간 찾기
    let nextPos = nextObj.length > 0? nextObj.before(checkPoint).offset().top - fixedHeaderHeight : $(document).height()

    if (nextObj.length === 0) {
        $('.post-content').append(checkPoint)
    }

    indexInfo.push({
        'referenceHeight': nextPos,
        'mainIndex': mainIndex,
        'subIndex': subIndex
    })
    viewObserver.observe(checkPoint.get(0));
}

/* ------------------ debounce 설정 ------------------ */
function debounce(elements) {
    const orderedElement = isDown? elements : elements.slice().reverse()
    orderedElement.forEach(el => {
        const target = $(el.target)
        if (isDown? !el.isIntersecting:el.isIntersecting) {
            if (interval) {
                clearInterval(interval)
            }
            interval = setInterval(() => {
                if (!click) {
                    let index = $('check').index(target)
                    index = isDown? index+1:index
                    $('index').removeClass('active')
                    if (index < $('index').length) {
                        $('index').get(index).classList.add('active')
                        toggleSubIndices()
                    }
                    clearInterval(interval)
                }
            }, 50);
        }
    })
}

/* ------------------ 요소 관찰을 위한 옵션 설정 ------------------ */
const viewObserver = new IntersectionObserver((elements) => {
    if (initObserver) { // 현재 위치 초기설정
        initObserver = false
        for (let i=0; i<indexInfo.length; i++) {
            if (lastScrollY < indexInfo[i]['referenceHeight']) {
                $('index').get(i).classList.add('active')
                break
            }
        }
        toggleSubIndices()
        return
    }

    debounce(elements)
}, {
    root: null, // 뷰포트를 기본값으로 설정
    rootMargin: `-${fixedHeaderHeight}px 0px 0px 0px`,
    threshold: 0.5
})

/* ------------------ subIndex 토글 ------------------ */
function toggleSubIndices() {
    const target = $('.active')
    const validateClass = target.get(0).classList[0]
    $('index.sub').addClass('d-none')
    $(`index.${validateClass}.sub`).removeClass('d-none')
}

/* ------------------ 초기 설정 ------------------ */
$(document).ready(function () {
    const selector = $('h1, h2')
    if(selector.length === 0) {
        $('indexnav').addClass('d-none')
        return
    }

    /* ------------------ 클릭 이벤트 ------------------ */
    $('navicon').on('click', function () {
        $('navicon').addClass('d-none')
        $('navlist').removeClass('d-none')
    })
    $('navlist .fa-xmark').on('click', function () {
        $('navicon').removeClass('d-none')
        $('navlist').addClass('d-none')
    })

    let count = 0
    /* ------------------ 목차용 블럭 생성 ------------------ */
    $('h2').each(function(index) { // h1 이 없는 h2 객체가 있다면
        const prevH1 = $(this).prevAll('h1')
        const nextH = $(this).nextAll('h1, h2')
        index = nextH.length + index

        if(prevH1.length === 0) {
            makeNavItem(this, index)
        }
    })

    $('h1').each(function(mainIndex) {
        $(this).attr('id', `header-${count++}`);
        makeNavItem(this, mainIndex)

        const startIndex = $(this).index()
        const endIndex = $(this).nextAll('h1').first().index();

        let subElements
        if (endIndex > -1)  {
            subElements = $(this).parent().children().slice(startIndex+1, endIndex);
        }else {
            subElements = $(this).parent().children().slice(startIndex+1);
        }

        let h2Elements = subElements.filter('h2')
        h2Elements.each(function(subIndex) {
            $(this).attr('id', `header-${count++}`);
            makeNavItem(this, mainIndex, subIndex)
        })
    })

    $('check').each(function(index) {
        const prev = $(this).prevAll('h1, h2').first(); // 이전 h1 또는 h2 구간 찾기
        if (prev.length === 0 ||prev.is('h1')) {
            $(this).addClass('first')
        }
        const next = $(this).nextAll('h1, h2').first()
        if (next.length > 0) {
            if (next.get(0).tagName.includes(1)) {
                $(this).addClass('main')
            }else {
                $(this).addClass('sub')
            }
        }
    })
});