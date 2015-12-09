function displayWorkingDate(workingDate, orderDesc, events, id) {
 $('#accordion').accordion('activate', -1);
 events = $(gSmlFc).data('itdaEvents');
	var day = $.fullCalendar.formatDate(workingDate, 'dddd');
	$('div.fc-day-number').removeClass('ui-active');
	var currEventDate = $.fullCalendar.formatDate( workingDate, 'yyyyMMdd');
	var classname = '#fc-day-' + currEventDate;
	$(classname + ' div.fc-day-number').addClass('ui-active');	
	
	var html = '<div style="text-transform:capitalize;font-size:26px;color:black; line-height:1.3">' + day
			.toLowerCase() + '</div>';
	html += '<div style="font-size:30px;color:black;line-height:1.3">' + $.fullCalendar.formatDate(workingDate,
			'MMMM dS, yyyy') + '</div>';
	$('#date').html(html);
	$('div#static-tab img[class$="-planner-event"]').addClass('itda-off');
	var currEvents = $('#currentWorkingDayEvents');
	$('option', currEvents).remove();
    var iteratingEvent, userSelectEvent, selected; 
 	for(var key in events){
 		var	event = events[key];
		if ($.fullCalendar.formatDate(workingDate, 'yyyyMMdd') == $.fullCalendar.formatDate(event.start, 'yyyyMMdd')) {
			 $('div#static-tab img.' + event.className).removeClass('itda-off');				
			if(event.id == id){
				selected  =  'selected="selected"' ;
				userSelectEvent = event;
			}else
				selected  =  '' ;
			var html = "<option value='" +event.id+ "' "+selected+">" + event.title + "<option>";
			currEvents.append(html);
			$(':last-child', currEvents).remove();
			if(orderDesc == true) {
				iteratingEvent = event;
			}else{
				if(iteratingEvent == undefined) {//not selected in prev iteration
					iteratingEvent = event;
				}
			}
		}
	}
	var accordion = $('#accordion');
	if(!userSelectEvent)
		userSelectEvent = iteratingEvent;
	if(userSelectEvent) {
		$('div div#buttons', accordion).attr('style', 'display:block' );
		updateAccordion(userSelectEvent);
		updateEventSelectBox(eventSelectBox, userSelectEvent.id);	
//		$('#accordion').accordion('activate', -1);
	} else {
		//$('div div#buttons', accordion).attr('style', 'display:none' );
		$(classname + ' div.fc-day-number').removeClass('itda-sm-cal-event');
		updateAccordion(getEmptyEvent(workingDate)); 
		$('#accordion').accordion('disable');
		var html = "<span>You have no marketing selected for<br/>" +
					"this date. To Add a marketing item,<br/>" +
					"click on one of the icons to the left.</span>";
		$('.plannerContent #adImage').html(html)
					 .children().attr('style','display: block; margin-top:220px; margin-left:75px; line-height:1.3; font-size:15px; color: #0076A3');
		html = "<span>You have no marketing selected for this<br/>" +
				"date. To Add a competitor marketing item,<br/>" +
				"click on one of the icons to the left.</span>";
		$('#tracker-detail-content #adImage').html(html)
		 			.children().attr('style','display: block; margin-top:220px; margin-left:55px; line-height:1.3; font-size:15px; color: #0076A3');
	}
} 
// //////////////////
function init() {	
/////////	
	eventSelectBox = $("#currentWorkingDayEvents").get(0);
    $( "#pdtl-calendar").fullCalendar('gotoDate', selectedDate);

    $( "#pdtl-calendar .ui-widget-content" ).attr('style','border:0' );
    $("#pdtl-calendar.fc table.fc-header tbody tr td.fc-header-left")
    	.html('<a href="#prev" onclick="$(\'#pdtl-calendar\').fullCalendar(\'prev\');"><img src="/images/Transparent.gif" class="tracker-icon small-prev-icon" style="margin-left:8px"/></a>');	        
    $("#pdtl-calendar.fc table.fc-header tbody tr td.fc-header-right")
	.html('<a href="#prev" onclick="$(\'#pdtl-calendar\').fullCalendar(\'next\');"><div class="e-arrow-greengb"/></a> ')
	.html('<a href="#prev" onclick="$(\'#pdtl-calendar\').fullCalendar(\'next\');"><img src="/images/Transparent.gif" class="tracker-icon small-next-icon" style="float:right;padding-right:5px"/></a> ');	        
    
}

function plannerEventChanges(selectBox){
	var events = $(gSmlFc).data('itdaEvents');
	var selectedEntry = selectBox[selectBox.selectedIndex].value;
	for(i=0; i<events.length; i++){
		if(events[i].id == selectedEntry) {
			updateAccordion(events[i]);
			$('#accordion').accordion('activate', -1);
			return true;
		}
	}
}

function getCheckedValues(formName, inputName) {
	var values = '';
	var inputs = document.forms[formName].elements[inputName];
	if(inputs == undefined)
		return  '';
	if(inputs.length == undefined )
		if(inputs.checked)
			return  escape(inputName) + '=' + escape(inputs.value);
		else 
			return '';
	for(var i = 0; i < inputs.length; i++) {
		if(inputs[i].checked)
			values += (values == '' ?  escape(inputName) + '=' + escape(inputs[i].value) : '&' + escape(inputName) + '=' + escape(inputs[i].value));
	}
	return values;
}

