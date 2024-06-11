/*----------------- Component 단일 객체 -----------------*/
const _component = {
    category: _category,
    page: _page
}

function _category(doc) {
    let image = `<div class="${doc.label} post-image">${doc.icon}</div>`
    if (doc.image) {
        image = `<img class="post-image" src="${doc.image}"  alt=""/>`
    }

    const $post = $('<div>').addClass('post').html(`
        ${image}
        <div class="post-label">${doc.label}</div>
        <div class="post-info">
            <div class="post-title">${doc.title}</div>
            <div class="post-content">${doc.content}</div>
            <div class="post-date">${doc.date}</div>
        </div>
    `).data('url', doc.url)
    $post.on('click', function() {
        window.location.href = $(this).data('url')
    })
    return $('<div>').addClass('col-sm-12 col-md-6 col-lg-4').append($post)
}
function _page(page) {
    const $span = $('<span>').addClass(`page ${page===_options.currentPage?'active':''}`).text(page)
    $span.on('click', function() {
        window.location.href = `/posts/#${_options.category}^${page}${_options.query?`?${_options.query}`:''}`
    })
    return $span
}

/*----------------- Component 결과 -----------------*/
const _result = {
    category: _resultCategory,
    page: _resultPage
}

function _resultCategory() {
    let jsonData = _options.jsonData
    if (!_options.limit) {
        return jsonData.map(doc =>  _component.category(doc))
    }
    if (jsonData.length >= _options.limit*_options.currentPage) {
        jsonData = jsonData.slice((_options.limit) * (_options.currentPage - 1), _options.limit * _options.currentPage)
    }else {
        jsonData = jsonData.slice((_options.limit) * (_options.currentPage - 1))
    }
    return jsonData.map(doc =>  _component.category(doc))
}
function _resultPage() {
    const totalPage = Math.ceil(_options.jsonData.length / _options.limit)
    return Array.from({ length: totalPage }, (_, i) => _component.page(i+1));
}

const _options = {
    jsonData: null,
    category: null,
    limit: null,
    currentPage: null,
    query: null
}

window.Component = function(options) {
    _options.jsonData = options.jsonData
    _options.category = options.category
    _options.limit = options.limit
    _options.currentPage = parseInt(options.currentPage, 10)
    _options.query = options.query
    
    return _result
}