function escapeQuotesInHTMLTags(jsonString) { // HTML 태그 내의 큰따옴표를 이스케이프 처리
    return jsonString.replace(/<[^>]*>/g, function(match) {
        return match.replace(/"/g, '\\"');
    });
}

function jsonParsing(id) {
    let jsonString = $(`#${id}`).text()
    jsonString = escapeQuotesInHTMLTags(jsonString);
    jsonString = JSON.parse(jsonString)
    return jsonString
}