function updateAccordion(plannerEvent) {
	deadlineDate = null;
	selectedPlannerEntry = plannerEvent;
	updateCtxSensitiveTips(plannerEvent);
	var accordionElement = $('#accordion');
	
	if(ctrl == '/myTracker') {
		$('#competitorList', accordionElement).html('');
		$('#vendorList', accordionElement).html('');
		addDynamicCommonRadioBoxes($('#competitorList', accordionElement), 'competitor.id', competitors, plannerEvent, 'competitorAdEntries');
		if(plannerEvent.className == 'news-planner-event')
			addDynamicCommonRadioBoxes($('#vendorList', accordionElement), 'publication.id', publications, plannerEvent, 'competitorAdEntries');
		else
			addDynamicCommonRadioBoxes($('#vendorList', accordionElement), 'vendor.id', vendors, plannerEvent, 'competitorAdEntries');
	}else{
		$('#officeList', accordionElement).html('');
		addDynamicCommonRadioBoxes($('#officeList', accordionElement), 'office.id', offices, plannerEvent,'plannerEntries'); //could be optimized
		var vl = $('#vendorList', accordionElement).html('');
		if(plannerEvent.className == 'news-planner-event')
			addDynamicCommonRadioBoxes(vl, 'publication.id', publications, plannerEvent, 'plannerEntries');
		else
			addDynamicCommonRadioBoxes(vl, 'vendor.id', vendors, plannerEvent, 'plannerEntries');
	}
	initDeadlineCal();

	header = $('#selectad-header-text');
	repeatheader = $('#repeadad-header-text');
	if(plannerEvent.className.indexOf('news')==0){
		header.html('Select Ad');
		repeatheader.html('Repeat Ad')
		$('div#selectAdFrom-accordion a').show();			
	}else if(plannerEvent.className.indexOf('directmail')==0){
		header.html('Choose Piece');	
		repeatheader.html('Repeat Ad')
		$('div#selectAdFrom-accordion a').show();			
	}else if(plannerEvent.className.indexOf('media')==0){
		header.html('Choose Media');
		repeatheader.html('Repeat Media')
		$('div#selectAdFrom-accordion a').hide();	
		$('div#selectAdFrom-accordion a#pickfiles').show();	
	}else {
		if(plannerEvent.className.indexOf('event')==0)
			repeatheader.html('Repeat Event');
		else
			repeatheader.html('Repeat')			
		header.html('Choose File');		
		$('div#selectAdFrom-accordion a').hide();	
		$('div#selectAdFrom-accordion a#pickfiles').show();	
	}

    if(document.forms['notes-form']) {
    	if(document.forms['notes-form'].selfNotes)
    		document.forms['notes-form'].selfNotes.value = (plannerEvent.selfNotes == null ? '' :plannerEvent.selfNotes);
		if(document.forms['notes-form'].vendorNotes)
			document.forms['notes-form'].vendorNotes.value = (plannerEvent.vendorNotes == null ? '' :plannerEvent.vendorNotes);
		if(document.forms['notes-form'].notes)
			document.forms['notes-form'].notes.value = (plannerEvent.notes == null ? '' :plannerEvent.notes);
    }
    var todoList = $('#todosList', accordionElement);
    if(todoList.length > 0){
	    todoList.html('');
		document.forms['add-todo-form'].id.value = plannerEvent.id;
		if(plannerEvent.todos)
			addDynamicEventTodos($('#todosList', accordionElement), 'todos', plannerEvent.todos);
    }

	initRepeatAdCal(); // repeatadDates = [];

		var newsLen = 1, dmLen =1, eventLen =1, mediaLen =1, miscLen=1;  
		for(j = 0; j < eventSelectBox.length; j++) {
			   if(eventSelectBox[j].text.indexOf('NEWS') == 0) 
				   newsLen++;
			   else if(eventSelectBox[j].text.indexOf('DIRECT') ==0) 
				   dmLen++;
			   else if(eventSelectBox[j].text.indexOf('EVENT') == 0) 
				   eventLen++;
			   else if(eventSelectBox[j].text.indexOf('MEDIA') == 0) 
				   mediaLen++;
			   else if(eventSelectBox[j].text.indexOf('MISC') == 0) 
				   miscLen++;
			   }

		var html = '<input name="start" value="date.struct" type="hidden"/>'+
				   '<input name="start_year" value="'+plannerEvent.start.getFullYear()+'" type="hidden"/>'+
				   '<input name="start_month" value="'+(plannerEvent.start.getMonth() + 1)+'" type="hidden"/>'+
				   '<input name="start_day" value="'+plannerEvent.start.getDate()+'" type="hidden"/>';

		$('#newmarketing-accordion form', accordionElement)
			.html(html)
			.append("<input type='radio' name='className' value='news-planner-event'/>")
			.append('&nbsp;&nbsp;&nbsp;NEWSPAPERS AD #'+ newsLen +'<br/>')
			.append("<input type='radio' name='className' value='directmail-planner-event'/>")
			.append('&nbsp;&nbsp;&nbsp;DIRECT MAIL #'+ dmLen +'<br/>')
			.append("<input type='radio' name='className' value='event-planner-event'/>")
			.append('&nbsp;&nbsp;&nbsp;EVENT #'+ eventLen +'<br/>')
			.append("<input type='radio' name='className' value='media-planner-event'/>")
			.append('&nbsp;&nbsp;&nbsp;MEDIA #'+ mediaLen +'<br/>')
			.append("<input type='radio' name='className' value='miscellaneous-planner-event'/>")
			.append('&nbsp;&nbsp;&nbsp;MISCELLANEOUS #'+ miscLen +'<br/>');

	instantiateAccordion(plannerEvent); //rebuild accordion
	updateSummary(plannerEvent);
	registerButtonListeners(accordionElement, plannerEvent);

}

