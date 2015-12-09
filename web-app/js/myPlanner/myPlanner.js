var ctrl = '/myPlanner';
var calUtil, detailCalUtil;
var plannerArchiveCtrl = new PlannerArchiveController('plannerArchiveCtrl');
function sendToVendor(send){
 	var id = $("#sendForm input[name='id']").val();
	var entry = gPlannerDetailEntries['id='+id];
	if(entry) {
		if(!send && (!entry.color || !entry.portfolioEntry) && !entry.imageFile) {
	        	var html = '<br/>Do you wish to send<br/>this email without a file?'
	        	+ '<br/><br/><div><img src="/images/Transparent.gif" class="planner-icon ok-btn-orange" style="float:right;margin-left:20px" onclick="saveSendToVendorInfo(true);gdiaglogSmall.dialog(\'close\')"></img><img src="/images/Transparent.gif" style="float:right" class="tracker-icon tracker-cancel-gray-btn" onclick="gdiaglogSmall.dialog(\'close\')"></img></div>'
	    		+'<div style="height:10px"/>';
	        	showItdaConfirmDialog(html, gdiaglogSmall, '280');
		}else
			saveSendToVendorInfo(true);
	}
}

function saveSendToVendorInfo(send){
	var saved;
	var uri = '/myPlanner/saveSendToVendorInfo?send='+(send ? true : false);
	var data = itdaPostJson(uri, $("#sendForm").serialize());
	if(data.respText == 'Save completed.') {
		saved = true;
		if(send)
			$.jGrowl('Your email has been sent.');
		if(gPlannerDetailEntries['id='+data.entry.id])
			gPlannerDetailEntries['id='+data.entry.id] =$.extend(gPlannerDetailEntries['id='+data.entry.id],data.entry);
		if(gPlannerEntries['id='+data.entry.id])
			gPlannerEntries['id='+data.entry.id] = gPlannerDetailEntries['id='+data.entry.id];
	}			
	if(saved){
		closeDialog("dialog-send-to-vendor");
		return true;
	}else
		return false;
}
function saveDeadline() {
	var date = $("#deadline-calendar").datepicker('getDate');
	if(date) {
		$("#deadline-form input[name='deadline_year']").val(date.getUTCFullYear());
		$("#deadline-form input[name='deadline_month']").val(date.getMonth());
		$("#deadline-form input[name='deadline_day']").val(date.getDate());
	}	
	//saveForm('#deadline-form', '#deadline-message');
}
function addTodo(){
	var id = document.forms['add-todo-form'].id.value;
	var uri = '/myPlanner/addTodo';
	if(processTodos(id, uri, $("#add-todo-form").serialize()))
		document.forms['add-todo-form'].title.value	= '';
	return false;
}

function saveTodos() {
	var id =document.forms['add-todo-form'].id.value;
	var uri = '/myPlanner/saveTodos/' + id;;
	processTodos(id, uri, $("#todos-form").serialize());
	return false;
}

function deleteTodo(id){
	var uri = '/myPlanner/deleteTodo';
	var data = {entryId: document.forms['add-todo-form'].id.value, id: id};
	processTodos(document.forms['add-todo-form'].id.value, uri, data);
	return false;
}

function processTodos(id, url, input) {
	var saved = false, key = 'id='+id;
	var data = itdaPostJson(url, input);
	if(data.respText == 'Save completed.') {
		saved = true;
		gPlannerDetailEntries[key].todos = data.todos ? data.todos : [];
		if(gPlannerEntries[key])
			gPlannerEntries[key] = gPlannerDetailEntries[key];
		selectedPlannerEntry = gPlannerDetailEntries[key];
		$('#todosList').html('');
		addDynamicEventTodos($('#todosList'), 'todos', gPlannerDetailEntries[key].todos);					
		updateSummary(selectedPlannerEntry);			
	}
	return saved;		
}

function sendToVendorOnChange(e) {
	 var input = e.data.input;
	 var name = input.attr('name');
	 name = "change" + name.slice(0,1).toUpperCase() + name.slice(1)+"Flag";
     $("input[name='"+name+"']").attr("checked", true);
	return true;
}

