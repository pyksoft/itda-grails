var trackerCalVisStart, trackerCalVisEnd;
function trackerCalSuccess(data) {
	gCompetitorAdEntries = [];
	var dates = [];
	sucess(data, gCompetitorAdEntries, dates,  'div.tracker-detail-content.entry-list');
}

function trackerDetailSuccess(data) {
	gCompetitorAdDetailEntries = [];
	gCompetitorAdDetailDates = [];
	sucess(data, gCompetitorAdDetailEntries, gCompetitorAdDetailDates,  undefined);
}

(function($) {

	$.fullCalendar.trackerCalFeed = function(feedUrl, options) {
		
		return function(start, end, callback) {
			var params = {
				'start-min': $.fullCalendar.formatDate(start, 'u'),
				'start-max': $.fullCalendar.formatDate(end, 'u'),
				'max-results': 9999
			};
			$('div.tracker-detail-content.entry-list').html('');			
			params['get-entries-offices'] = true;
			params['get-offices'] = true;
			$.ajaxSetup( { "async": false } ); 		    
			$.getJSON(feedUrl, params, trackerCalSuccess);
			$.ajaxSetup( { "async": true } ); 	
			callback(toNonAssoArr(gCompetitorAdEntries));				
		}		
	}
	
	$.fullCalendar.detailFeed = function(feedUrl, options) { //detail
		
		//var to = feedUrl.indexOf('/', 1);
		//var ctrl = feedUrl.substring(0, to);
		return function(start, end, callback) {

			calVisStart = new Date(start)
			calVisEnd = new Date(end);
			if(calVisStart.getDate() != 1) {
				if(calVisStart.getMonth() == 11)
					calVisStart = new Date(calVisStart.getFullYear()+1, 0, 1);
				else
					calVisStart = new Date(calVisStart.getFullYear(), calVisStart.getMonth()+1, 1);
				calVisEnd.setDate(1);
			}
			var params = {
				'start-min': $.fullCalendar.formatDate(calVisStart, 'u'),
				'start-max': $.fullCalendar.formatDate(calVisEnd, 'u'),
				'get-offices' : true ,
				'get-entries-offices' : entriesOfficesFlag,
				'max-results': 9999
			}; 			
			$.ajaxSetup( { "async": false } ); 		    
			$.getJSON(feedUrl, params, trackerDetailSuccess); 
			$.ajaxSetup( { "async": true } ); 	
			var events = toNonAssoArr(gCompetitorAdDetailEntries);
			events = sortArray(events);
			$('#pdtl-calendar').data('itdaEvents', events);
			$('#pdtl-calendar').data('itdaDates', gCompetitorAdDetailDates);		
			callback([]);
		}		
	};	
	
})(jQuery);
