const _result = {
    default: _default,
    category: _category
}

function _default() {
    $('.header-home header-button, aside .profile-desc').on('click', function() {
        location.href = '/'
    })
    $('.all-documents').on('click', function() { // Total
        location.href = '/posts/#total^1'
    })
    $('.directory').on('click', function() {
        const category = this.classList[1]
        if (this.classList[2]) {
            location.href = `/posts/#${category}^1`
        } else {
            $(`.sub-directory.${category}`).toggleClass('d-none')
            $(`.category-drop-down.${category}`).toggleClass('d-none')
            $(`.category-drop-up.${category}`).toggleClass('d-none')
        }
    })
    $('.sub-directory, .drop-sub-directory').on('click', function() {
        const dir = this.classList[2]
        window.location.href = `/posts/#${dir}^1`
        $('.drop-menu').addClass('d-none')
    })
    $('input.header-btn').on('click', function() {
        $(`.drop-menu:not( ._${this.value})`).addClass('d-none')
        $(`.drop-menu._${this.value}`).toggleClass('d-none')
    })
    $(document).on('click', function(e) {
        if (!$(e.target).hasClass('header-btn')) {
            $('.drop-menu').addClass('d-none')
        }
        if (!$(e.target).closest('.menu-btn').length > 0) {
            $('menu').addClass('d-none')
        }
    })
    $(window).on('resize', function() {
        $('.drop-menu').addClass('d-none')
        $('menu').addClass('d-none')
    })
    $('.menu-btn').on('click', function() {
        $('menu').toggleClass('d-none')
    })
    $('.menu-directory').on('click', function() {
        const dir = this.classList[1]
        window.location.href = `/posts/#${dir}^1`
        $('menu').addClass('d-none')
    })
}
function _category() {
    $(`.selected`).removeClass('selected')
    $(`.sub-directory`).addClass('d-none')
    $(`.category-drop-down`).removeClass('d-none')
    $(`.category-drop-up`).addClass('d-none')

    if (_options.category !== 'total') {
        $('.directory-name').text(_options.category)

        const selected = $(`.sub-directory.${_options.category}`)
        if (selected.length > 0) {
            selected.addClass('selected')
            const category = selected.get(0).classList[1]
            $(`.sub-directory.${category}`).removeClass('d-none')
            $(`.category-drop-down.${category}`).addClass('d-none')
            $(`.category-drop-up.${category}`).removeClass('d-none')
        }else {
            $(`.directory.${_options.category}`).addClass('selected')
        }
    } else {
        $('.directory-name').text('분류 전체 보기')
    }
}

const _options = {
    category: null
}


window.MyEvent = function(options) {
    _options.category = options.category
    return _result
}