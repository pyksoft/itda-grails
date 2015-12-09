var gUploadId, gToken, gdiaglog, gdiaglogSmall, gdialogSendVendor; 
var selectedDate, accordionContent, accordionHeader, selectedPlannerEntry, calVisStart, calVisEnd,
sizeAccordionHtml,sizeHeaderHtml,quantityAccordionHtml,quantityHeaderHtml,zipcodesAccordionHtml,zipcodesHeaderHtml,
colorAccordionHtml,colorHeaderHtml;  
var officesFlag=true, entriesOfficesFlag=true, deadlineDate=null;
var offices= [], vendors = [], publications = [], competitors = [], eventSelectBox, currMonthEvents = [], todos = [],zipcodes=[];
var gPlannerEntries = [], gPlannerDetailEntries, gPlannerDates=[], gPlannerNewEntries=[], gSelectedId;
var gCompetitorAdEntries, gCompetitorAdDetailEntries, gCompetitorAdDetailDates, gCompetitorAdNewEntries, gToday, gBusiness, gSelectFileDiagOpened;

function isEmpty(map) {
   for (var attr in map)
	   return false;
   return true;
}

function formatDollarAmount(amount){
	amount = (''+amount).replace(/[^0-9\.]/g, '');
	return '$' + $.formatNumber(amount, {format:'#,##0.00', decimalChar: '.', thousandsChar :','});
}
function formatInteger(val){
	return $.formatNumber(val, {format:'###0', thousandsChar :''});
}
function formatPercent(val){
	return $.formatNumber(val, {format:'###0.0', decimalChar: '.', thousandsChar :''})+'%';
}
function disableEventPropagation(event) {
	if(!event) return;
	if (event.stopPropagation)
		event.stopPropagation();
	else if (window.event)
		window.event.cancelBubble = true;
}
function toNonAssoArr(assoArr){
	var arr = [];
	for(var key in assoArr) {
		arr.push(assoArr[key]);
	}
	return arr;
}
function findById(id, arr){
  for(var i=0; i<arr.length; i++)
	  if(id == arr[i].id)
		  return arr[i];
  return null;
}
function addToArr(entry, arr){
	if(!arr)
		arr = [];
	arr.push(entry);
	return arr;
}

function sortArray(assoArr){
	return assoArr.sort(function(a, b){
		if (a.start > b.start) return 1;
		else if (a.start < b.start) return -1;
		else {
			if (a.title.toLowerCase() > b.title.toLowerCase()) return 1;
			else if (a.title.toLowerCase() < b.title.toLowerCase()) return -1;			
			return 0
		}
	});		
}

function getVendorDisplayTitle(eventType, diff){
	  if (diff && eventType == 'news-planner-event' )
		  return 'Newspaper';
	  else 
		  return 'Vendor';	
}
function getVendorFieldName(eventType, diff){
	  if (eventType == 'news-planner-event' )
		  return 'publication.id';
	  else 
		  return 'vendor.id';	
}
function getSizeText(key, otherSize) {
	if(key == undefined || key == null)
		return '';
	key = key.replace('-', '_')
    if(key=="FP") return 'Full Page';
    if(key=="3_4V") return '3/4 Page Vertical';
    if(key=="2_3V") return '2/3 Page Vertical';
    if(key=="2_3H") return '2/3 Page Horizontal';
    if(key=="1_2V") return '1/2 Page Vertical';
    if(key=="1_2H") return '1/2 Page Horizontal';
    if(key=="1_3V") return '1/3 Page Vertical';
    if(key=="1_3H") return '1/3 Page Horizontal';
    if(key=="1_4H") return '1/4 Page Horizontal';
    if(key=="1_4V") return '1/4 Page Vertical';
    if(key=="1_5V") return '1/5 Page Vertical';
    if(key=="1_5H") return '1/5 Page Horizontal';
    if(key=="1_6V") return '1/6 Page Vertical';
    if(key=="1_6H") return '1/6 Page Horizontal';
    if(key=="1_8V") return '1/8 Page Vertical';
    if(key=="1_8H") return '1/8 Page Horizontal';
    if(key=="1_62C") return '1/62C';
    if(key=="1_63C") return '1/63C';
    if(key=="SL") return 'Standard Letter';
    if(key=="CL") return 'Check Letter';
    if(key=="CH") return 'Check';
    if(key=="IM") return 'Invitation Mailer';
    if(key=="SM") return 'Self Mailer';
    if(key=="PC") return 'Postcard';
    if(key=="OTHER" && otherSize) return otherSize;//planner Only
    return 'Other';
}

function getSizeTitle(eventType){
	if(eventType.indexOf('news')==0)
		return 'Size';
	else 
		return 'Type';
}

function getSmallIcon(eventType) {
	return '/images/Transparent.gif';
}

