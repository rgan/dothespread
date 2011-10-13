// SimpleTube v1.0.0 - a very lightweight youtube displaying extension - based on jQuery 1.3+
// http://hereswhatidid.com/simpletube/
// Copyright (c) 2010 Gabe Shackle - gabe@hereswhatidid.com
// Licensed under the MIT license: http://www.opensource.org/licenses/mit-license.php
(function($) {
	$.fn.simpletube = function(options) {
		options = $.extend({
			'feedid': 'LieNielsen', // feed url, only required parameters
			'maxresults': 10, // number of results to show, 0 for no limit
			'defaultvideo': 'none', // default video to display initially, uses the YouTube video id parameter
			'displaytype': 'single', // playlist, single, user
			'activeclass': 'active', // css class applied to the thumbnail div when it is the current video playing
			'videowidth': 450, // width of the displayed video
			'videoheight': 356, // height of the displayed video
			'showthumbnails': true, // show or hide thumbnails
			'showdescription': false, // show or hide video description
			'related': false, // show or hide related videos
			'thumbpos':'after' // arrange the thumbnails before or after video
		}, options);
		return this.each(function() {
			var _objVideoNode = $(this).html('<div class="videoholder"><div class="videooutput"></div></div>');
			var strFeed = 'http://gdata.youtube.com/feeds/api/users/LieNielsen/uploads?v=2&alt=jsonc';
			$(this).data('maxresults',options['maxresults']);
			$(this).data('defaultvideo',options['defaultvideo']);
			$(this).data('displaytype',options['displaytype']);
			$(this).data('related',options['related']);
			switch(options['displaytype']) {
				case 'playlist':
					strFeed = 'http://gdata.youtube.com/feeds/api/playlists/'+options['feedid']+'?v=2&alt=jsonc';
					break;
				case 'single':
					strFeed = 'http://gdata.youtube.com/feeds/api/videos/'+options['feedid']+'?v=2&alt=jsonc';
					break;
				case 'user':
					strFeed = 'http://gdata.youtube.com/feeds/api/users/'+options['feedid']+'/uploads?v=2&alt=jsonc'
					break;
			}
			strFeed = ($(this).data('related')) ? strFeed + '&rel=1' : strFeed + '&rel=0';
			$(this).data('videowidth',options['videowidth']);
			$(this).data('videoheight',options['videoheight']);
			$(this).data('activeclass',options['activeclass']);
			$(this).data('showthumbnails',options['showthumbnails']);
			$(this).data('showdescription',options['showdescription']);
			$(this).data('thumbpos',options['thumbpos']);
			$.ajax({
				url: strFeed,
				dataType: 'jsonp',
				success: function(data) {
					if ((options['displaytype'] === 'playlist') || (options['displaytype'] === 'user')) {
						var entries = data.data.items || [];
						var intDefault = 0;
						if (options['showthumbnails']) {
							if (options['thumbpos'] === 'before') {
								_objVideoNode.prepend('<div class="videothumbnails"></div>');
							} else {
								_objVideoNode.append('<div class="videothumbnails"></div>');
							}
							var _objThumbsHolder = _objVideoNode.find('.videothumbnails');
							if ((options['maxresults'] !== 0) && (options['maxresults'] <= entries.length)) {
								var intResultsLength = options['maxresults'];
							} else {
								var intResultsLength = entries.length;
							}
							for (var i=0; i<intResultsLength; i++) {
								if (options['displaytype'] === 'user') {
									_objThumbsHolder.append('<div><img src="' + entries[i].thumbnail.sqDefault + '" class="' + entries[i].id + '" /><br /><span class="thumbdescription">'+entries[i].title+'</span></div>');
									if (options['defaultvideo'] === entries[i].id) {
										intDefault = i;
									}
								} else {
									_objThumbsHolder.append('<div><img src="' + entries[i].video.thumbnail.sqDefault + '" class="' + entries[i].video.id + '" /><br /><span class="thumbdescription">'+entries[i].video.title+'</span></div>');
									if (options['defaultvideo'] === entries[i].video.id) {
										intDefault = i;
									}
								}
							}
							_objThumbsHolder.find('div').click(function() {
								_objThumbsHolder.find('div').removeClass(options['activeclass']);
								_loadYouTubeVid($(this).addClass(options['activeclass']).find('img').attr('class'), options, _objVideoNode);
							});
							_objThumbsHolder.find('div:first').addClass(options['activeclass']);
						} else {
							_objVideoNode.addClass('nothumbs');
						}
						if (options['displaytype'] === 'user') {
							_loadYouTubeVid(entries[intDefault].id, options, _objVideoNode);
						} else {
							_loadYouTubeVid(entries[intDefault].video.id, options, _objVideoNode);
						}
					} else {
						_objVideoNode.addClass('nothumbs');
						_loadYouTubeVid(data.data.id, options, _objVideoNode);
					}
				}
			});
		});
	}
	function _loadYouTubeVid(strID, options, _objVideoNode) {
		_objVideoNode.find('.videooutput').flash().remove();
		strSWFURL = 'http://www.youtube.com/v/' + strID + '?enablejsapi=1&playerapiid=ytplayer'
		strSWFURL = (options['related']) ? strSWFURL + '&rel=1' : strSWFURL + '&rel=0';
		_objVideoNode.find('.videooutput').flash({
			swf: strSWFURL,
			width: options['videowidth'],
			height: options['videoheight']
		});
	}
})(jQuery);