function sendToVendorDiag(evt, entry){
	
	disableEventPropagation(evt);
	//entry = gPlannerEntries['id='+entry.id];//refresh 
	var entryStvDetail = itdaPostJson("/myPlanner/getSendToVendorDetail", {id:entry.id});
	entry = $.extend(entry,entryStvDetail.entry);
	var diag = $('#dialog-send-to-vendor').dialog('open');
	diag.prev().remove();//css('background-color', 'white');	
	diag.parent().css('background-color', 'white').removeClass('ui-corner-all');
	diag.parent().css('border-color', '#B69A2F');	
	var vendors = getVendors(entry.className);
	//$('#vendor', diag).html('');
	$('tr', diag).hide();
	$('tr.' +entry.className, diag).show();	
	$('input', diag).val('');
	//$('input:checkbox', diag).removeAttr('checked');

	$('input#id', diag).val(entry.id);
	$('textarea[name="zipcodesDisplay"]', diag).val(entry.zipcodes ? entry.zipcodes: null);
	$('textarea[name="notes"]', diag).val(entry.notes ? entry.notes: entry.vendorNotes);
	$('textarea[name="otherChanges"]', diag).val(entry.otherChanges ? entry.otherChanges: null);
	$('textarea[name="zipcodes"]', diag).val(entry.otherChanges ? entry.otherChanges: null);
	$.each($('input', diag), function(i, input){
		input = $(input);
		var key = input.attr('name');
		if(input.attr('type') == 'text'){
			input.val(entry[key] ? entry[key] : '');
			$(input).bind('keydown', {input:input}, sendToVendorOnChange);
		}else if(input.attr('type') == 'checkbox')
			input.attr('checked', entry[key] == "true" ? true : false).val(true);
			
	});	
	var vendorField = getVendorFieldName(entry.className);
	$("input[name='vendorDisplayName']", diag).val(vendors['id='+entry[vendorField]].name);
	$("input[name='"+vendorField+"']", diag).val(entry[vendorField]);
	$("input[name='toEmail']", diag).val(entry.toEmail ? entry.toEmail : vendors['id='+entry[vendorField]].email);
	$("input[name='cc']", diag).val(entry.cc ? entry.cc : '');
	$("input[name='quantityDisplay']", diag).val(entry.quantity ? entry.quantity : '');
	var subject = entry.subject ? entry.subject : undefined;
	var date = $.fullCalendar.formatDate($.fullCalendar.parseDate(entry.start),'MMMM dS, yyyy')
	var ad = getEventType(entry.className);
	if(subject == undefined){
		if(ad == 'Newspaper')
			ad += ' Ad'
		subject = gBusiness  + ' ' + ad + ' for ' + date;
	}
	$("input[name='subject']", diag).val(subject);
	if((!entry.color || !entry.portfolioEntry) && !entry.imageFile) {
		ad = getEventType(entry.className);
		if(ad == 'Newspaper') ad += ' ad';
		else if(ad == 'Direct Mail') ad += ' piece';
		$('#adImage', diag).html('You have not<br/>yet selected a<br/>'+ad+'.<br/><br/>');
	} else if(entry.portfolioEntry)
		$('#adImage', diag).html("<img src='"+getJpgUrl(entry.portfolioEntry.id, false, entry.color)+"' style='max-height: 250px; max-width: 170px'/>");
	else
		$('#adImage', diag).html("<img src='/myPlanner/getImageFile/"+ entry.id + "?token=" +(new Date()).getTime()+"'  style='max-height: 250px; max-width: 170px'/>");
	
}	
	$(document).ready(function() {
		$('#footer a').removeClass('gold');
		$('#footer a.myPlanner').addClass('gold');		
		gdiaglogSmall = $('#dialog-small').dialog({modal: true,  height: 'auto', width: 350, maxWidth: 350, resizable: false , autoOpen : false});
		gdialogSendVendor = $('#dialog-send-to-vendor').dialog({modal: true,  height: 'auto', width:'auto', resizable: false , autoOpen : false});
		$('#dialogAdImage').dialog({modal: true,  height: 'auto', width:'auto', resizable: false , autoOpen : false});
		$(document).unbind('click').bind('click',  function() {
			$('#dialogAdImage').dialog('close');
		});
	    
		//* initialize the advertise events
		//-----------------------------------------------------------------/
		$('#advertise-events div.advertise-event').each(function() {
			var eventObject = {
				className: $.trim($(this).attr('id')) // use the element's text as the event title
				 ,image: getSmallIcon($.trim($(this).attr('id')))
				,title: getEventTypeTitle($.trim($(this).attr('id')))
			};
			
			// store the Event Object in the DOM element so we can get to it later
			$(this).data('eventObject', eventObject);
			
			// make the event draggable using jQuery UI
			$(this).draggable({
				zIndex: 999,
				revert: true,      // will cause the event to go back to its
				revertDuration: 0  //  original position after the drag
			});
			
		});
	
	
		// initialize the calendar
		//-----------------------------------------------------------------
		var fullcal = 
		$('#calendar').fullCalendar({
			 height: 661,				
			header: {
				left: '',
				center: 'prev title next',
				right: ''
			},
            events: $.fullCalendar.plannerCalFeed('/myPlanner/listJson4User'),
			eventClick: function(event) {
				initPlannerEventDetail(event.id, event.start);
				return false;
			},
			dayClick: function(date, allDay, jsEvent, view) {
				if(console && console.info)
				console.info('dayClick event handler ' + date);	
				$('div.fc-content td.fc-state-highlight').removeClass('fc-state-highlight');
				$(this).addClass('fc-state-highlight');
				var dateStr = $.fullCalendar.formatDate( date, 'yyyyMMdd');
				var scrollPanel = $('#scrollpanel');
				$('div.plannerCalSelect', scrollPanel).removeClass('plannerCalSelect');
				var content = $('div#' + dateStr, scrollPanel);
				var position = content.position();
				if(position != null) {
					content.addClass('plannerCalSelect');
					var parent = $('#scrollpanel');
						parent.scrollTop(parent.scrollTop() + position.top);
				}				
				return false;
			},	
			weekMode: 'fixed',
			editable: true,
			droppable: true, // this allows things to be dropped onto the calendar !!!
			drop: function(date, allDay) { // this function is called when something is dropped

				// retrieve the dropped element's stored Event Object
				var originalEventObject = $(this).data('eventObject');
				if ( !originalEventObject )
					return; //jquery bug?
				var input = {  start: 'date.struct'
					 , start_year: date.getFullYear()
					 , start_month: (date.getMonth() + 1)
					 , start_day: date.getDate()
					 , 'className': originalEventObject.className
			 		 , title: originalEventObject.title };
				var newEvent = itdaPostJson("/myPlanner/createJson4User", input);
				showPlannerEventDetailCallback (newEvent);	
				var serverEvent = newEvent;
				serverEvent.image = originalEventObject.image;
				//var comboEvent = $.extend(originalEventObject,serverEvent);
				//comboEvent.source = undefined;
				gPlannerEntries['id=' + serverEvent.id] = serverEvent;
				$('#calendar').fullCalendar('renderEvent', serverEvent, true);
			},
			loading: function(isLoading, view) {
				var fn = $(this).data("loading");
				if (fn)
					fn(isLoading, $(this).fullCalendar('getView'));
			}
		});		

		if($.browser.webkit)
		  $('#calendar tbody.cal-content-number').css('border-right-width', '2px');//safari
		else //mozilla and IE
		  $('tbody.cal-content-number tr td.fc-leftmost.fc-state-default').css('border-left-width', '2px'); 

		$('.fc-header-right').html('<a onclick="gotoPlannerDetailView(gPlannerEntries);" href="javascript:void(0)"><span style="position:relative; top:12px; float:right;color:rgb(85, 85, 85);font-size:11px"><img style="float: left;" class="tracker-icon tracker-detail-view-icon" src="/images/Transparent.gif"/><span <span style="position:relative; top:2px">&nbsp;Details&nbsp;View</span></span></a>');
		
    	if($.cookie('plannerPopup') == '1') {
        	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closePlannerDialogs()"></span><br/>';
        	html += '<h3>Planning your marketing is easy!<br/></h3>';
        	html += 'Just drag and drop the icon for the type of<br/>';
        	html += 'marketing you wish to run on any date. You<br/>';
        	html += 'can even add multiple types of marketing on<br/>';
        	html += 'a single date.<br/><br/>';
        	html += 'Clicking on an icon in the calendar will let<br/>';
        	html += 'you add specific details.';
        	html += '<img class="planner-icon x-icon-red" src="/images/Transparent.gif" style="position:relative;top:18px;left:153px"/>'
        	html += '<b>Note:</b> Clicking on a &nbsp;&nbsp; icon will delete a marketing entry along with any details you<br/>have previously entered.';
        	showItdaConfirmDialog(html, gdiaglogSmall, '400');
    		$.cookie('plannerPopup', null, { expires: 0, path: '/myPlanner'});
    		$.getJSON('/myAccount/updateSettings?plannerPopup=1', {}, function(data) {});
    	}
    	
    	calUtil =  new FullCalUtil('calUtil', fullcal); 
    	calUtil.setYearSelect($("#date_year"));
    	calUtil.setMonthSelect($("#date_month"), true);

	});

	function showPlannerEventDetailCallback(data, status, xhr) {
		showPlannerEventDetail(data, undefined, 'div.planner-detail-content.entry-list');
	}

	function selectAdForPlannerEvent(id, date) {
		initPlannerEventDetail(id, date);
		$('#accordion').accordion('activate', $('#selectad-header-text').parent());	
		
	}
	
	function initPlannerEventDetail(id, date) {
		if(!sizeAccordionHtml){
			 sizeAccordionHtml = $('#size-accordion').html();
			 sizeHeaderHtml = $('#size-header').html();
			 colorAccordionHtml = $('#color-accordion').html();
			 colorHeaderHtml = $('#color-header').html();
			 quantityAccordionHtml = $('#quantity-accordion').html();
			 quantityHeaderHtml = $('#quantity-header').html(); 
			 zipcodesAccordionHtml =$('#zipcodes-accordion').html();
			 zipcodesHeaderHtml	= $('#zipcodes-header').html();	
		} 
		swapPlannerCalView();
		$('#detail-view').hide();
		initSmallFullCal('/myPlanner', date);
    	var detailcal = $('#pdtl-calendar').data("theCalendar");
    	detailCalUtil =  new FullCalUtil('detailCalUtil', detailcal); 
    	detailCalUtil.setYearSelect($("#detailDate_year"));
    	detailCalUtil.setMonthSelect($("#detailDate_month"));
		selectedDate = date;
		init();	
	    displayWorkingDate(date, false, gPlannerDetailEntries, id);

	    var par = $(".tracker-icon.tracker-tips").parent(), clickHtm = par.html();
	    var ad = getEventTypeCode(gPlannerDetailEntries['id='+id].className);
		clickHtm = clickHtm.replace('tips-main.gsp', 'tips-detail-'+ad+'.gsp'); 
		par.html(clickHtm);

    	if($.cookie('plannerDetailPopup') == '1') {
        	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closePlannerDialogs()"></span><br/>';
        	html += '<h3>Add the details...<br/></h3>';
        	html += 'Click on the buttons to your left to<br/>';
        	html += 'make your choices. When you\'re<br/>';
        	html += 'done, click SAVE.<br/><br/>';
        	html += 'To add details for a new date,<br/>';
        	html += 'click on the calendar, or use<br/>';
        	html += 'the arrows below.';
        	showItdaConfirmDialog(html, gdiaglogSmall, 330);
    		$.cookie('plannerDetailPopup', null, { expires: 0, path: '/myPlanner'});
    		$.getJSON('/myAccount/updateSettings?plannerDetailPopup=1', {}, function(data) {});
    	}		
	}

	function swapPlannerCalView(id) {
		var entry = (id == null || id == 'detail') ? $(".tracker-icon.tracker-tips").parent().data('entry') : null;
		if(id == null)
			id = 'detail';
		updateCtxSensitiveTips(entry);
		$('.plannerContent').hide();
		$("#gPlannerDiag").hide()
		$('#'+id+'.plannerContent, #tipsplanner, #planner-reports').show();
		 $('form input[type="radio"]').css('border-width', "0");
	}