function getEventTypeTitle(eventType) {
		  if (eventType == 'news-planner-event' )
			  return 'Newspaper Ad #';
		  else if (eventType == 'directmail-planner-event' )
			  return 'Direct Mail #';
		  else if (eventType == 'media-planner-event' )
			  return 'Media Ad #';
		  else if (eventType == 'event-planner-event' )
			  return 'Event #';
		  else if (eventType == 'miscellaneous-planner-event' )
			  return 'Miscellaneous #';
}	
function getRequestParams(url){
	var inParams, results = [];
	if(url){
		inParams = url.split('?')[1];
		if(inParams){
			inParams = inParams.split('&');
			for(i=0; i<inParams.length; i++) {
					var param = inParams[i].split('=');
					results[param[0]] = param[1];
			}
		}
	}
	return results;
}

function getEventType(eventType) {
	  if (eventType == 'news-planner-event' || eventType == 'NP')
		  return 'Newspaper';
	  else if (eventType == 'directmail-planner-event'  || eventType == 'DM')
		  return 'Direct Mail';
	  else if (eventType == 'media-planner-event' || eventType == 'ME')
		  return 'Media';
	  else if (eventType == 'event-planner-event'  || eventType == 'EV')
		  return 'Event';
	  else if (eventType == 'miscellaneous-planner-event'  || eventType == 'MI')
		  return 'Miscellaneous';
}

function getEventClass(eventType) {
	  if (eventType == 'NP')
		  return 'news-planner-event';
	  else if (eventType == 'DM')
		  return 'directmail-planner-event';
	  else if (eventType == 'ME')
		  return 'media-planner-event';
	  else if (eventType == 'EV')
		  return 'event-planner-event';
	  else if (eventType == 'MI')
		  return 'miscellaneous-planner-event';
}

function getEventTypeName(eventType) {
	  if (eventType == 'news-planner-event' )
		  return 'Newspaper Ad';
	  else if (eventType == 'directmail-planner-event' )
		  return 'Direct Mail item';
	  else if (eventType == 'media-planner-event' )
		  return 'Media Marketing';
	  else if (eventType == 'event-planner-event' )
		  return 'Event';
	  else if (eventType == 'miscellaneous-planner-event' )
		  return 'Miscellaneous Marketing';
}

function getEventTypeCode(eventType) {
	  if (eventType == 'news-planner-event' )
		  return 'NP';
	  else if (eventType == 'directmail-planner-event' )
		  return 'DM';
	  else if (eventType == 'media-planner-event' )
		  return 'ME';
	  else if (eventType == 'event-planner-event' )
		  return 'EV';
	  else if (eventType == 'miscellaneous-planner-event' )
		  return 'MI';
}	


function getColorText(key) {
	if(key=="4C" || key=="4") return '4-Color';
	if(key=="2C" || key=="2") return '2-Color';
	if(key=="1C" || key=="1") return '1-Color';
	return '';
}
function getColorNum(key) {
	if(key=="4C" || key=="4") return 4;
	if(key=="2C" || key=="2") return 2;
	if(key=="1C" || key=="1") return 1;
	return null;
}


function getSCHtml(data){
	var html = '';
	if(data.size)
		html += '<b>'+getSizeTitle(data.className)+':</b> '+getSizeText(data.size, data.otherSize);
	if(data.color)
		html += ( html!='' ? '<br/>' : '') + '<b>Color:</b> '+getColorText(data.color);	
	return html;
}
function getSCOVHtml(data){
	var html = getSCHtml(data);
	if(data['office.id']) {
		if(html != '') html += '<br/>';		
		html += '<b>Office:</b> ' + offices['id='+data['office.id']].name;
	}
	if(data['publication.id'] || data['vendor.id']){
		if(html != '') html += '<br/>';
		html += getVendorHtml(data);
	}
	return html;
}
function getVendorHtml(data, twoLine, diff){
	var html ='';
	if(data['publication.id'] || data['vendor.id']){
		html += '<b>'+getVendorDisplayTitle(data.className, diff)+':</b> ';
		if(twoLine)
			html += '<br/>';
		if(data['publication.id'])
			html += publications['id='+data['publication.id']].name;
		else
			html += vendors['id='+data['vendor.id']].name;
	}	
	return html;
}

function invokeDelete(evt, id, itdaEvents, evtContainerName, elementId) {
	disableEventPropagation(evt);	
	var classname = itdaEvents['id='+id].className;
	var evtName = getEventTypeName(classname);
	var from;
	if (classname == 'news-planner-event' || classname == 'directmail-planner-event' )
		if(ctrl === '/myTracker' && itdaEvents['id='+id].deadline === undefined)
			from = 'your Competition Tracker.'
		else	
			from = 'your Planner and Tracker.';
	else
		from = 'this date.';
	var html = '<div style="height:10px"/>'
		+'<h3>Are you sure you want<br/>to delete this item?</h3>This '+evtName+' and its details will be deleted from ' + from
		+'<br/><br/><br/><img src="/images/Transparent.gif" class="planner-icon ok-btn-orange" style="float:right;margin-left:20px" onclick="doDelete('+id +', \''+elementId +'\', '+evtContainerName +');gdiaglogSmall.dialog(\'close\')"></img><img src="/images/Transparent.gif" style="float:right" class="tracker-icon tracker-cancel-gray-btn" onclick="gdiaglogSmall.dialog(\'close\')"></img></div>'
		+'<div style="height:10px"/>';
	showItdaConfirmDialog(html, gdiaglogSmall, 350);
	return false;
}