function updateSummary (plannerEvent) {
	var html;
    $('#summary').html('').show();
    $('#adImage').html('');
    $('#adImageRemoveIcon').remove();
    if(!plannerEvent.id) return;
    
    if(ctrl == '/myTracker'){
    	var publication = '';
    	if(plannerEvent.imageFile){
	    	var url = ctrl+"/getImageFile/"+ plannerEvent.id + "?token=" +escape(plannerEvent.imageFile);
	    	$('#adImage').html("<img src='"+url+"' style='padding-top:15px;display: block;margin-left: auto;margin-right: auto; max-width:389px; max-height:480px'/>");
	    	$('#adImage img').bind('click', {url:url}, showLargeImage);
    		
			$('.right-side-border-35-509').prepend('<img id="adImageRemoveIcon" onclick=\'unselectAdImage('+plannerEvent.id+')\' src="/images/Transparent.gif" class="planner-icon x-icon-red" style="position: relative; top: 15px; right: -5px;"/>');
			$('.right-side-border-35-509 .small-next-icon').attr('style', 'position:relative;top:468px;left:12px');
    	}else {
			$('.right-side-border-35-509 .small-next-icon').attr('style', 'position:relative;top:482px;left:11px');
    	}
    	html = '<h3><span style="float: left;">'+plannerEvent.title+'</span><span style="float: right;">' +
    	       '<img src="/images/Transparent.gif" class="planner-icon x-icon-red" onclick="invokeDelete(event,'+plannerEvent.id+',gCompetitorAdEntries,\'gCompetitorAdEntries\',\'div.tracker-detail-content.entry-list\');"></span></h3><div style="clear:both;height:1px"/><hr/>'
   		$('#summary').append(html)

		if(plannerEvent['competitor.id'])
			$('#summary').append('<b>Competitor:</b><br/>' +competitors['id='+plannerEvent['competitor.id']].name + '<hr/>');
    	html = getSCHtml(plannerEvent);
    	if(html != '')
    		$('#summary').append(html + '<hr/>');
    	html = getVendorHtml(plannerEvent, true, true);
    	if(html != '')
    		$('#summary').append(html + '<hr/>');
    	if(plannerEvent.notes)
    		$('#summary').append('<b>Notes:</b><br/>'+ plannerEvent.notes.replace( /\n/g, '<br/>') );		
	}else {	
	    $('#summary').append("<h3><span style='float:left'>"+plannerEvent.title+
	    		"</span><span style='float:right'><img src='/images/Transparent.gif' class='planner-icon x-icon-red' onclick=\"invokeDelete(event,"+plannerEvent.id+",gPlannerDetailEntries,'gPlannerDetailEntries','div.planner-detail-content.entry-list');\"/></span></h3><div style='clear:both;height:1px'/><hr/>");
	    var html = getSCOVHtml(plannerEvent); 
	    if(html != '')
	    	$('#summary').append(html + '<hr/>');
	    if(plannerEvent.deadline)
	    	$('#summary').append('<b>Deadline:</b> ' + $.fullCalendar.formatDate($.fullCalendar.parseDate( plannerEvent.deadline), 'MMMM dd')+'<hr/>');
	    if(plannerEvent.quantity || (plannerEvent.zipcodes && plannerEvent.zipcodes.length >0)){
	    	html = '';
	    	if(plannerEvent.quantity)
	    			html = '<b>Quantity:</b> ' + plannerEvent.quantity;
	    	if(plannerEvent.zipcodes  && plannerEvent.zipcodes.length >0) {
	    		if (html != '') 
	    			html += '<br/>'
	    		html += '<b>Zip Codes:</b> ' + plannerEvent.zipcodes.join(", "); 
	    	}
	    	$('#summary').append(html + '<hr/>');
	    }
		if(plannerEvent.portfolioEntry){
			$('#summary').append('<b>Description:</b><br/> '+ plannerEvent.portfolioDesc +'<br/>' +
			getFileName(plannerEvent.portfolioEntry, null, 256) + '<hr/>');
		}
		if(plannerEvent.selfNotes)
			$('#summary').append('<b>Notes to Self:</b><br/>'+plannerEvent.selfNotes.replace( /\n/g, '<br/>')+'<br/>');
		if(plannerEvent.vendorNotes){
			if(plannerEvent.selfNotes)
				$('#summary').append('<div style="height:7px"></div>');
			$('#summary').append('<b>Notes to Vendor:</b><br/>'+plannerEvent.vendorNotes.replace( /\n/g, '<br/>'));
		}
		if(plannerEvent.selfNotes || plannerEvent.vendorNotes)
			$('#summary').append('<hr/>');
		$('#summary').append(getTodosHtml(plannerEvent));
	    if(plannerEvent.portfolioEntry && plannerEvent.color) {
	    	var url = getJpgUrl(plannerEvent.portfolioEntry.id, undefined,getColorNum(plannerEvent.color));
	    	$('#adImage').html("<img src='"+ url+"' style='padding-top:15px;display: block;margin-left: auto;margin-right: auto; max-width:420px; max-height:480px'/>");
	    	$('#adImage img').bind('click', {url:url}, showLargeImage);
			$('#right-border-sap-content').append('<img id="adImageRemoveIcon" onclick=\'unselectPortfolioEntry('+plannerEvent.id+')\' src="/images/Transparent.gif" class="planner-icon x-icon-red" style="position: absolute; top: 13px; right: 13px;"/>');
	    }
	    else if(plannerEvent.imageFile){
	    	var url = ctrl+"/getImageFile/"+ plannerEvent.id + "?token=" +(new Date()).getTime();
	    	$('#adImage').html("<img src='"+url+"' style='padding-top:15px;display: block;margin-left: auto;margin-right: auto; max-width:420px; max-height:480px'/>");
	    	$('#adImage img').bind('click', {url:url}, showLargeImage);
			$('#right-border-sap-content').append('<img id="adImageRemoveIcon" onclick=\'unselectPortfolioEntry('+plannerEvent.id+')\' src="/images/Transparent.gif" class="planner-icon x-icon-red" style="position: absolute; top: 13px; right: 13px;"/>');	    	
	    }else if(plannerEvent.pdfFile){
			$('#adImage').html('<img class="itda-archive-icon pdf-icon" src="/images/Transparent.gif" style="margin-top:205px;display: block;margin-left: auto;margin-right: auto; max-width:420px; max-height:480px"/><br/>');
		}

    }
}

