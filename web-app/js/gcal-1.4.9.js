/*
 * FullCalendar v1.4.9 Google Calendar Extension
 *
 * Copyright (c) 2010 Adam Shaw
 * Dual licensed under the MIT and GPL licenses, located in
 * MIT-LICENSE.txt and GPL-LICENSE.txt respectively.
 *
 * Date: Fri Nov 19 22:45:44 2010 -0800
 *
 */

function plannerCalSuccess(data) {
	gPlannerEntries = [];
	var dates = [];
	sucess(data, gPlannerEntries, dates,  'div.planner-detail-content.entry-list');
}

function plannerDetailSuccess(data) {
	gPlannerDetailEntries = [];
	gPlannerDetailDates = [];
	sucess(data, gPlannerDetailEntries, gPlannerDetailDates,  undefined);
}

function errorFn(jqXHR, textStatus, errorThrown) {
	if(jqXHR.status == 403)
		 document.location.href = '/helper/login';
}
 (function($) {

	$.fullCalendar.plannerCalFeed = function(feedUrl, options) {
		
		var to = feedUrl.indexOf('/', 1);
		var ctrl = feedUrl.substring(0, to);
		return function(start, end, callback) {
			var params = {
				'start-min': $.fullCalendar.formatDate(start, 'u'),
				'start-max': $.fullCalendar.formatDate(end, 'u'),
				'get-offices' : officesFlag,
				'get-entries-offices': true,
				'max-results': 9999
			};
			$('div.planner-detail-content.entry-list').html('');
			$.ajaxSetup( { "async": false , 'error': errorFn} ); 		    
			$.getJSON(feedUrl, params, plannerCalSuccess); 
			$.ajaxSetup( { "async": true } ); 	
			officesFlag = false;
			callback(toNonAssoArr(gPlannerEntries));				
		}		
	}

	$.fullCalendar.detailFeed = function(feedUrl, options) { //detail
		
		var to = feedUrl.indexOf('/', 1);
		var ctrl = feedUrl.substring(0, to);
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
				'get-entries-offices' : entriesOfficesFlag,
				'max-results': 9999
			}; 			
			//$('#planner-detail-content').html('');
			$.ajaxSetup( { "async": false, 'error': errorFn } ); 		    
			$.getJSON(feedUrl, params, plannerDetailSuccess); 
			$.ajaxSetup( { "async": true } ); 
			var events = toNonAssoArr(gPlannerDetailEntries);
			events = sortArray(events);
			$('#pdtl-calendar').data('itdaEvents', events);
			$('#pdtl-calendar').data('itdaDates', gPlannerDetailDates);
			callback([]);				
		}		
	};	
	

	
})(jQuery);