function doDelete(id, elementId, itdaEvents) {
	var url ;
	if(elementId == 'div.tracker-detail-content.entry-list')
		url = '/myTracker/deleteCompetitorAd4User/'+id;		
	else
		url = '/myTracker/deletePlannerEntry4User/'+id;
		
	$.getJSON(url, {}, function(data) 
			{ 
		     if (data.respText == 'Delete completed.' ) {
		    	 var events;
		    	 var id = url.split('/')[3];
		    	 $('div#'+id+'-planner-detail-title').remove();
		    	 $('div#'+id+'-hr').remove();
		    	 var elem = $('div#'+id+'-planner-detail-info');
		    	 if(elem.siblings().length == 1)
		    		 elem.parent().remove();
		    	 else
		    		 elem.remove();
		    	 if(elementId == '#expense-detail-content'){ //sale/expense
		    	 //if(url.indexOf('Tracker/deletePlannerEntry4User') > 0 ) {
		    		 if(id == gSelectedId){
		    			 resetTab123();
			    	 	gSelectedId = undefined;
		    		 }
		    	 }else{
		    		 var date = itdaEvents['id='+id].start;
		    		 delete itdaEvents['id='+id];
		    		 $('#calendar').fullCalendar( 'removeEvents', id );
		    		 //gPlannerCal.fullCalendar( 'removeEvents', id );
		    		 events = $(gSmlFc).data('itdaEvents');//detail
		    		 if(events) {//only if detail and cal views show the same month
			    		 for(var i=0; i<events.length; i++) {
				    		 if(events[i].id ==  id) {
				    			date = events[i].start;
				    			events.splice(i, 1);
				    			break;
				    		}
			    		 }	
		    			 displayWorkingDate(date, false, events? events: itdaEvents);
		    		 }
	    			var deletedEntryContainer = $(gSmlFc).data('itdaDeletedEvents');
	    			if(!deletedEntryContainer) 
	    				deletedEntryContainer = [];
    				deletedEntryContainer.push(id);
	    			$(gSmlFc).data('itdaDeletedEvents', deletedEntryContainer);		    		 
 		    	 }
		     }
			});
}
function toAssoArray(results) {
	var assoArr = [];
	if (results) {
		for(var i=0; i<results.length; i++)
		{
			results[i].plannerEntries= [];
			results[i].competitorAdEntries= [];
			assoArr['id='+results[i].id] =results[i];
		}
	}
	return assoArr;
}

function gotoDetailView(events){
	if(gSmlFc)
		swapCalView();
	else{
		var sortedEvents = toNonAssoArr(events);
		if(sortedEvents.length == 0){
			initCompAdDetail(undefined, $('#calendar').fullCalendar( 'getDate' ));
			return;
		}
		//sortedEvents = sortArray(sortedEvent);
		initCompAdDetail(events[0].id, events[0].start);
	}	
}

function getDetailView(id, datestr){
	var date = $.fullCalendar.parseDate( datestr );
	initCompAdDetail(id, date);	
}

//Detail page
var gSmlFc;
function initSmallFullCal(ctrl, selectedDate) {
	if(gSmlFc)
		gSmlFc.fullCalendar('destroy');
	gSmlFc = $('#pdtl-calendar').fullCalendar({
		theme: true,
       events: $.fullCalendar.detailFeed(ctrl + '/listJson4User'),
		selectable: true, unselectAuto: false, weekMode: 'variable',
		titleFormat: {month: 'MMMM yyyy' }, columnFormat: { month: 'ddd'/* ,week: 'ddd M/d', day: 'dddd M/d'*/ },
		header: {left: 'prev', center: 'title', right: 'next'},
		aspectRatio: 1.00, height: 150,
		year:selectedDate.getFullYear(), month: selectedDate.getMonth(), date:selectedDate.getDate()
		, select: function( startDate, endDate, allDay, jsEvent, view ) {
			displayWorkingDate(startDate, false, $(gSmlFc).data('itdaEvents'));
		}
		,loading: function( isLoading, view ){
			if(isLoading == true)
			{
				$('div.fc-day-number').removeClass('itda-sm-cal-event');
				$('div.fc-day-number').removeClass('ui-active');
				return;
			}
			var dates = $(this).data( 'itdaDates');
			for(var day in dates) {
					var classname = '#fc-day-' + day;
					$(classname + ' div.fc-day-number').addClass('itda-sm-cal-event');
			}
		}
	});	
	gSmlFc.data("theCalendar", gSmlFc);
}