function getTodosHtml(plannerEvent) {
	var todo='', hasTodos = !isEmpty(plannerEvent.todos);
	if(hasTodos) {
		todo = '<b>To Do:</b><table>';
		for(i=0; i<plannerEvent.todos.length; i++) {
			todo += '<tr>';
			var checked = "", classname='';
			if (plannerEvent.todos[i].isCompleted == true) {
				checked = " checked='true'";
				classname="class='gray'";
			}
			todo += '<td><input type="checkbox" disabled="disabled"'+checked+'/></td><td><span '+classname+'>'+ plannerEvent.todos[i].title +'</span></td>';
			todo += '</tr>';
		}
		todo +='</table>';
	}
	return todo;
}
////////////////////////////////////////////////////
function addPlannerDynamicCommonCheckBoxes(element, inputName, entries, plannerEvent, radio) {
	var type  = radio ? 'radio' : 'checkbox';
	for (var key in entries) {
		var checked = "";
		if (entries[key].plannerEntries[plannerEvent.id] == 'true')
			checked = "checked='true'";
		else if (entries[key].plannerEntries['id='+plannerEvent.id] == 'true') {
			checked = "checked='true'";
			//key = key.substr(3);
		}
		
		var html = "<input type='" +type+ "' name='"+inputName+"' value='" + entries[key].id
		+ "' " + checked +"/>&nbsp;&nbsp;&nbsp;" + entries[key].name + '<br/>';
		element.append(html);
	}
}

function addDynamicCommonListBox(element, inputName, entries, plannerEvent) {
	var selected = '';
	//element.html('');
	if(plannerEvent.zipcodes)
			selected = plannerEvent.zipcodes.toString();
	var html = '<select class="listselect" id="'+inputName+'ListSelect" name="'+inputName+'[]" selected="'+selected+'">';
	for (i=0; i<entries.length; i++) {
		html += '<option value="'+entries[i]['zipcode']+'">'+entries[i]['zipcode']+'</option>'
	}
	element.append(html+'</select>');
}


function addDynamicEventSpecificCheckBoxes(element, checkboxInputName, entries) {
	for (key=0; key<entries.length; key++) {
		var checked = "";
		if (entries[key].isCompleted == true)
			checked = "checked='true'"
		var html = "<input type='checkbox' name='"+checkboxInputName+"' value='" + entries[key].id
		+ "' " + checked +"/>&nbsp;&nbsp;&nbsp;" + entries[key].title + '<br/>';
		element.append(html);
	}
}

function addDynamicEventTodos(element, checkboxInputName, entries) {
	var html = '';
    	entries.sort(function(a, b){
    		if (a.id > b.id) return 1;
    		else if (a.id < b.id) return -1;
    		else return 0;
    	}); 	
	for (key=0; key<entries.length; key++) {
		var checked = "";
		var css = "";
		if (entries[key].isCompleted == true){
			checked = "checked='true'"
			css = "class='itda-off'"
		}
		html += "<tr>"+
		"<td width='15px' "+css+"><input type='checkbox' name='"+entries[key].id+"' value='true' " + checked +" style='clear:both;float:left'/></td>"
		   +"<td width='230px' "+css+"><span style='float:left'>"+entries[key].title+"</span></td>"
		   +"<td width='15px'><input name='del-todo' class='planner-icon x-icon-red' onclick='deleteTodo(\""+entries[key].id+"\");return false;' type='submit' style='float:right' value=''/></td>"
	    +"</tr>"
	}
    if(html != '')
    	html = '<table width="100%">' + html + '</table>';
	element.append(html);
}

////////////////////////////////////////////////////////
function registerButtonListeners(accordion, plannerEvent) {
////////////////////
	$("#save-newmarketing", accordion)
	.unbind('click')
	.click(function() {
    // validate and process form here
		var val = $('#newmarketing-form input:radio[name=className]:checked').val();
		if (val == undefined ) {
		     $('#newmarketing-message', accordion)
	  		.html('Select a marketing.').show();
		      	return false;
		}
		return saveNewMarketingForm('#newmarketing-form', '#newmarketing-message');
	});
}

function saveNewMarketingForm(formId, formMsgDiv, marketingType) {
	var uri = ctrl + "/createJson4User";
	$(formId +' input:radio[value="'+marketingType+'"]').attr('checked','true');
	var newEvent = itdaPostJson(uri, $(formId).serialize());
	return addToDetailCal(newEvent);
}

function addToDetailCal(newEvent){
	var entryContainer, dateContainer, newEntryContainer;
	if( ctrl == '/myTracker'){
		entryContainer = gCompetitorAdDetailEntries;
		dateContainer = gCompetitorAdDetailDates;
		newEntryContainer = gCompetitorAdNewEntries;
	}else{
		entryContainer = gPlannerDetailEntries;
		dateContainer = gPlannerDetailDates;
		newEntryContainer = gPlannerNewEntries;
	}
	
	var serverEvent; 
	if(newEvent.responseText)	
		serverEvent =(new Function( "return( " + newEvent.responseText+ " );" ))();
	else
		serverEvent = newEvent;
	if(serverEvent && serverEvent.id > 0) {
		serverEvent.image = '/images/Transparent.gif';
		var key = 'id='+serverEvent.id;
		serverEvent.start = $.fullCalendar.parseISO8601(serverEvent.start)		
		entryContainer[key] = serverEvent;
		var  day =$.fullCalendar.formatDate(serverEvent.start, 'yyyyMMdd');
		var classname = '#fc-day-' + day;
		$(classname + ' div.fc-day-number').addClass('itda-sm-cal-event');
		dateContainer[day] = true;
		var events = toNonAssoArr(entryContainer);
		events = sortArray(events);
		$(gSmlFc).data('itdaEvents', events)
				.data('itdaDates', dateContainer);	
		newEntryContainer = $(gSmlFc).data('itdaNewEvents');
	

		displayWorkingDate(serverEvent.start, false, entryContainer, serverEvent.id);
		$('#accordion').accordion('activate', -1);
		if(newEntryContainer)
			newEntryContainer[key] = serverEvent;
		else{
			newEntryContainer = [];
			newEntryContainer[key] = serverEvent;
		}
		$(gSmlFc).data('itdaNewEvents', newEntryContainer);

		return true;
	}
	return false;
}
function selectEventType(eventType){
	if($('div#static-tab img.' + eventType).hasClass('itda-off'))
		return saveNewMarketingForm('#newmarketing-form', '#newmarketing-message', eventType);
	var events = $(gSmlFc).data('itdaEvents');
	for(j = 0; j < eventSelectBox.length; j++) {
	   var id = eventSelectBox[j].value;
	   for(i=0; i<events.length; i++){
			if(events[i].id == id && events[i].className == eventType) {
				eventSelectBox.selectedIndex = j;
				updateAccordion(events[i]);
				$('#accordion').accordion('activate', -1);
				return true;
			}
		}	   
	}
	return false;
}

