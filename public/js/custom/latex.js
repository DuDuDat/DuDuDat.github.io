function selectDollar(text, condition) {
    const tempText = text.replace(/\$\$/g, '__DD__');

    let doubleIndex = condition === 'first'? tempText.indexOf('__DD__') : tempText.lastIndexOf('__DD__');
    let singleIndex = condition === 'first'? tempText.indexOf('$') : tempText.lastIndexOf('$');
    condition = condition === 'first'? doubleIndex > singleIndex : doubleIndex < singleIndex

    if (doubleIndex === -1 && singleIndex === -1) {
        return null
    } else if (condition) {
        return '$$'
    } else {
        return '$'
    }
}

function checkDollar(text, dollar) {
    let regex = /(\$)/g
    if (dollar === '$$') {
        regex = /(\$\$)/g
    }
    const matches = text.match(regex)
    const count = matches ? matches.length : 0
    return count % 2 !== 0
}

window.MathJax = {
    startup: {
        ready: () => {
            MathJax.startup.defaultReady();
            // 사용자 정의 태그 소괄호
            $('.post-content').each(function() {
                const htmlContent = $(this).html();
                const updatedText = htmlContent.replace(/(\(([^)]+)\))/g, function(match, p1, p2, offset, string) {
                    const leftHtml = string.slice(0, offset);
                    const rightHtml = string.slice(offset + match.length);

                    const leftDollar = selectDollar(leftHtml, 'first');
                    const rightDollar = selectDollar(rightHtml, 'last');

                    if (leftDollar === rightDollar && leftDollar !== null) {
                        if (checkDollar(leftHtml, leftDollar) && checkDollar(rightHtml, rightDollar)) {
                            return match
                        }
                    }

                    if (!leftHtml.match(/<mo|<mi|<msub|<msup|<mrow|<mfrac|<math/)) {
                        return `(<parentheses>${p2}</parentheses>)`;
                    }
                    return match
                });
                $(this).html(updatedText);
            });
        }
    },
    tex: {
        inlineMath: [['$', '$'], ['\\(', '\\)']],
        displayMath: [['$$', '$$'], ['\\[', '\\]']],
        tags: 'ams',
        tagSide: 'left'
    },
    svg: {
        fontCache: 'global'
    }
};