function initMultiSelectDatePicker (elementId, beforeShowDayFn, onSelectFn, selectedDate) {
	var cal = $(elementId).data("theCalendar");
	if(cal) {
		beforeShowDayFn = cal.data("beforeShowDayFn");
		onSelectFn = cal.data("onSelectFn");
		cal.datepicker('destroy');
	}
	cal = $(elementId).datepicker(
   	        {
   	        		prevText: '',nextText: '',
   	        		itdaVisMonth:-1,
   	        		dateFormat: 'yy/mm/dd',
   	        		defaultDate: $.fullCalendar.formatDate( selectedDate, 'yyyy/MM/dd')
			        ,dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S']

					,onSelect: onSelectFn
   	        		,beforeShowDay: beforeShowDayFn
   	        		,onChangeMonthYear: function(year, month, inst) { 
   	        			var days = Date.getDaysInMonth ( year, month-1 );
   	        			var tmp1 = (new Date(year,month-1, days)).getWeekOfYear();
   	        			var tmp2 = (new Date(year,month-1, 1)).getWeekOfYear();
   	        			tmp2 = (tmp2 > 50) ? 0 : tmp2 ;
   	        			var numRow = 1 + tmp1 - tmp2;
   	        						
   	        			if(numRow == 6)
   	        				$('div#tracker-detail-expense div#content-summary').attr('class','').addClass('height-467');
   	        			if(numRow == 5)
   	        				$('div#tracker-detail-expense div#content-summary').attr('class','');
   	        			if(numRow == 4)
   	        				$('div#tracker-detail-expense div#content-summary').attr('class','').addClass('height-493');
   	        		}
   	        		, gotoCurrent: true 
	        }
   	 	).data('id', elementId)
   	 	 .data('month', -1);
	cal.data("theCalendar", cal);
	cal.data("beforeShowDayFn", beforeShowDayFn);
	cal.data("onSelectFn", onSelectFn);
	var numRow = $('#expense-calendar.sm-event-cal div.ui-datepicker-inline table.ui-datepicker-calendar tbody tr').length;
	if(numRow == 6)
		$('div#tracker-detail-expense div#content-summary').attr('class','').addClass('height-467');
	else if(numRow == 4)
		$('div#tracker-detail-expense div#content-summary').attr('class','').addClass('height-493');
	return cal;
}

function isExpenseDateSelected(date) {
	return isDateSelected(this, date, 'expense');
}
function expenseCalSelectDateFn(dateStr, inst) {
	var position = $('#expense-detail-content div#' + dateStr.replace(/[\/]/g,'')).position();
	if(position != null) {
		var parent = $('#expense-detail-content').parent();
			parent.scrollTop(parent.scrollTop() + position.top);
	}
}

function isDateSelected(cal, date, type) {
	if(	$('#'+cal.id).data('datepicker').drawMonth != 
		$('#'+cal.id).data('datepicker').settings['itdaVisMonth']) {
		var month = $('#'+cal.id).data('datepicker').drawMonth;
		var year = $('#'+cal.id).data('datepicker').drawYear;
		$('#'+cal.id).data('datepicker').settings['itdaVisMonth'] = month;

		var start = new Date(year, month, 1);
		var end = new Date(year, month, Date.getDaysInMonth(year, month));
		var params = {
			'start-min': $.fullCalendar.formatDate(start, 'u'),
			'start-max': $.fullCalendar.formatDate(end, 'u'),
			'get-offices' : true,
			'get-entries-offices' : true,
			'max-results': 9999,
			'view': type
		};
		$('#expense-detail-content').html('');
		listExpenseEventForUser('/myTracker/listPlannerAd4User', params);
	 }
	var classname = '';
	var dateStr = $.fullCalendar.formatDate( date, 'yyyyMMdd');
	if(gPlannerDates[dateStr])
		classname = 'planner-state-active';
	return [true,classname, ''];	
}

function listExpenseEventForUser(feedUrl, params) {
	gPlannerEntries = [];
	gPlannerArray = [];
	$.ajaxSetup( { "async": false } ); 
	$.getJSON(feedUrl, params, expenseSuccess);
	$.ajaxSetup( { "async": true } ); 		
}


function expenseSuccess(data) {
	sucess(data, gPlannerEntries, gPlannerDates,  '#expense-detail-content');
	currMonthEvents = gPlannerEntries;
}

var plannerPubs = [];

function sucess(data, container, dates, elementId) {

	var events = [];
	if (data.competitors)
		competitors = toAssoArray(data.competitors);
	if (data.publications)
		publications = toAssoArray(data.publications);
	if (data.vendors)
		vendors = toAssoArray(data.vendors);
	if (data.offices)
		offices = toAssoArray(data.offices);

	if (data.entries) {
		$.each(data.entries, function(i, entry) {
			if(entry.deadline)
				entry.deadline = (entry.deadline != null ? $.fullCalendar.parseISO8601(entry.deadline) : null);
			entry.entriesTodos= [];
			entry.entryExpenses= [];
			entry.entrySales= [];

			entry.start = $.fullCalendar.parseISO8601(entry.start);
			//entry.vendors=[];
			//entry.publications=[];
			//entry.offices=[];
			entry.image = '/images/Transparent.gif';
			entry.url='javascript:void(0)';
			container['id='+entry.id] =entry;
			dates[$.fullCalendar.formatDate(entry.start, 'yyyyMMdd')] = true;
		});
	}
	if (data.entriesExpenses) {
		$.each(data.entriesExpenses, function(i, entry) {
				if(container['id='+entry.entryId])
					container['id='+entry.entryId].entryExpenses.push(entry);
		});
	}
	if (data.entriesSales) {
		$.each(data.entriesSales, function(i, entry) {
				if(container['id='+entry.entryId])
					container['id='+entry.entryId].entrySales.push(entry);
		});
	}	
	if(data.today)
		gToday= $.datepicker.parseDate('mm/dd/yy', data.today);
	if(data.business)
		gBusiness = data.business;
	
	for(var key in container)
		if( elementId == 'div.tracker-detail-content.entry-list')
			showTrackerEventDetail(container[key], null, elementId, true);
		else if(elementId == '#expense-detail-content' || elementId == 'div.planner-detail-content.entry-list' 
			|| elementId == '#tracker-detail-content')
			showPlannerEventDetail(container[key], null, elementId);	
 }