function getEmptyEvent(workingDate) {
	return {
			vendorNotes: null,
			todos: [],
			entriesTodos: [],
			repeatDates : [],
			deadline: null
			,className: 'news-planner-event'
			,start : workingDate
		};
}

function nextPlannerEvent(plannerEvent) {
	var events = $(gSmlFc).data('itdaEvents');
	if($.fullCalendar.formatDate(plannerEvent.start, 'yyyyMMdd') < $.fullCalendar.formatDate(calVisStart, 'yyyyMMdd')) {
		displayWorkingDate(events[0].start, null, events);
		return;
	}else if($.fullCalendar.formatDate(plannerEvent.start, 'yyyyMMdd') > $.fullCalendar.formatDate(calVisEnd, 'yyyyMMdd')){
		displayWorkingDate(events[events.length-1].start, null, events);
		return;		
	}
	for(i=1; i<events.length; i++){
		if(events[i-1].id == plannerEvent.id) {
			if ($.fullCalendar.formatDate(plannerEvent.start, 'yyyyMMdd') != $.fullCalendar
					.formatDate(events[i].start, 'yyyyMMdd')){ 
				displayWorkingDate(events[i].start, null, events);
				return;
			}else{
				for(j = 0; j < eventSelectBox.length; j++) {
				   if(eventSelectBox[j].value == events[i].id) {
					   eventSelectBox.selectedIndex = j;
					   updateAccordion(events[i]);
						$('#accordion').accordion('activate', -1);
					   return;
				   }
				 }
				return;
			}
		}
	}
}

function prevPlannerEvent(plannerEvent) {
	var events = $(gSmlFc).data('itdaEvents');
	if($.fullCalendar.formatDate(plannerEvent.start, 'yyyyMMdd') < $.fullCalendar.formatDate(calVisStart, 'yyyyMMdd')) {
		displayWorkingDate(events[0].start, true, events);
		return;
	}else if($.fullCalendar.formatDate(plannerEvent.start, 'yyyyMMdd') > $.fullCalendar.formatDate(calVisEnd, 'yyyyMMdd')){
		displayWorkingDate(events[events.length-1].start, true, events);
		return;		
	}	
	for(i=events.length-2; i>=0; i--){
		if(events[i+1].id == plannerEvent.id) {
			if ($.fullCalendar.formatDate(plannerEvent.start, 'yyyyMMdd') != $.fullCalendar
					.formatDate(events[i].start, 'yyyyMMdd')) {
				displayWorkingDate(events[i].start, true, events);
				return;
			}else{
				updateEventSelectBox(eventSelectBox, events[i].id);
				updateAccordion(events[i]);
				$('#accordion').accordion('activate', -1);
				return;
			}
		}
	}
}

function updateEventSelectBox(selectBox, selectVal) {
	for(j = 0; j < selectBox.length; j++) {
	   if(selectBox[j].value == selectVal) {
		   selectBox.selectedIndex = j;
		   return;
	   }
	}	
}

function keyPressed(e, element) {
	if ($.browser.mozilla) {
		var key = String.fromCharCode(e.keyCode);
		if (key == "\n" || key == "\r") {
			element.value += '\n'
		}
	}
	return true;
}

