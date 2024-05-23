<!-- 사용자 정의 태그 소괄호는 js/custom/latex.js 에 정의 -->
$(document).ready(function () {
    $('p').each(function() {
        // @@ <desc></desc>
        if ($(this).text().startsWith('@@')) { // copy
            const id = /^@@ /
            const btn = '<div><span class="copy-button"><i class="fa-regular fa-copy"></i> Copy</span></div>'
            const span = `${btn}<span class="copy-text">${$(this).html().replace(id, '')}</span>`
            const html = $('<copy></copy>').html(span)
            $(this).replaceWith(html)
        }
        if ($(this).text().startsWith('++')) { // Tip!
            const id = /^\++ /
            const span = `<span>${$(this).html().replace(id, '')}</span>`
            const html = $('<tip></tip>').html(span)
            $(this).replaceWith(html)
        }
    })
    
    $('copy .copy-button').on('click', function() {
        const index = $('copy .copy-button').index(this)
        const text = $('copy .copy-text').eq(index).text()

        navigator.clipboard.writeText(text).then(function() {
            $('copy .copy-button').eq(index).html('<i class="fa-regular fa-copy"></i> Copied');
        }).catch(function(err) {
            console.error('텍스트 복사에 실패했습니다: ', err);
        });
    })
})