function showPlannerEventDetail(data, status, elementId) {
	var	eventsContainer = 'gPlannerEntries', br = '';
	var date = $.fullCalendar.parseDate( data.start );
	var dateStr = $.fullCalendar.formatDate( date, 'yyyyMMdd')
	var html, element, detailLink;
	html = 	'<div id="'+data.id+'-planner-detail-title" class="planner-detail-title"><div>'+data.title+'<span class="fright">'
	+'<img onclick="invokeDelete(event,'+data.id+','+eventsContainer+',\''+eventsContainer+'\',\''+elementId+'\');" class="planner-icon x-icon-red" src="/images/Transparent.gif">'
	+'</span></div></div>';
	html += '<div id="'+data.id+'-planner-detail-info" class="planner-detail-info">';
	//var del = ' | <a href="javascript:void(0);" onclick="invokeDelete(event,'+data.id+','+eventsContainer+',\''+eventsContainer+'\',\''+elementId+'\');"><span class="planner-detail-link-gray">Delete</span></a>';

	html += getSCOVHtml(data);
	
	if(data.size && data.color && data['office.id'] && (data['publication.id'] || data['vendor.id']) )
		detailLink = 'View Details';
	else
		detailLink = 'Add Details';

	if(data.size || data.color || data['office.id'] || (data['publication.id'] || data['vendor.id']) )
		br = '<br/>';
	if('/myTracker' == ctrl)
		html += br + '<a href="javascript:void(0)" onclick="selectAd('+data.id+',\''+elementId+'\');"><span class="planner-detail-link-red">Select</span></a>';
	else 
		html += br + '<a href="javascript:void(0)" onclick="initPlannerEventDetail('+data.id+',new Date('+ date.getTime()+'));disableEventPropagation(event)"><span class="planner-detail-link-green">'+detailLink+'</span></a>';
	
	//html += del;
	if('/myPlanner' == ctrl) {
		if(!data.portfolioEntry && !data.imageFile && !data.pdfFile && (data.className.indexOf('news') == 0  || data.className.indexOf('direct')== 0))
			html += '<br/><a href="javascript:void(0)" onclick="selectAdForPlannerEvent('+data.id+',new Date('+ date.getTime()+'));disableEventPropagation(event)"><span class="planner-detail-link-blue">Select Piece</span></a>';
		else if(!data.sentToVendor && (data['publication.id'] || data['vendor.id']))
			html += '<br/><a href="javascript:void(0)" onclick="sendToVendorDiag(event, gPlannerEntries[\'id='+data.id+'\']);"><span class="planner-detail-link-red">Send to Vendor</span></a>';
		html += '<br/><span class="planner-detail-link-orange" style="text-decoration:none"><strong>Track:</strong></span><a href="myTracker?tab=Expenses&date='+dateStr+'&id='+data.id+'"><span class="planner-detail-link-orange"> Expenses</span></a>';
		if(data.sentToVendor || data.start <= gToday) { //or start date passed
			html += ' | <a href="myTracker?tab=Sales&date='+dateStr+'&id='+data.id+'"><span class="planner-detail-link-orange">Sales</span></a>';
			html += ' | <a href="myTracker?tab=Results&date='+dateStr+'&id='+data.id+'"><span class="planner-detail-link-orange">Results</span></a>';
		}
	}
	html +='<br/></div>';
	var dateNum = $.fullCalendar.formatDate( date, 'yyyyMMdd');
	date =	$.fullCalendar.formatDate( date, 'MMMM d, yyyy');
    element = $(elementId + ' #' + dateNum);
	if(element.length == 0) {
		html = '<div id="'+dateNum+'"><div class="planner-detail-date"><h3>'+date+'</h3></div>' + html +'</div>';
		var dateTmp = $(elementId);
		var detailDates = $(elementId).children();
		if (detailDates.length == 0) {// no event detail content
			$(dateTmp).append(html);	
			return;
		}
		for( i=0; i<detailDates.length; ++i) {
			if(detailDates[i].id > dateNum) {//keep detail sorted by date 
				$(html).insertBefore(detailDates[i]);
				return;
			}
			else
				dateTmp = detailDates[i];
		}
		$(html).insertAfter(dateTmp);			
	} else {
		$(element).append('<div id="'+data.id+'-hr" class="planner-hr"></div>'+html);
	}
}

function getFileName(result, color, maxLen){//TODO: refactor
	var filename= result.imageFile;
	var low = filename.lastIndexOf('/');
	if(low > -1)
		filename = filename.substr(low+1);
	
	var high = filename.lastIndexOf('.');
	if(high > 13)
		return filename.substring(0, 13);
	else if(high > -1)
		return filename.substring(0, high);
    
	if(maxLen && filename.length <= maxLen)
        return filename.substring(0, maxLen);
		
	if(filename.length > 13)
        return filename.substring(0, 13);
    return filename;
}