var accordion=null, isSizeHeader=true, isQuantityHeader=true, isColorHeader=true;
function instantiateAccordion (plannerEvent) {
	
	if(accordion != null) {
		plannerArchiveCtrl.destroySelectAdUploader();		
		accordion.accordion('destroy');
		accordion = null;
		uploader = undefined;	    	
	}
	
		var header = $('#size-header'), vendorHeader = $('#vendors-header');
		var html = header.html(), vendorHtml = vendorHeader.html();	
		if(plannerEvent.className.indexOf('news')==0) {
			header.html(html.replace('Type', 'Size'));
			vendorHeader.html(vendorHtml.replace('Vendor', 'Newspaper'));
			$('#new-vendor-btn').html('<input onclick="newNewspaper();this.blur();return false;" value="" class="tracker-icon new-newspaper-icon" name="new-newspaper" type="submit"/>');
		}else{ 
			header.html(html.replace('Size', 'Type'));
			vendorHeader.html(vendorHtml.replace('Newspaper', 'Vendor'));
			$('#new-vendor-btn').html('<input onclick="newVendor();this.blur();return false;" value="" class="planner-icon new-vendor-btn-gray" name="new-vendor" type="submit"/>');
		}
		$('#size-accordion form input[name="size"]', accordion).attr('checked', false);
		$('#size-accordion div div[class$="-planner-event"]', accordion).attr('style', 'display:none');
		$('#size-accordion div div.'+ plannerEvent.className, accordion).attr('style', 'display:block');
		$('#size-accordion form input[value="'+plannerEvent.size+'"]', accordion).attr('checked', true);
		$('#size-accordion form div.otherSize').html('');
		$('#size-accordion form .' +plannerEvent.className + ' div.otherSize').html('<input type="text" name="otherSize" value="" style="margin-left:25px" onfocus=\'$("#size-form input[value=OTHER]:visible").attr("checked", true)\'/><br/>');
		if(plannerEvent.size === 'OTHER'){
			$('#size-accordion form input[name=otherSize]').attr('value', plannerEvent.otherSize);
			$('#size-accordion form .' +plannerEvent.className + ' input[value=OTHER]').attr('checked', true);
		}
		$('#quantity-accordion form input[name="quantity"]', accordion).val([plannerEvent.quantity]);
		$('#quantity-accordion .customQty').val('').attr('checked', false);
		$('#quantity-accordion #customQty').val('');
		if(plannerEvent.quantity && $('#quantity-accordion form input:checked').size() === 0){
			$('#quantity-accordion .customQty').val(plannerEvent.quantity);
			$('#quantity-accordion #customQty').val(plannerEvent.quantity).attr('checked', true);
		}
		$('.customQty').forceQuantity();
		
	if(	plannerEvent.className.indexOf('directmail')==0) {
		if(isQuantityHeader == false){
			var html ='<h3 id="quantity-header" class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all">'+quantityHeaderHtml+'</h3>'
			+'<div id="quantity-accordion" style="display: none;">'
				+ quantityAccordionHtml
			+'</div>'	
			
			+'<h3 id="zipcodes-header" class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all">'+zipcodesHeaderHtml+'</h3>'
			+'<div id="zipcodes-accordion" style="display: none;">'
				+ zipcodesAccordionHtml
			+'</div>';		
			$('#deadline-accordion').after(html);
			isQuantityHeader = true;
		}
		if($('#zipcodes-form').length > 0){
			$('#zipcodes-form').html('');
			if(plannerEvent['office.id'])
				addDynamicCommonListBox($('#zipcodes-form'), 'zipcodes', offices['id=' + plannerEvent['office.id']].zipcodes, plannerEvent);
			$(".listselect").listselect({listTitle:'Available >>', selectedTitle:'<< Selected', size:15});
		}
	}else if(isQuantityHeader && plannerEvent.className.indexOf('directmail')!=0){
		$('#quantity-accordion').remove();
		$('#zipcodes-accordion').remove();
		$('#quantity-header').remove();
		$('#zipcodes-header').remove();
		isQuantityHeader = false;
	}

	if(	plannerEvent.className.indexOf('event')==0 && isColorHeader){
		$('#color-accordion').remove();
		$('#color-header').remove();
		isColorHeader = false
	}else {
		if(isColorHeader == false){
			var html ='<h3 id="color-header">'+colorHeaderHtml+'</h3>'
			+'<div id="color-accordion">'
				+ colorAccordionHtml
			+'</div>';		
			$('#size-accordion').after(html);
			isColorHeader = true;
		}
		$('#color-accordion form input[name="color"]', accordion)	.attr('checked', false);
		$('#color-accordion form input[value="'+plannerEvent.color+'"]', accordion).attr('checked', true);
	    $('#color-message', accordion).attr('style', 'display:none');
	} 
	var iter =2;
	for(var i=0; i<iter; i++){  //issue with jquer accordion after select from archive
		if(accordion != null) {
			plannerArchiveCtrl.destroySelectAdUploader();		
			accordion.accordion('destroy');
			accordion = null;   	
		}
	    accordion = $("#accordion").accordion({
	    	active: false, 
	    	autoHeight: false,
	    	collapsible:true,
	    	change: function(event, ui) { 
	    				$('#send-accordion').hide();
	    				var selected =  $( "#accordion h3.ui-corner-top" );
	        			selected.removeClass( "ui-state-active" );
	        			selected.addClass( "ui-state-default");
						accordionContent = ui.newContent .attr('id');
						accordionHeader = ui.newHeader;
						if( ui.oldContent != undefined ) {
							if(	ui.oldContent.attr('id') != undefined)
								$('#'+ui.oldContent.attr('id').split('-')[0]+'-message', accordion).hide();
							if(ui.oldContent.attr('id') == 'selectAdFrom-accordion') {
								plannerArchiveCtrl.destroySelectAdUploader();
							}
						}
	       				if('selectAdFrom-accordion' == accordionContent) {
	       					plannerArchiveCtrl.initAdSelector(plannerEvent);
	        			}else if('send-accordion' == accordionContent) {
	        				$('#accordion').accordion('activate', -1);
	        				if((plannerEvent['publication.id'] || plannerEvent['vendor.id']))
	        					sendToVendorDiag(undefined, gPlannerDetailEntries['id='+plannerEvent.id]);
	        				else
	        					$('#accordion').accordion('activate', $('#vendors-header'));	
	        					
	        					
	        			}        			
	    	   		}
	    });
	}
	$('#send-header').unbind('click');
}
/*
function destroySelectAdUploader(uploader) {
	if(uploader == undefined)
		return;
	uploader.destroy();
	uploader = undefined;
	$('#container div.plupload').remove();
	$('#filelist').html('');
}

var uploader;
function initAdSelector(event) {
	 uploader = new plupload.Uploader({
		runtimes : 'html5,flash,silverlight',
		browse_button : 'pickfiles',
		container : 'container',
		max_file_size : '15mb',
		url : ctrl + '/uploadAdImage/' + event.id,
		flash_swf_url : '/plupload156/js/plupload.flash.swf',
		silverlight_xap_url : '/plupload156/js/plupload.silverlight.xap',
		filters : [
			{title : "Image file", extensions : "jpeg,jpg,gif,png"},
			{title : "PDF file", extensions : "pdf"}
		],
		jpgresize: false,
		pngresize: false
	});

	uploader.bind('Init', function(up, params) {
	});

	uploader.init();

	uploader.bind('FilesAdded', function(up, files) {
		$.each(files, function(i, file) {
			$('#filelist').html(
				'<div id="' + file.id + '">' +
				file.name + ' (' + plupload.formatSize(file.size) + ') <b></b>' +
			'</div>');
		});

		up.refresh(); // Reposition Flash/Silverlight
		uploader.start();
	});

	uploader.bind('UploadProgress', function(up, file) {
		$('#' + file.id + " b").html(file.percent + "%");
	});

	uploader.bind('Error', function(up, err) {
		$('#filelist').append("<div>Error: " + err.message +
			"</div>"
		);

		up.refresh(); // Reposition Flash/Silverlight
	});

	uploader.bind('FileUploaded', function(up, file) {
		$('#adImage').html("");
		$('#' + file.id + " b").html("100%");
		var time = (new Date()).getTime();
		var entryContainer = gPlannerDetailEntries;
		if(ctrl == "/myTracker" )
			entryContainer = gCompetitorAdDetailEntries;
		destroySelectAdUploader(uploader);
		entryContainer['id='+selectedPlannerEntry.id].portfolioEntry = null; //detail only
		var ext = file.name.split(".");
		ext = ext[ext.length-1].toLowerCase();
		if(ext == "jpg" || ext=="jpeg" || ext=="gif" || ext=="png") {
			entryContainer['id='+selectedPlannerEntry.id].imageFile = time;
			updateSummary(selectedPlannerEntry);
			if(! entryContainer['id='+selectedPlannerEntry.id].pdfFile) {
				console.info('ask for pdf upload');
				plannerArchiveCtrl .uploadAnotherDiag();
			}	else
				$('#accordion').accordion('activate', -1);
		}else{
			if(! entryContainer['id='+selectedPlannerEntry.id].imageFile){
				console.info('display pdf logo')
				console.info('ask for image upload')			
			} else
				$('#accordion').accordion('activate', -1);
		}
	});	
}
*/
function saveForm(formId, formMsgDiv) {
	var saved, id = selectedPlannerEntry.id;
	var key = 'id='+id;
	var uri = ctrl + "/updateDetail4UserSimple/"+ id;
	var data = itdaPostJson(uri, $(formId).serialize());
	
	if(data.respText == 'Save completed.') {
		saved = true;	
		if(data.entry) {
			data.entry.start = $.fullCalendar.parseDate(data.entry.start);
			if(data.entry.deadline)
				data.entry.deadline = $.fullCalendar.parseDate(data.entry.deadline);
			gPlannerDetailEntries[key] = $.extend(gPlannerDetailEntries[key],data.entry);	
			if(gPlannerEntries[key])
				gPlannerEntries[key] = gPlannerDetailEntries[key];
			//add to main cal
		} else {//repeat ad
			for(var i=0; i < data.entries.length; i++) {
				if(data.entries[i].deadline)
					data.entries[i].deadline = 
					$.fullCalendar.parseDate(data.entries[i].deadline); 
				addToDetailCal(data.entries[i]);
				key = 'id='+data.entries[i].id;
			}
		}
	}
	if(saved){
		selectedPlannerEntry = gPlannerDetailEntries[key];
		$('#accordion').accordion('activate', -1);
		updateSummary(selectedPlannerEntry);
		if(formId == '#offices-form'){
			addDynamicCommonListBox($('#zipcodes-form').html(''), 'zipcodes', offices['id=' + selectedPlannerEntry['office.id']].zipcodes, selectedPlannerEntry);
			$(".listselect").listselect({listTitle:'Available >>', selectedTitle:'<< Selected', size:15});
		}
			
		return true;
	}else
		return false;	
}

