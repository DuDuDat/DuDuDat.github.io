<!-- 우측 게시글 nav -->
$(document).ready(function () {
    $('h3, h4, h5').each(function (index) {
        let headerId = `header-${index}`
        $(this).attr('id', 'header-' + index);

        let indentCount = this.tagName.replace('H', '') - 2
        let navItem = $('<div></div>').addClass('post-nav-item').addClass(`post-nav-item-${indentCount}`).html($(this).text()).attr('title', $(this).text())

        navItem.on('click', function(e) {
            $('html, body').animate({
                scrollTop: $(`#${headerId}`).offset().top - $('.fixed-header').outerHeight()
            }, 150)
        })
        $('.post-side-fixed').css('display', 'block')
        $('.post-nav').append(navItem)
    });
});