function getJpgUrl (id, download, color) {
	return '/archive/getJpg/' + id+ '?color=' + color +(download ? '&download=true' : '');	
}

(function ($) {
    $.fn.forceNumeric = function () {
        return this.each(function () {

        	$(this).keyup(function() {
            	var val = $(this).val();
            	if (!/^[0-9,\.\$]+$/.test(val)) {
                    $(this).val(val.replace(/[^0-9,\.\$]/g, ''));
                }
            });
            
            $(this).focusout(function() {
            	var val = $(this).val();
            	if(val != '') {
            		val = getDoubleStr(val);
	            	$(this).val(formatDollarAmount(val));
            	}
            	calculateTotal(null, "div#tabs-1");
            	calculateTotal(null, "div#tabs-2");
            });
        });
    };
})(jQuery);

(function ($) {
    $.fn.forceInteger = function () {
        return this.each(function () {

            $(this).keyup(function() {
            	var val = $(this).val();
            	if (!/^[0-9,]+$/.test(val)) {
                    $(this).val(val.replace(/[^0-9,]/g, ''));
                }
            });
            
            $(this).focusout(function() {
            	var val = $(this).val();
            	if(val != '') {
            		val = getDoubleStr(val);
	            	$(this).val(formatInteger(val));
            	}
            });
        });
    };
})(jQuery);

function getDoubleStr(str) {
    return str.replace(/[^0-9\.]/g, '');	
}

function clearInputNOpen(diag){
	$('input', diag).attr('value', '');
	$('select', diag).attr('value', '');
	$(".errors", diag).hide();
	diag.dialog('open');	
}
var gNewPubDiag; 
function newNewspaper() {
	if(!gNewPubDiag) {
		gNewPubDiag = $('#dialog-new-newspaperr').dialog({  minWidth: 360, mimHeight: 300,  resizable: false , autoOpen : false, modal: true});
		gNewPubDiag.prev().remove();//.css('background-color', 'white');	
		gNewPubDiag.parent().css('background-color', 'white');
		gNewPubDiag.parent().css('border-color', '#B69A2F');
		$('td', gNewPubDiag).css('font-weight', 'bold');
	}
	clearInputNOpen(gNewPubDiag);
	if(ctrl === '/myTracker') {
		$('input[name=email]').val("NA@none.none");		
		$('input[name=contactName]').val("N/A");		
	}
	
}
function saveNewPub() {
	var data = itdaPostJson("/myTracker/saveNewPublication", $("#newPublication").serialize());
	if(data.respText == 'Save completed.') {
		publications['id='+ data.publication.id] = data.publication; 
		var html = '<input name="publication.id" value="'+data.publication.id+'" type="radio">&nbsp;&nbsp;&nbsp;'+data.publication.name+'<br>'
		$('div#newspaperList').append(html);
		$('div#vendorList').append(html);
		gNewPubDiag.dialog('close');
		$("#newPublication input").attr('value', '');
	}else{
		showErrors(".errors", data.errors);
	}
}

var gNewVendorDiag; 
function newVendor(data) {
	if(!gNewVendorDiag) {
		gNewVendorDiag = $('#dialog-new-vendor').dialog({  minWidth: 360, mimHeight: 300,  resizable: false , autoOpen : false, modal: true});
		gNewVendorDiag.prev().remove();	
		gNewVendorDiag.parent().css('background-color', 'white');
		gNewVendorDiag.parent().css('border-color', '#B69A2F');
		$('td', gNewVendorDiag).css('font-weight', 'bold');
	}
	clearInputNOpen(gNewVendorDiag);
	if(ctrl === '/myTracker') {
		$('input[name=email]').val("NA@none.none");		
		$('input[name=contactName]').val("N/A");		
	}
}

function saveNewVendor() {
	//var xhr = itdaPost("/myTracker/saveNewVendor", $("#newVendor").serialize(), undefined, errorHandler, 'json');
	var data = itdaPostJson("/myTracker/saveNewVendor", $("#newVendor").serialize());
	$('#vendor-errors').hide();
	if(data.respText == 'Save completed.') {
		vendors['id='+ data.vendor.id] = data.vendor; 
		var html = '<input name="vendor.id" value="'+data.vendor.id+'" type="radio">&nbsp;&nbsp;&nbsp;'+data.vendor.name+'<br>'
		$('div#newspaperList').append(html);
		$('div#vendorList').append(html);
		gNewVendorDiag.dialog('close');
		$("#newPublication input").attr('value', '');
	}else{
		showErrors("#vendor-errors", data.errors);	
	}
}

function getVendors(eventType) {
	if (eventType == 'news-planner-event' )
		return publications ? publications : [];
	else
		return vendors ? vendors : [];
}