function initRepeatAdCal(){
	$("#repeatad-calendar").datepicker('destroy').datepicker(
   	        {
   	        		prevText: '',nextText: '',
   	        		collapsible:true,
   	        		dateFormat: 'yy/mm/dd'
			        ,dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
					, gotoCurrent: true 
					,onSelect: function(dateText, inst) {
   	        			if($('#repeatad-form input[value="'+dateText+'"]').length == 0){
   	        				$('#repeatad-form').append('<input type="hidden" name="repeatDates" value="'+dateText+'"/>');
   	        			}else{
   	        				$('#repeatad-form input[value="'+dateText+'"]').remove();
   	        			}
   	        			$('div.ui-datepicker-inline table.ui-datepicker-calendar tbody tr td.planner-state-active', this).removeClass('planner-state-active');
   	        		}
	        		
   	        		,beforeShowDay: function(date) { 
   	        			var classname = '';
   	        			var key = $.fullCalendar.formatDate( date, 'yyyy/MM/dd');
   	        			if($('#repeatad-form input[value="'+key+'"]').length == 1) 
   	        			{
   	        				classname = 'planner-state-active';
   	        			}
   	        			return [true,classname, ''];
   	        		}
	        }
   	 	);
}

function initDeadlineCal(){
	$("#deadline-calendar").datepicker('destroy').datepicker(
   	        {
		    	    altFormat: 'yyyymmdd',
		    	    collapsible:true
			        ,dayNamesMin: ['S', 'M', 'T', 'W', 'T', 'F', 'S']
					, gotoCurrent: true 
					,onSelect: function(dateText, inst) {
						deadlineDate = $.datepicker.parseDate('mm/dd/yy', dateText);
						$('#deadline-form input[name="deadline_year"]').val( deadlineDate.getFullYear());
						$('#deadline-form input[name="deadline_month"]').val(deadlineDate.getMonth() + 1);
						$('#deadline-form input[name="deadline_day"]').val(deadlineDate.getDate());
						}
	    	        }
   	 	);	
	if(selectedPlannerEntry.deadline != null){
		$('#deadline-calendar').datepicker('setDate',selectedPlannerEntry.deadline); 
		$('#deadline-form input[name="deadline_year"]').val( selectedPlannerEntry.deadline.getFullYear());
		$('#deadline-form input[name="deadline_month"]').val(selectedPlannerEntry.deadline.getMonth() + 1);
		$('#deadline-form input[name="deadline_day"]').val(selectedPlannerEntry.deadline.getDate());
		
	}else {
		$('#deadline-calendar').datepicker('setDate',selectedPlannerEntry.start); 			
		if(selectedPlannerEntry.className.indexOf('direct')==0)
			$('div#deadline-calendar.sm-event-cal div.ui-datepicker-inline div.ui-datepicker-header a.ui-datepicker-prev').click(); 
		$('#deadline-calendar').datepicker('setDate',null); 			
		//$('#deadline-calendar  div.ui-datepicker-inline table.ui-datepicker-calendar tbody tr td a.ui-state-active')
		//.removeClass('ui-state-active')
	}
		
}