function closePlannerDialogs(){
	$('#dialog-small').dialog('close');
	$('#dialog-send-to-vendor').dialog('close');		
}

function getDetailLinks4Result(result){
	var plannerId = $(eventSelectBox).val();
	var html = "<div id='result-hover-"+result.id +"' style='margin:3px 0px 0px 0px; color:#0076A3; height:5px'>&nbsp;</div>"+
    "<table class='center'><tr>";
    html +="<td style='padding:0px'><span onclick='selectPortfolioEntry("+result.id+","+plannerId+");' class='planner-detail-link-red'><b>Select</b></span> "+
    	'<span style="color:#B69A2F">|</span>' +
    	" <span class='planner-detail-link-blue' onclick='toggleDetail("+result.id+","+result.color+" )'><b>View Details</b></span></td>"+
    "<tr></table>"+
	"</div>";
	return html;
}

function saveRepeatDates(formId, msgElem){
	saveForm(formId, msgElem);
	$('#repeatad-calendar div.ui-datepicker-inline table.ui-datepicker-calendar tbody tr td.planner-state-active').removeClass('planner-state-active');
	$('#repeatad-form input').remove();
}
function gotoPlannerDetailView(events){
	
	if(!gSmlFc) {
			var sortedEvents = toNonAssoArr(events);
			if(sortedEvents.length == 0){
				initPlannerEventDetail(undefined, $('#calendar').fullCalendar( 'getDate' ));
			}else{
				sortedEvents = sortArray(sortedEvents);
				initPlannerEventDetail(sortedEvents[0].id, sortedEvents[0].start);
			}
			return;
	}else
		swapPlannerCalView('detail');	
	$('#detail-view').hide();
	$('#planner-reports').css('top', '18px');
} 
function gotoPlannerCalView(){
	$('#accordion').accordion('activate', -1);	
	swapPlannerCalView('wrap');
	$('#detail-view').show();
	//$('#planner-reports').css('top', '20px');
	var addedEvents = $(gSmlFc).data('itdaNewEvents');
	for(var key in addedEvents) {//TODO change the event date in calendar month 
		$('#calendar').fullCalendar('renderEvent', addedEvents[key], true);
//		showPlannerEventDetailCallback(addedEvents[key]);
		gPlannerEntries[key] = addedEvents[key];
	}
	var deletedEvents = $(gSmlFc).data('itdaDeletedEvents');
	if(deletedEvents)
		for(var i=0; i<deletedEvents.length; i++) {
			$('#calendar').fullCalendar( 'removeEvents', deletedEvents[i] );
			delete gPlannerEntries['id=' + deletedEvents[i]];
		}

	$('div.planner-detail-content.entry-list').html('');
	for(var key in gPlannerEntries) {
		showPlannerEventDetailCallback(gPlannerEntries[key]);
	}
	
	$(gSmlFc).data('itdaNewEvents', []);
	$(gSmlFc).data('itdaDeletedEvents', undefined);	
}

function updateCtxSensitiveTips(entry){
	//Planner
    var par = $(".tracker-icon.tracker-tips").parent(), clickHtm = par.html();
    if(entry){
    	var ad = getEventTypeCode(entry.className);
    	clickHtm = clickHtm.replace(/tips-main.gsp/i, 'tips-detail-'+ad+'.gsp');
    	clickHtm = clickHtm.replace(/tips-detail-.*.gsp/i, 'tips-detail-'+ad+'.gsp');
    	par.data('entry', entry);
    }else {
    	clickHtm = clickHtm.replace(/tips-detail-.*.gsp/i, 'tips-main.gsp');
    }
	par.html(clickHtm);
	$(gTipsDiag).dialog('destroy');
	gTipsDiag  = undefined;
}