function closeDialog(elementId){
	$('#'+elementId).dialog('close');
}
function addDynamicCommonRadioBoxes(element, inputName, entries, event, entryPropertyName) {
	for (var key in entries) {
		var checked = "", entry = entries[key];
		if (entry.id == event[inputName])
			checked = "checked='true'";
		var html = "<input type='radio' name='"+inputName+"' value='" + entry.id
		+ "' " + checked +"/>&nbsp;&nbsp;&nbsp;" + entry.name + '<br/>';
		element.append(html);
	}
}
function showItdaFormDialog(html, diag) {
	diag.html(html)
				.dialog( "option", "modal", true )
				.dialog('open')
				//.removeClass('ui-dialog-content ui-widget-content')
				 .prev().remove();
}
function showItdaConfirmDialog(html, diag, width, height) {
	if(width)
		diag.dialog( "option", "width", width )
	diag.html(html)
				.dialog( "option", "modal", true )
				.dialog('open')
				.removeClass('ui-dialog-content ui-widget-content')
				 .prev().remove();
	if(height)
		$(diag).css( "height", height);	
}

function showItdaInfoDialog(html, diag, width, height) {
	diag.html('').dialog('close');
	$(document).unbind('click').bind('click',  function() {
		diag.dialog('close').dialog( "option", "modal", true );
		$(document).unbind('click');
	});
	if(width)
		diag.dialog( "option", "width", width );
	//if(width)
		//diag.dialog( "option", "height", '93' );
	diag.html(html)
		.dialog( "option", "modal", false )
		.dialog('open')
		.removeClass('ui-dialog-content ui-widget-content')
		 .prev().remove();
	if(height)
		$(diag).css( "height", height);

}
function itdaPost(url, data, sCallback, eCallback, dataType) {
	$.ajaxSetup( { "async": false } ); 	
	var result = $.post(url, data, sCallback, dataType); 
	$.ajaxSetup( { "async": true } ); 
	return result
}

function itdaPostJson(url, data, sCallback) {
    $.ajaxSetup( { "async": false } );  
    var xhr = $.post(url, data, null, 'json'); 
    $.ajaxSetup( { "async": true } ); 
    return toJson(xhr);
}

function errorHandler(data1, data2, data3) {

}


function toJson(xhr){
	if(xhr.status == 401) {
		window.location.href = '/helper/login'
		return;
	}
	var json = (new Function( "return( " + xhr.responseText+ " );" ))();
	return json;
}

function saveAccountInfo(action, formId, errorList) {
	$("#errorList").hide();
	saveAccountRelationship(action, action, formId, errorList)		
}

function saveAccountRelationship(action, redirect, formId, errorList) {
	//var xhr = itdaPost(action, $(formId).serialize(), undefined, errorHandler, 'json');	
	var data = itdaPostJson(action, $(formId).serialize());
	saveAccountRelationshipEventHandler(data, window.location.href);
}
function saveAccountRelationshipEventHandler(data, redirect) {
	if(data.respText.match(/completed\.$/) != null) {
		gMyAcctDiag.dialog('close');
		if(redirect)
			window.location.href = redirect;
			//console.info ('redirecting to redirect ' + redirect);
	}else
		showErrors("#errorList", data.errors);
}
function doDeleteAcctItem(id, elementId, delUrl) {
	//var xhr = itdaPost(delUrl, {id: id}, undefined, undefined, 'json');		
	var data = itdaPostJson(delUrl, {id: id});
    if (data.respText == 'Delete completed.' ) {
   	 $(elementId).remove();
   	 gdiaglogSmall.dialog('close');
	}else if(data.errors)
		showErrors("#errorList", data.errors);
}
function openDelAcctInfoDialog( id, elementId, path) {	
	var html = '<div style="height:10px"/>'
		+'<h3>Are you sure you want<br/>to delete this item?</h3><br/><br/>'
		+'<img src="/images/Transparent.gif" style="float:right;margin-left:20px" class="tracker-icon tracker-cancel-orange-btn" onclick="gdiaglogSmall.dialog(\'close\')"></img><img src="/images/Transparent.gif" class="tracker-icon tracker-delete-gray-btn" style="float:right" onclick="doDeleteAcctItem('+id +', \''+elementId+'\', \''+path+'\');gdiaglogSmall.dialog(\'close\')"></img></div>'
		+'<div style="height:10px"/>';
	if(!gdiaglogSmall)
		gdiaglogSmall = $('#dialog-small').dialog({modal: true,  height: 'auto', width: 330, maxWidth: 350, resizable: false , autoOpen : false});
	showItdaConfirmDialog(html, gdiaglogSmall, 350)
	return false;
}
function openAcctInfoDialog(title, desc) {	
	var html = '<span style="float:right;margin-left:20px" class="my-acct acct-close-icon" onclick="gdiaglogSmall.dialog(\'close\')"></span><div style="height:10px"/>'
		+'<h2>'+title+'</h2>'
		+ desc
		+'<div style="height:10px"/>';
	if(!gdiaglogSmall)
		gdiaglogSmall = $('#dialog-small').dialog({modal: true,  height: 'auto', width: 330, maxWidth: 350, resizable: false , autoOpen : false});
	showItdaConfirmDialog(html, gdiaglogSmall)
	return false;
}
function showErrors(elemId, errors) {
	var html = '';
	for(var key in errors)
		html += '<li>' + errors[key] + '</li>';
	$(elemId).html('').html('<ul>'+html+'</ul>').show();	
}