function formatColorText(color){
	if(color)
		return color + 'c';
	return '--'
}

function displayResultColum(result, plannerDate, col, row) {
    var alignClass = 'result-left', html, image ="", text;
	if(col == 1) alignClass = 'center';
	else if (col == 2) 	alignClass = 'result-right';

	var date = $.datepicker.parseDate('yy-mm-dd', result.portfolioDate.substring(0,11));
	var view = document.forms['filter-form'].viewFilter.value.toLowerCase().replace(' ', '-');

	if(result)
		image = "<img src='"+getJpgUrl(result.id, undefined, result.color)+"' style='max-height:100%;max-width:100%' class='center' onload='showImage(this)' id='small-image-"+result.id+"'/>";
	var sizeText = getSizeText(result.adSizeCode, result.otherSize);
	sizeText = sizeText.replace(/vertical/gi, "V").replace(/horizontal/gi, "H").replace(/Standard/gi, "").replace(/Invitation Mailer/gi, "Invitation");
	if(sizeText.length > 14)
		sizeText = sizeText.substring(0, 14);
	html =  "<td width='33%'>"+
	  	"<div id='"+ result.id +"' class='result-container result-image " + alignClass + "'>" +
	  		"<div class='result-image-container'>"+
	    	 		image +
	    	"</div>"+
				"<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>"+
	  		"<div class='result-text-container center'>"+
	  		'<b>' + getEventType(result.adTypeCode) + ' </b><span style="color:#B69A2F">|</span> ' + sizeText  + ' <span style="color:#B69A2F">|</span> '+formatColorText(result.color) +'<br/>'+$.datepicker.formatDate('M&nbsp;yy', date) + '&nbsp;<span style="color:#B69A2F">|</span>&nbsp;' + getFileName(result, getColorNum(result.color))
	  		+getDetailLinks4Result(result); 
	
	    	if($(document).data('ctrl')== undefined)//todo: fix me 
	    		html += "<div class='"+ view +" result-banner'>";//archive
	    	else if(view == 'highest-rated')
	    		html += "<div style='top:-311px;left:-5px;width:136px' class='"+ view +" result-banner'>";//adstore
	    	else
	    		html += "<div style='top:-311px;left:-5px;width:191px' class='"+ view +" result-banner'>";//adstore
	    	
	  	    if(view == 'most-downloaded')
	  	        html +="<div class='itda-archive-icon download-green-icon' style='float:left'></div><div id='banner-text'>" + result.download + " Download"+(result.download == 1 ? "" : "s")+"</div>";
	  	    else if(view == 'highest-rated')
	  	    	html += getRatingInfo(result).html;
	  	    else if(view == 'previously-run')
	  		     html +="<div class='itda-archive-icon prev-run-orange-icon' style='float:left'></div><div id='banner-text'>&nbsp;&nbsp;" + $.fullCalendar.formatDate($.fullCalendar.parseDate(plannerDate),'dddd MMM dd, yyyy') + "</div>";
	  	   // else if(view == 'favorites')
	  		//     html +="<div class='itda-archive-icon favorite-pink-icon' style='float:left'></div><div id='banner-text"+result.id
	  		//     +"'><span style='float:left;position:relative;bottom:-3px'>&nbsp;&nbsp;<b>FAVORITE</b></span><input onclick='removeFavorite(event,\""+result.id+"\")' class='planner-icon x-icon-red' style='float:right;position:relative;bottom:1px;right:-4px' type='submit' value=''/></div>";
	  	    else if(view == 'scheduled')
	  		     html +="<div class='itda-archive-icon schedule-blue-icon' style='float:left'></div><div id='banner-text'>&nbsp;&nbsp;" + $.fullCalendar.formatDate($.fullCalendar.parseDate(plannerDate),'dddd MMM dd, yyyy') + "</div>";
	  	    else if(view == 'my-uploads' || (view =='all' && result.myUploads)){
	  		     html +="<div id='banner-text"+result.id
	  		     +"'><input onclick='archCtrl.removeUploadedHdFile(event,"+result.id+", this)' class='planner-icon x-icon-red' style='float:right;position:relative;bottom:1px;right:-4px' type='submit' value=''/></div>";
	  	    }
		    
		    html +="</div>";
	    html += "</div>"+
	  "</td>";
	  return html;
}
(function ($) {
    $.fn.forceQuantity = function () {
        return this.each(function () {
            $(this).keyup(function() {
            	var val = $(this).val();
            	if (!/^[0-9]+$/.test(val)) {
            		val = val.replace(/[^0-9]/g, '');
                    $(this).val(val);
                }
            	var clName = $(this).attr('class');
            	$('#'+clName).val(val);
            });

        });
    };
})(jQuery);
