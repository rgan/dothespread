function getTaggedVideos(query, start, max_results)
    $.ajax({
        url: "https://gdata.youtube.com/feeds/api/videos?q=" + query + "&start-index=" + start + "&max-results=" + max_results + "&v=2&alt=jsonc",
        dataType: 'jsonp',
        success: function(data) {
            var videos = [];
            var entries = data.data.items || [];
            entries.forEach(function(item) {
               videos.add{"author" : item.author[0].name.$t, "title" : item.title.$t, "id" : id}
            };
        }
    })
;