function bindAjaxFunctions(){
  $("html").bind("ajaxStart", function(){ $(this).addClass('busy');})
  		   .bind("ajaxStop", function(){$(this).removeClass('busy');});	
}
function unbindAjaxFunctions(){
	  $("html").unbind("ajaxStart")
	  		   .unbind("ajaxStop");	
}
function getRatingInfo(entry) {
	  var rating = 0,  html = '';
	  for(var j=0; j<5; j++)
	  	    if(j+1 <= entry.rating){
		     	html +="<div class='itda-archive-icon rating-orange-icon' style='float:left'></div>";
	  			rating = j+1;
	  	    }else if(j+0.5<= entry.rating){
		     	html +="<div class='itda-archive-icon rating-half-icon' style='float:left'></div>";
		     	rating = j + 0.5;
			}else{
	     		if(0<entry.rating)
	     			html +="<div class='itda-archive-icon rating-white-icon' style='float:left'></div>";
	     		else
	     			html +="<div class='itda-archive-icon rating-black-icon itda-off' style='float:left'></div>";
		    }	
	  return {rating:rating, html:html}
}
function goToPage(select){
	if(select.selectedIndex == 0 || select.selectedIndex == currPage) return
	document.forms['filter-form'].offset.value = document.forms['filter-form'].max.value * (select.selectedIndex -1);
	updateResult();
}
function toggleImagePreview(input, selector) {
	var img;
	if(selector)
		selector += ' img[id^="small-image-"]';
	else
		selector = 'img[id^="small-image-"]';
	$( selector ).each( function(index, image) {
		//console.info(image.id);
		img = $(image);
		img.unbind('mouseenter').unbind('mouseout');
		if(input.checked==true)
		    img.loupe(); 		 
	});		
}
function done(ele){
	ele.blur();
}

//Tips
var gTipsDiag;
function showTips(diagEle, anchorToEle, url, offsetX, offsetY) {
	var html;
	if(!offsetX) offsetX = 0;
	if(!offsetY) offsetY = 0;	
	var pos=$(anchorToEle).position();
	if(!gTipsDiag) {
		gTipsDiag = $(diagEle).dialog({ minWidth: 405, mimHeight: 800, resizable: false,
			autoOpen : false, modal: true,position:[pos.left+offsetX,pos.top+offsetY]});
		gTipsDiag.prev().remove();
		gTipsDiag.parent().css('border', '3px solid #923625');
		gTipsDiag.bind('dialogbeforeclose', back);
		$(document)./*resize(resize).*/scrollTop(0);		
		var xhr = itdaPost(url, {}, undefined, errorHandler, 'html');
		html = xhr.responseText;
		$('.qa', gTipsDiag).remove();
		gTipsDiag.data('offsetX', offsetX);
		gTipsDiag.data('offsetY', offsetY);
		gTipsDiag.data('anchorToEle', anchorToEle);
	}else{
		html = $(gTipsDiag).html();
		$(gTipsDiag).html('');
		$(window)./*resize(resize).*/scrollTop(0);		
	}
	gTipsDiag.dialog('open');
	$(gTipsDiag).append(html);
	//$('.qa:odd').addClass('odd');
}
function resize(){
	if(gTipsDiag){
		var pos=$(gTipsDiag.data('anchorToEle')).position();
		var offsetX = gTipsDiag.data('offsetX');
		var offsetY = gTipsDiag.data('offsetY');
		gTipsDiag.dialog( "option", "position", [pos.left+offsetX,pos.top+offsetY] );
		gTipsDiag.parent().css('top',pos.top+offsetY);
	}
}
function back(event, ui){
	$("div.answer").hide();
	$(".qa .goback").remove();		
	$("span.rBracket").show()
	$(".qa").css('visibility','visible');	
}
function viewQA(q){
	$('.qa').css('visibility','hidden');
	$(q).parent().css('visibility','visible');
	$(q).siblings().show();
	$(q).next().hide();
	var html = $("#back").html();
	$(".qa .goback ").remove();
	$(q).parent().append(html);
	$(".qa .goback span").show().bind('click',back);
}

function closeTrackerDialogs(){
	 $('#dialog').dialog('close');
	 $('#dialog-small').dialog('close');
	 $('#dialog-review-policy').dialog('close');
	 $('#dialog-publish-review').dialog('close');
}

function showLargeImage(e) {
	 $('#adImageLarge').html("<img src='"+ e.data.url+"' style='padding-top:35px;margin:auto'/>");
	 var diag = $('#dialogAdImage').dialog('open');
	 $('input.itda-archive-icon.close-btn').blur();
	var iheight = $('#adImageLarge img').height(), iwidth= $('#adImageLarge img').width();
	if(iwidth >= 100 && iwidth <= 330 )
		iwidth = Math.floor(2.2 * iwidth);
	else if(iwidth >= 100 && iwidth <= 500)
		iwidth *= 2;
	else
		iwidth = 1000;
	$('#adImageLarge img').width(iwidth);
	return false;
}

function htmlEncode(value){
	return $('<div/>').text(value).html();
}

function htmlDecode(value){
	return $('<div/>').html(value).text();
}