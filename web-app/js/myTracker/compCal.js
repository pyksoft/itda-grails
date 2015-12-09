var gTrackercal; 
var ctrl = '/myTracker';
var calUtil, detailCalUtil, expenseCalUtil, resultCalUtil, saleCalUtil;
var plannerArchiveCtrl = new TrackerController('plannerArchiveCtrl');
function reviewPolicy(event){
	disableEventPropagation(event);
	var target = $("#dialog-review-policy");
	target.prev().css('background-color', 'white');	
	$('a.ui-dialog-titlebar-close span.ui-icon', target.prev()).attr('style', 'background-image:url(/images/itd/tracker/tracker_051211.png); background-position:-253px -131px; height:12px;width:13px; margin:0px');
	target.parent().css('background-color', 'white');
	target.dialog("open");
}

function trackerEventChanges(selectBox){
	 var selectedEntry = selectBox[selectBox.selectedIndex].value;
	 updateAccordion(gCompetitorAdDetailEntries['id='+selectedEntry]);
	 $('#accordion').accordion('activate', -1);
	 return false;
} 
	
function resetTab123() {
	selectingElementId= '#expense-detail-content';
	$('div#tabs-1 input').attr('value', '').attr('readonly', 'readonly');
	$('#totalExpense').html('').attr('readonly','readonly');
	$(selectingElementId+'-expense-title').html('&nbsp;Expenses');
	$('div[id$="-planner-detail-title"]').css('background-color', '');
	$('div[id$="-planner-detail-info"]').css('background-color', '');	
	$(selectingElementId +'-selectedAdInfo').html('');
	$(selectingElementId +'selectedAdDate').html('');
	$(selectingElementId +'-selectedAd').html('');

	selectingElementId= '#sale-detail-content';
	$('div#tabs-2 input').attr('value', '').attr('readonly', 'readonly');
	$('#totalSales').html('').attr('readonly','readonly');	
	$(selectingElementId+'-sale-title').html('&nbsp;Sales');
	$(selectingElementId +'-selectedAdInfo').html('');
	$(selectingElementId +'selectedAdDate').html('');
	$(selectingElementId +'-selectedAd').html('');

	selectingElementId= '#result-detail-content';		
	$(selectingElementId+'-sale-title').html('&nbsp;Results');
	$(selectingElementId +'-selectedAdInfo').html('');
	$(selectingElementId +'selectedAdDate').html('');
	$(selectingElementId +'-selectedAd').html('');
	resetTab3();
	$('.default-tracker-msg').show();	
}

function resetTab3(enableForm) {
	
	var tab4 = $('#tabs-3');
	if(enableForm)
		$("input:submit", tab4).removeAttr("disabled");
	$('input:[type="text"]', tab4).val(''); 
	$('input:[onclick^="return"]', tab4).removeClass('tracker-1-star-icon tracker-1-2-star-icon').addClass('tracker-0-star-icon');
	$('div.tracker-icon.center', tab4).addClass('tracker-check-icon');
	$('input:[name^="publish"]', tab4).val('true');
	$('input:[name="rating"]', tab4).val('0');
	$("input:radio", tab4).removeAttr("checked");
	$("textarea", tab4).val("");
}

function calculateResults(evt, element){
	if(evt)
		disableEventPropagation(evt);;		
	var tab4 = $('#tabs-3');
	$('input[name="costPerLead"]', tab4).val('');
	$('input[name="costPerSale"]', tab4).val('');
	$('input[name="returnOnInvest"]', tab4).val('');
	if(calculateROI())
		calculateCplAndCps();
	element.blur();
}
function calculateROI() {
	var tab4 = $('#tabs-3');
	var expenses = $('input[name="totalExpense"]', tab4).val().replace(/[^0-9\.]/g, '');
	var sales = $('input[name="grossSales"]', tab4).val().replace(/[^0-9\.]/g, '');
	if(expenses == '' || sales == '' || expenses == 0.0) {
		var gotoTab;
		if (sales == '')
			gotoTab = 'gotoTab(1, '+gSelectedId+');';
		else
			gotoTab = 'gotoTab(0, '+gSelectedId+');';
		var html = '<h3>Sorry...</h3>There is not enough information to calculate Return-On-Investment.<br/><br/>Click <a onclick="'+gotoTab+'" style="text-decoration:underline;">here<a/> to enter missing values.';
		showTrackerInfoDialog(html, gdiaglogSmall);
		return false;
	}	
	var roi = (sales - expenses) / expenses * 100;
	$('input[name="returnOnInvest"]', tab4).val(formatPercent(roi));
	return true;
}
function calculateCplAndCps(){
	var tab4 = $('#tabs-3');
	var expenses = $('input[name="totalExpense"]', tab4).val().replace(/[^0-9\.]/g, '');
	var calls = $('input[name="calls"]', tab4).val();
	var testsSold = $('input[name="testsSold"]', tab4).val();
	if(expenses == '' || calls == '') {
		var gotoTab;
		if (expenses == '')
			gotoTab = 'gotoTab(0, '+gSelectedId+');';
		else
			gotoTab = 'document.forms[0].calls.focus();'
		var html = '<h3>Sorry...</h3>There is not enough information to calculate Cost-Per-Lead.<br/><br/>Click <a onclick="'+gotoTab+'" style="text-decoration:underline;">here<a/> to enter missing values.';
		showTrackerInfoDialog(html, gdiaglogSmall);
		return false;
	}	
	var cpl = expenses / calls;
	$('input[name="costPerLead"]', tab4).val(formatDollarAmount(cpl));
	
	if( testsSold == '' && testsSold != 0) {
		var gotoTab = 'document.forms[0].testsSold.focus();'
		var html = '<h3>Sorry...</h3>There is not enough information to calculate Cost-Per-Sale.<br/><br/>Click <a onclick="'+gotoTab+'" style="text-decoration:underline;">here<a/> to enter missing values.';
		showTrackerInfoDialog(html, gdiaglogSmall);
		return false;
	}	
	var cps = expenses / testsSold;
	$('input[name="costPerSale"]', tab4).val(formatDollarAmount(cps));
	return true;
}

function gotoTab(index, entryId){
	$( "#tabs" ).tabs('select', index);
	if(index == 0)
		$('#tracker-detail-expense a[onclick^="selectAd('+entryId+'"]').click();
	else 
		$('#tracker-detail-sale a[onclick^="selectAd('+entryId+'"]').click();
}

function showTrackerEventDetailCallback(data, status, xhr) {
	var eleId;
	if(xhr)
		eleId = 'div.tracker-detail-content.entry-list';
	showTrackerEventDetail(data, undefined, eleId);
}

function showTrackerEventDetail(data, status, elementId ) {
	var eventsContainer;
	if(elementId == 'div.tracker-detail-content.entry-list')
		eventsContainer = 'gCompetitorAdEntries';//death code?
	else
		eventsContainer = 'gPlannerEntries';//sales/expenses/results

	var date = $.fullCalendar.parseDate( data.start );
	var html, element, link;
	html = 	'<div id="'+data.id+'-planner-detail-title" class="planner-detail-title"><div>'+data.title+'<span class="fright">'
	+'<img onclick="closeTrackerDialogs();invokeDelete(event,'+data.id+','+eventsContainer+',\''+eventsContainer+'\',\''+elementId+'\');" class="planner-icon x-icon-red" src="/images/Transparent.gif">'
	+'</span></div></div>';

	
	html += '<div id="'+data.id+'-planner-detail-info" class="planner-detail-info">'; 
		if(data['competitor.id'])
			html += '<b>Competitor:</b> ' +competitors['id='+data['competitor.id']].name + '<br/>';
    	var tmp = getSCHtml(data);
    	if(tmp != '')	html += tmp + '<br/>';
    	tmp = getVendorHtml(data, false, true);
    	if(tmp != '')	html += tmp + '<br/>';
		if(data.notes)
			html += '<b>Notes:<br/></b>'+data.notes.replace( /\n/g, '<br/>');	
	if(data.size && data.color && data.notes && (data['publication.id'] || data['vendor.id']))
		link = 'View Detail';
	else
			link = 'Add Detail';
	var br = '';
	if(data.size || data.color || data.notes || (data['publication.id'] || data['vendor.id']) )
		br = '<br/>';
	
	if(elementId == 'div.tracker-detail-content.entry-list')
		html += br +'<a href="javascript:void(0)" onclick="initCompAdDetail('+data.id+',new Date('+ date.getTime()+'));"><span class="planner-detail-link-green">'+link+'</span></a>';
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
function togglePublish(element) {
	 var target = $(element).children().first();
	 target.toggleClass('tracker-check-icon');
	 var val = target.children().first().val();
	 val = (val == 'true' ? 'false' : 'true');
	 target.children().first().val(val);
}

function resultRating(element, ratingVal) {
	element.blur()
	var target =$(element); 
	var classToAdd = 'tracker-1-star-icon', allClasses = 'tracker-0-star-icon tracker-1-star-icon tracker-1-2-star-icon';
	if(ratingVal == $('input[name="rating"]').val()){
		ratingVal = 0;//clear rating
		classToAdd = 'tracker-0-star-icon';
	}
	target.removeClass(allClasses).addClass(classToAdd);
	target.nextAll('input:submit').removeClass('tracker-1-star-icon tracker-1-2-star-icon')
					.addClass('tracker-0-star-icon');
	target.prevAll('input:submit').removeClass(allClasses).addClass(classToAdd);
	$('input[name="rating"]').val(ratingVal);
	return false;
}

function compareResult(result, formData){
	for(key in result){
		console.info('key:'+key + ":" + result[key]+ ":" + (formData[key] ? formData[key].value : 'undefined'));
		//if(formData[key] == result[key])
	}
	return false;
}

function publishResult(event){
	disableEventPropagation(event);
	
	var target = $("#dialog-publish-review");
	target.prev().css('background-color', 'white');	
	$('a.ui-dialog-titlebar-close span.ui-icon', target.prev()).attr('style', 'background-image:url(/images/itd/tracker/tracker_051211.png); background-position:-253px -131px;height:12px;width:13px; margin:0px');
	target.parent().css('background-color', 'white');
	var html= '<h1>My Review Summary</h1>';
	var result , plannerEntry;
	plannerEntry = gPlannerEntries['id='+document.forms['saveResult'].entryId.value];
	//result = plannerEntry.result;
	result = document.forms['saveResult'];
	//compareResult(result, document.forms['saveResult']);
	if(result.title != null)
		html += '<h3>'+result.title.value+'</h3>';
	for(var i=1; i<=5; i++)
		if(i <= result.rating.value)
			html += '<input type="submit" class="tracker-icon tracker-1-star-icon" value="">';
		else 
			html += '<input type="submit" class="tracker-icon tracker-0-star-icon" value="">';
	if(result.review.value != "")
		html += '<br/><br/>' + result.review.value.replace( /\n/g, '<br/>') + '<br/><br/><br/>';
	else 
		html +="<br/>";
	html += '<b>';
	if(result.publishCalls.value == "true" && result.calls.value != "")
		html += result.calls.value + ' Calls<br/>';	
	if(result.publishTestsSet.value == "true" && result.testsSet.value != "")
		html += result.testsSet.value + ' Tests Set<br/>';	
	if(result.publishTestsSold.value == "true" && result.testsSold.value != "")
		html += result.testsSold.value + ' Tests Sold<br/>';	
	if(result.publishHearingAidsSold.value == "true" && result.hearingAidsSold.value != "")
		html += result.hearingAidsSold.value + ' Hearing Aids Sold<br/>';	
	if(result.publishTestedNotSold.value == "true" && result.testedNotSold.value != "")
		html += result.testedNotSold.value + ' Tested Not Sold<br/>';
	if(result.publishGrossSales.value == "true" && result.grossSales.value != "")
		html += result.grossSales.value + ' Gross Sales<br/>';
	if(result.publishReturnOnInvest.value == "true" && result.returnOnInvest.value != "")
		html += result.returnOnInvest.value + ' ROI<br/>';
	if(result.publishCostPerLead.value == "true" && result.costPerLead.value != "")
		html += result.costPerLead.value + ' Cost Per Lead<br/>';
	if(result.publishCostPerSale.value == "true" && result.costPerSale.value != "")
		html += result.costPerSale.value + ' Cost Per Sale<br/>';
	
	var day = $.fullCalendar.formatDate(plannerEntry.start, 'dddd');
	day = '<span style="text-transform:capitalize;">' + day.toLowerCase() + '</span>, ';
	day +=  $.fullCalendar.formatDate(plannerEntry.start, 'MMMM d, yyyy');	
	html += 'Ran ' + day + '<br/>';
	if(plannerEntry.className == 'news-planner-event') {
		if($('input[name=placement]').is(":checked"))
			html += $('input[name=placement]:checked').val() +    ' Placement<br/>';
		html += (result.numberCompetitiveAd.value!=""?result.numberCompetitiveAd.value:0) + ' Same-day Competitive Ads<br/><br/>';	
	}	
	html+= '</b><div><input type="submit" onclick="savePublishResult();closeTrackerDialogs()" style="margin:10px  5px;float: right" value="" class="tracker-icon publish-btn">';
  	html+= '<input type="submit" onclick="closeTrackerDialogs()" style="margin:10px 5px;float: right" value="" class="tracker-icon tracker-cancel-gray-btn"></div>';

	target.html(html).dialog("open");
	$('input', target).get(0).blur();
	return false;
}

function deleteRow(elementId) {
	var count = $(gActiveRow).parent().parent().siblings().length;
	$(gActiveRow).parent().parent().nextAll().toggleClass('odd even');
	$(gActiveRow).parent().parent().remove();
	calculateTotal(null, elementId);
	if(count < 14)
		addRow(elementId);
}

var gActiveRow;
function onRowFocus(evt) {
 $(this).parent().parent().addClass('itda-ui-focus')
 						  .siblings().removeClass('itda-ui-focus');
 gActiveRow = this;
}

function addRow(elementId) {	
	var count = $(elementId + ' tr').length;
	var classname = (count % 2) == 0 ? 'odd' : 'even';
	
	if(elementId == '.tabs-1-numbers')
		html= "<tr class='"+classname+"'>"
			  	+"<td class='center col1'><input type='text' value='' maxlength='128' name='description' /></td>"
			    +"<td class='center amt col2'><input type='text' value='' name='amount' class='amount' maxlength='11'/></td>"
			  +"</tr>";
	else
		html = "<tr class='"+classname+"'>"
		  		+"<td class='center col1'><input type='text' name='date' class='saleDate'/></td>"
			  	+"<td class='center col2'><input type='text' value='' maxlength='128' name='description' /></td>"
			    +"<td class='center amt col3'><input type='text' value='' name='amount' class='amount' maxlength='11'/></td>"
		  		+"</tr>";
	$(elementId).append(html);
	$(elementId + ' tr:last input').focus(onRowFocus);
	
	$(elementId + " tr:last input.saleDate" ).datepicker();
	$(elementId +	' tr:last input.amount').forceNumeric();
}

function swapCalView(renderEvent, calElementId) {
	var visible = $('.tabs-4-content:visible');
	var hidden = $('.tabs-4-content:hidden');
	visible.hide();
	hidden.show();
	if(renderEvent){
		var addedEvents = $(gSmlFc).data('itdaNewEvents');
		for(var key in addedEvents){ 
			$('#calendar').fullCalendar('renderEvent', addedEvents[key], true);
			showTrackerEventDetailCallback(addedEvents[key], undefined, true);
			gCompetitorAdEntries[key] = addedEvents[key];
		}
		var addedEvents = $(gSmlFc).data('itdaNewEvents', []);

		var deletedEvents = $(gSmlFc).data('itdaDeletedEvents');
		if(deletedEvents)
			for(var i=0; i<deletedEvents.length; i++)
				$('#calendar').fullCalendar( 'removeEvents', deletedEvents[i] );
		$(gSmlFc).data('itdaDeletedEvents', undefined);	
	}

	updateCtxSensitiveTips();
}

function initCompAdDetail(id, date) {
	if(!colorAccordionHtml){
		 colorAccordionHtml = $('#color-accordion').html();
		 colorHeaderHtml = $('#color-header').html();
    	if($.cookie('trackerDetailPopup') == '1') {
        	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closeTrackerDialogs()"></span><br/>';
        	html += '<h3>To track your competitors...<br/></h3>';
        	html += 'Select from the drop down list the type of marketing ';
        	html += 'you want to track then fill in the details.<br/><br/>';
        	html += '<b>Note:</b> If you have a jpg, gif, or png of your competitor\'s';
        	html += ' ad, you can upload it under Select Ad.<br/>';
        	showItdaConfirmDialog(html, gdiaglogSmall, 330);
    		$.cookie('trackerDetailPopup', null, { expires: 0, path: '/myTracker'});
    		$.getJSON('/myAccount/updateSettings?trackerDetailPopup=1', {}, function(data) {});
    	}		
		 
	} 	
	swapCalView();
	 selectedDate = date;
	 initSmallFullCal('/myTracker', selectedDate);
 	var detailcal = $('#pdtl-calendar').data("theCalendar");
	detailCalUtil =  new FullCalUtil('detailCalUtil', detailcal); 
	detailCalUtil.setYearSelect($("#detailDate_year"));
	detailCalUtil.setMonthSelect($("#detailDate_month"));
	 
	init();	
	 if(selectedDate != undefined ) {
		 displayWorkingDate(selectedDate, false, $(gSmlFc).data('itdaEvents'), id);
		 selectedDate = undefined;
	}
	 $('form input[type="radio"]').css('border-width', "0");//ie issue	 
}

var gNewCompDiag; 
function newCompetitor() {
	if(!gNewCompDiag) {
		gNewCompDiag = $('#dialog-new-competitor').dialog({  minWidth: 360, modal: true, mimHeight: 300,  resizable: false , autoOpen : false});
		gNewCompDiag.prev().css('background-color', 'white');	
		gNewCompDiag.parent().css('background-color', 'white');
		gNewCompDiag.parent().css('border-color', '#B69A2F');
		$('td', gNewCompDiag).css('font-weight', 'bold');
	}
	gNewCompDiag.dialog('open');
	clearInputNOpen(gNewCompDiag);
}

function saveNewCompetitor() {
	var xhr = itdaPost("/myTracker/saveNewCompetitor", $("#newCompetitor").serialize(), undefined, errorHandler, 'json');
	var data = toJson(xhr);
	if(data.respText == 'Save completed.') {
		$('#new-competitor-message').hide();
		competitors['id='+ data.competitor.id] = data.competitor; 
		var html = '<input name="competitor.id" value="'+data.competitor.id+'" type="radio">&nbsp;&nbsp;&nbsp;'+data.competitor.name+'<br>'
		$('div#competitorList').append(html);
		gNewCompDiag.dialog('close');
		$("#newCompetitor input").attr('value', '');
	}else{
		showErrors(".errors", data.errors);
	}
}

function savePublishResult(event){
	saveResult(event, true);
}

function saveResult(event, publish) {
	$('#errors').hide();	
	var uri = '/myTracker/saveResult';
	if(publish)
		uri = '/myTracker/publishResult';
	$.post(uri 
			,$("#saveResult").serialize()
			,function (data, respText) {
				if(data.respText == 'Save completed.') {
						gPlannerEntries['id='+document.forms['saveResult'].entryId.value].result = data.entry.result;
				}else if(data.errors)
					showErrors("#errors", data.errors);
			}
			,'json');
	return false;
}

function calculateTotal(evt, tabId){
	if(evt)
		disableEventPropagation(evt);;
	var total = 0.0;
	$.each($(tabId + ' input.amount'),  function(i, input) {
		var amt = parseFloat(getDoubleStr($(input).val()));
		if(amt)
			total += amt
	});
	if(total == 0.0) {
		return false;
	}else{
		if(tabId == 'div#tabs-1')
			$('#totalExpense').html(formatDollarAmount(total));
		else
			$('#totalSales').html(formatDollarAmount(total));
		return true;
	}
}

function saveExpSaleEntries(evt, tabId, type){
	if(calculateTotal(evt, tabId)) {
		var plannerEntry = gPlannerEntries['id='+gSelectedId];
	    	
	    if(type == 'sale') {
	    	plannerEntry.entrySales=[];
	    }else {
	    	plannerEntry.entryExpenses=[];
	    }	    	
	
		var arr = [];
		$.each($('.'+tabId.replace('div#','') + '-numbers tr'),  function(i, tr) {
			var desc = $('input:[name=description]', tr).val();
			var amt = $('input:[name=amount]', tr).val();
			var date = $('input:[name=date]', tr).val();
			if(desc != '' || amt != '') {
				var JSONObject = new Object;
			    JSONObject.description = desc;
			    JSONObject.amount = amt;
			    JSONObject.entryId = gSelectedId;
			    arr.push(JSONObject);
			    if(type == 'sale') {
				    JSONObject.saleDate = date;
			    	plannerEntry.entrySales.push(JSONObject);
			    }else {
			    	plannerEntry.entryExpenses.push(JSONObject);
			    }		
			    if(amt != '')
			    	total += amt;
			}			
		});
		if(arr.length > 0) {
		    var JSONstring = JSON.stringify(arr);
		    var url = "/myTracker/updateExpense/";
		    if(type == 'sale')
		    	url = "/myTracker/updateSale/";
		    url += gSelectedId;
		    var data = itdaPostJson(url, {json:JSONstring});
		    plannerEntry.result = data.result;
		}		
	}else {
		var field = 'Gross Sales';
		if(type != 'sale')
			field = 'Expense Total';
    	var html = '<h3>Sorry...<br/></h3>'
    		+ 'There is not enough information<br/> to calcualte <i>'+field+'</i>.<br/>';
		showTrackerInfoDialog(html, gdiaglogSmall);
	}
}

var gTrackResultCal;
$(document).ready(function() {
	$('#footer a').removeClass('gold');
	$('#footer a.myTracker').addClass('gold');		
		gdiaglog = $('#dialog').dialog({ modal: true, height: 'auto', width: 330, maxWidth: 350, resizable: false , autoOpen : false});
		gdiaglogSmall = $('#dialog-small').dialog({modal: true,  height: 'auto', width: 330, maxWidth: 350, resizable: false , autoOpen : false});
		$('#dialog-review-policy').dialog({modal: true,  height: 'auto', width: 400, resizable: false , autoOpen : false});
		$('#dialog-publish-review').dialog({modal: true,  height: 'auto', width: 400, resizable: false , autoOpen : false});
		$('#dialogAdImage').dialog({modal: true,  height: 'auto', width:'auto', resizable: false , autoOpen : false});
		$(document).unbind('click').bind('click', function() {
			$('#dialogAdImage').dialog('close');
		});	
		var tab = 0, selectedDate = new Date(), id;
		var params = getRequestParams(document.URL);
		if(params['tab'] == 'Sales')	tab = 1;
		else if(params['tab'] == 'Results')	tab = 2;
		id = params['id'];
		if(params['date'])
			selectedDate = $.datepicker.parseDate('yymmdd', params['date']);
			
		$( "#tabs" ).tabs({
			 selected: tab,
			 show: function(event, ui) {
				$( "#tabs" ).removeClass('ui-corner-all');
				$('div#tabs.ui-tabs ul.ui-tabs-nav li:last').css('margin-right', '0px');
				closeTrackerDialogs();
		        if( ui.index == 0 ) {
		        	disableEventPropagation(event);
		        	$('table#tabs-1-detail-content').show();
		        	if(! gTrackResultCal){
		        		gTrackResultCal = initMultiSelectDatePicker('#expense-calendar', isExpenseDateSelected , expenseCalSelectDateFn, selectedDate);
			         	var thecal = $('#expense-calendar').data("theCalendar");
			        	expenseCalUtil =  new FullCalUtil('expenseCalUtil', thecal); 
			        	expenseCalUtil.setYearSelect($("#expenseDate_year"));
			        	expenseCalUtil.setMonthSelect($("#expenseDate_month"), true);
		        	}
		        	$('div#tabs-1 input').attr('value', '').unbind('focus').focus(onRowFocus);
		        	$('div#tabs-1 input.amount').forceNumeric();
		        	if($.cookie('trackerExpensePopup') == '1') {
			        	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closeTrackerDialogs()"></span><br/>';
			        	html += '<h3>This is where you record your expenses.<br/></h3>';
			        	html += 'Select a date and marketing item from the right, then type your ';
			        	html += 'expenses for that item.<br/><br/>';
			        	html += 'Click <b>Calculate</b> to total then save your entries.<br/><br/>';
			        	html += 'The sum will appear in the <b>My Results</b> tab and will be used to calculated your Return-on-Investment and Cost per lead.';
			        	showItdaConfirmDialog(html, gdiaglogSmall, '435');
		        		$.cookie('trackerExpensePopup', null, { expires: 0, path: '/myTracker'});
		        		$.getJSON('/myAccount/updateSettings?trackerExpensePopup=1', {}, function(data) {});

		        	}
		        	$('#detail-content').css('height', '465px');
		        	$('#content-summary').css('height', '480px');	
		        	if(gSelectedId)
		        		selectAd(gSelectedId, '#expense-detail-content', true);
		            //return true;		        	
		        }else if( ui.index == 1 ) {
		        	disableEventPropagation(event);
		        	$('table#tabs-1-detail-content').show();
		        	if(! gTrackResultCal){
		        		gTrackResultCal = initMultiSelectDatePicker('#expense-calendar', isExpenseDateSelected , expenseCalSelectDateFn, selectedDate);
			         	var thecal = $('#expense-calendar').data("theCalendar");
			        	expenseCalUtil =  new FullCalUtil('expenseCalUtil', thecal); 
			        	expenseCalUtil.setYearSelect($("#expenseDate_year"));
			        	expenseCalUtil.setMonthSelect($("#expenseDate_month"), true);
		        	}
		        	$('div#tabs-2 input').attr('value', '').unbind('focus').focus(onRowFocus);
		        	$("div#tabs-2 input.saleDate" ).datepicker('destroy');
		        	$("div#tabs-2 input.saleDate" ).datepicker();
		        	$('div#tabs-2 input.amount').forceNumeric();
		        	if($.cookie('trackerSalePopup') == '1') {
			        	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closeTrackerDialogs()"></span><br/>';
			        	html += '<h3>This is where you record your sales.<br/></h3>';
			        	html += 'Select a date and marketing item from the right, then type your ';
			        	html += 'sales for that item.<br/><br/>';
			        	html += 'Click <b>Calculate</b> to total then save your entries.<br/><br/>';
			        	html += 'The sum will appear in the <b>My Results</b> tab and will be used to calculated your Return-on-Investment.';
			        	showItdaConfirmDialog(html, gdiaglogSmall, '435');
		        		$.cookie('trackerSalePopup', null, { expires: 0, path: '/myTracker'});
		        		$.getJSON('/myAccount/updateSettings?trackerSalePopup=1', {}, function(data) {});
		        	}
		        	$('#detail-content').css('height', '465px');
		        	$('#content-summary').css('height', '480px');
		        	if(gSelectedId)
		        		selectAd(gSelectedId, '#sale-detail-content', true);
		            //return true;
		        }else if( ui.index == 2 ) {
		        	disableEventPropagation(event);
		        	$('table#tabs-1-detail-content').show();
		        	if(! gTrackResultCal){
		        		gTrackResultCal = initMultiSelectDatePicker('#expense-calendar', isExpenseDateSelected , expenseCalSelectDateFn, selectedDate);
			         	var thecal = $('#expense-calendar').data("theCalendar");
			        	expenseCalUtil =  new FullCalUtil('expenseCalUtil', thecal); 
			        	expenseCalUtil.setYearSelect($("#expenseDate_year"));
			        	expenseCalUtil.setMonthSelect($("#expenseDate_month"), true);
		        	}
		        	$('div#tabs-3 input.integer').forceInteger();
		        	$('div#tabs-3 input.amount').forceNumeric();
		        	$('div#tabs-3 input:radio').css('border','0px');
		        	if($.cookie('trackerResultPopup') == '1') {
			        	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closeTrackerDialogs()"></span><br/>';
			        	html += '<h3>Tracking your results is as easy as filling in the blanks...<br/></h3>';
			        	html += 'and calculating your results is just a click away.<br/><br/>';
			        	html += 'Did your marketing work for you? ' +
			        			'Take a moment and review this ad for yourself and for others.<br/><br/>';
			        	html += 'The checked items will be included in your review and published with the ratings in the Archive.<br/><br/>';
			        	html += 'You can deselect a check mark by clicking on it.';
			        	showItdaConfirmDialog(html, gdiaglogSmall, '435');
		        		$.cookie('trackerResultPopup', null, { expires: 0, path: '/myTracker'});
		        		$.getJSON('/myAccount/updateSettings?trackerResultPopup=1', {}, function(data) {});
		        	}
//		        	currMonthEvents= currMonthExpenseEvents;
		        	$('#detail-content').css('height', '715px');
		        	$('#content-summary').css('height', '574px');
		        	if(gSelectedId)
		        		selectAd(gSelectedId, '#result-detail-content', true);
//		            return true;
		        }else if( ui.index == 3 ) {
		        	disableEventPropagation(event);
		        	$('table#tabs-1-detail-content').hide();
		        	if($.cookie('trackerCompetitionPopup') == '1') {
			        	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closeTrackerDialogs()"></span><br/>';
			        	html += '<h3>Tracking your competitors\' marketing is easy!<br/></h3>';
			        	html += 'Just drag and drop the icon for the type of ';
			        	html += 'marketing you wish to run on any date. You ';
			        	html += 'can even add multiple types of marketing on ';
			        	html += 'a single date.<br/><br/>';
			        	html += 'Clicking on an icon in the calendar will let ';
			        	html += 'you add specific details.';
			        	html += '<img class="planner-icon x-icon-red" src="/images/Transparent.gif" style="position:relative;top:18px;left:153px"/>'
			        	html += '<b>Note:</b> Clicking on a &nbsp;&nbsp; icon will delete a marketing entry along with any details you have previously entered.';
			        	showItdaConfirmDialog(html, gdiaglogSmall, '435');
		        		$.cookie('trackerCompetitionPopup', null, { expires: 0, path: '/myTracker'});
		        		$.getJSON('/myAccount/updateSettings?trackerCompetitionPopup=1', {}, function(data) {});
		        	}
		        	if(!gTrackercal)
		        		initTrackCompetitorEventCal();
		        }	
		        updateCtxSensitiveTrackerTips(ui.index);
			    return true;
		    }	
		});
		resetTab3();
		if(id){
			selectAd(id,'#expense-detail-content');	
		}
		
		
	});

function initTrackCompetitorEventCal () {
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
	var expenseCal = $('#expense-calendar');
	var month = expenseCal.data('datepicker').drawMonth;
	var year = expenseCal.data('datepicker').drawYear;
	
	gTrackercal = $('#calendar').fullCalendar({

	
	 height: 661,	
	 year: year, 
	 month: month,
	header: {
		left: '',
		center: 'prev title next',
		right: ''
	},
    events: $.fullCalendar.trackerCalFeed('/myTracker/listJson4User'),
	eventClick: function(event) {
		initCompAdDetail(event.id, event.start);
		return false;
	},
	dayClick: function(date, allDay, jsEvent, view) {
		if(console && console.info)
		console.info('dayClick event handler');	
		return false;
	},	
	editable: true,
	droppable: true, // this allows things to be dropped onto the calendar !!!
	drop: function(date, allDay) { // this function is called when something is dropped

			// retrieve the dropped element's stored Event Object
			var originalEventObject = $(this).data('eventObject');
			var serverEvent = itdaPostJson("/myTracker/createJson4User", 
					{  start: 'date.struct'
						 , start_year: date.getFullYear()
						 , start_month: (date.getMonth() + 1)
						 , start_day: date.getDate()
						 , className: originalEventObject.className
				 		 , title: originalEventObject.title});
			showTrackerEventDetailCallback(serverEvent, 0, 1);
			serverEvent.image = originalEventObject.image;
			//var comboEvent = $.extend(serverEvent, originalEventObject);
			gCompetitorAdEntries['id=' + serverEvent.id] = serverEvent;
			$('#calendar').fullCalendar('renderEvent', serverEvent, true);
		}
	});	
	
	calUtil =  new FullCalUtil('calUtil', gTrackercal); 
	calUtil.setYearSelect($("#date_year"));
	calUtil.setMonthSelect($("#date_month"), true);
	
	if($.browser.webkit)
		  $('#calendar tbody.cal-content-number').css('border-right-width', '2px');//safari
	else//IE and Mozilla
		  $('tbody.cal-content-number tr td.fc-leftmost.fc-state-default').css('border-left-width', '2px'); 
	$('.fc-header-right').html('<a onclick="gotoDetailView(gCompetitorAdDetailEntries);" href="javascript:void(0)"><span style="position:relative; top:12px; float:right;color:rgb(85, 85, 85);font-size:11px"><img style="float: left;" class="tracker-icon tracker-detail-view-icon" src="/images/Transparent.gif"/><span <span style="position:relative; top:2px">&nbsp;Details&nbsp;View</span></span></a>');
}

function selectAd(id, selectingElementId, dontUseSelectedTab) {
	$('#errors').hide();
	$('.default-tracker-msg').hide();
	if(!dontUseSelectedTab) {
		var selected = $('#tabs').tabs('option', 'selected');
		if(selected == 0) selectingElementId= '#expense-detail-content';
		else if(selected == 1) selectingElementId= '#sale-detail-content';
		else if(selected == 2) selectingElementId= '#result-detail-content';
	}	
	$('div[id$="-planner-detail-title"]').css('background-color', '');
	$('div[id$="-planner-detail-info"]').css('background-color', '');	
	$('div#'+id+'-planner-detail-title').css('background-color', 'rgb(248,245,230');
	$('div#'+id+'-planner-detail-info').css('background-color', 'rgb(248,245,230');	

	if(gPlannerEntries['id='+id]){
			var entry = gPlannerEntries['id='+id];
			gSelectedId = id;
			var day = $.fullCalendar.formatDate(entry.start, 'dddd');
			var html = '<h1 style="text-transform:capitalize;font-weight:bold">'+day.toLowerCase()+'</h1>';
			html += '<h3 style="margin:0;">' + $.fullCalendar.formatDate(entry.start,
					'MMMM dS, yyyy') + '</h1>';
			$(selectingElementId +'selectedAdDate').html(html);	
			
			html = '<h3>'+getEventType(entry.className)+':</h3>';
			for(var key in entry.publications)
				html += '<h3>'+entry.publications[key].name+'</h3>';
			for(var key in entry.vendors)
				html += '<h3>'+entry.vendors[key].name+'</h3>';
			html += '<div style="height:5px"/>'
			if(entry.portfolioDesc) {
				html += '<h3>'+entry.portfolioDesc+'</h3>';
				html += '<span>'+getFileName(entry.portfolioEntry, entry.color)+'</span>';
			}
			html += '<br/><span>'+getSizeText(entry.size, entry.otherSize)+'</span>';
			html += '<br/><span>'+getColorText(entry.color)+'</span>';
			$(selectingElementId +'-selectedAdInfo').html(html);
			var url;
			if(entry.portfolioEntry)
				url = getJpgUrl(entry.portfolioEntry.id, false, entry.color);
			else if(entry.imageFile)
				url = "/myPlanner/getImageFile/"+ entry.id + "?token=" +(new Date()).getTime();
			
		    if(url)
				html = "<img src='"+url+"' style='max-height: 250px; max-width: 170px'/>";
		    else 
				html ='';
			$(selectingElementId +'-selectedAdImage').html(html);
			$(selectingElementId +'-selectedAd').show();
			$(selectingElementId +'-selectedAdImage img').bind('click', {url:url}, showLargeImage);
			
			var descriptions = [], amounts = [], dates= [];
			if(selectingElementId.indexOf('expense') >= 0) {
				$('div#tabs-1 input').attr('value', '').removeAttr('readonly');
				$('#totalExpense').html('').attr('readonly','readonly');
	
				$(selectingElementId+'-expense-title').html('&nbsp;Expenses for ' + entry.title);
				var k=$('div#tabs-1 table.tabs-1-numbers tr').size();
				while(k < entry.entryExpenses.length){
					addRow(".tabs-1-numbers");
					k++;
				}
				$.each($('div#tabs-1 table.tabs-1-numbers tr'),  function(j, tr) {
					descriptions[j] = $('input:[name=description]', tr);
					amounts[j] = $('input:[name=amount]', tr);
				});
				entry.entryExpenses.sort(sortByDesc);
				for(k=0; k < entry.entryExpenses.length; k++){
					descriptions[k].attr('value',entry.entryExpenses[k].description);
					amounts[k].attr('value', formatDollarAmount(entry.entryExpenses[k].amount));
				}
				calculateTotal(null, "div#tabs-1");
			} else if(selectingElementId.indexOf('sale') >= 0){
				$('div#tabs-2 input').attr('value', '').removeAttr('readonly');
				$('#totalSales').html('').attr('readonly','readonly');	
				$(selectingElementId+'-sale-title').html('&nbsp;Sales for ' + entry.title);
				var k=$('div#tabs-2 table.tabs-2-numbers tr').size();
				while(k < entry.entrySales.length){
					addRow(".tabs-2-numbers");
					k++;
				}
				$.each($('div#tabs-2 table.tabs-2-numbers tr'),  function(j, tr) {
					descriptions[j] = $('input:[name=description]', tr);
					amounts[j] = $('input:[name=amount]', tr);
					dates[j] = $('input:[name=date]', tr);
				});
				entry.entrySales.sort(sortBySaleDate);
				for(k=0; k < entry.entrySales.length; k++){
					descriptions[k].attr('value',entry.entrySales[k].description);
					dates[k].attr('value',entry.entrySales[k].saleDate);
					amounts[k].attr('value', formatDollarAmount(entry.entrySales[k].amount));
				}
				calculateTotal(null, "div#tabs-2")
			} else {
				resetTab3(true);
				var tab3 = $('div#tabs-3')
				if(entry.className.indexOf('news') >= 0) {
					$('div.review div#newspaper', tab3).css('visibility', 'visible');
			    	$('span#ad').html('ad');
				}else{
					$('div.review div#newspaper', tab3).css('visibility', 'hidden');;
			    	$('span#ad').html('marketing');			    	
				}
				if(entry.portfolioEntry && (entry.className.indexOf('news') >= 0 || entry.className.indexOf('direct') >= 0) ) 
					$('.publish-btn').show();
				else
					$('.publish-btn').hide();
			    document.forms['saveResult'].entryId.value =  entry.id;
				$(selectingElementId+'-result-title').html('&nbsp;Results for ' + entry.title);

				if(entry.result){
					$.each($('input', tab3),  function(j, input) {
						var jinput = $(input);
						var type = jinput.attr('type');
						var name = jinput.attr('name');
						var value = jinput.attr('value');
						if(type == 'text') {
							jinput.attr('value', entry.result[name]);
							jinput.focusout();
						}
						else if(type == 'radio' && value  == entry.result[name])
							jinput.attr('checked', 'checked');
						else if(name.indexOf('publish') == 0)
							if( entry.result[name] == false) 
								togglePublish(jinput.parent().parent().get(0));
					});
					var roi = $('input[name="returnOnInvest"]', tab3);
					roi.val(formatPercent(roi.val()));					
			    	$('textarea', tab3).val(entry.result['review']);
			    	if(entry.result['rating'] > 0){
			    		var index = entry.result['rating'] - 1;
			    		var elem = $('div#tabs-3 input[onclick^="return resultRating"]:eq('+index+')').get(0);
			    		resultRating(elem, index+1);
			    	}
			    }
			}			
	}
}
function sortBySaleDate(a, b){
	if(!a.saleDate && !b.saleDate) return 0;
	if(a.saleDate && !b.saleDate) return 1;
	if(!a.saleDate && b.saleDate) return -1;
	else if (a.saleDate > b.saleDate) return 1;
	else if (a.saleDate < b.saleDate) return -1;
	return sortByDesc(a, b);
}
function sortByDesc(a, b){
	if(!a.description && !b.description) return 0;
	if(a.description && !b.description) return 1;
	if(!a.description && b.description) return -1;
	else if (a.description > b.description) return 1;
	else if (a.description < b.description) return -1;
	return 0;
}
function unselectAdImage(id) {
	var uri = ctrl + "/unselectAdImage/";
	var xhr = itdaPost(uri, {id:id}, undefined, errorHandler, 'json');
	var data = toJson(xhr);
	if(data.respText == 'Save completed.') {
		gCompetitorAdDetailEntries['id='+id].imageFile = null;
		updateSummary(selectedPlannerEntry);
	}
}

function saveTrackerForm(formId, formMsgDiv) {
	var saved, id = selectedPlannerEntry.id;
	var key = 'id='+id;
	var uri = ctrl + "/updateDetail4UserSimple/"+ id;
	var xhr = itdaPost(uri, $(formId).serialize(), undefined, errorHandler, 'json');
	var data = toJson(xhr);
	if(data.respText == 'Save completed.') {
		saved = true;
		data.entry.start = $.fullCalendar.parseDate(data.entry.start);
		gCompetitorAdDetailEntries[key] = $.extend(gCompetitorAdDetailEntries[key],data.entry);	
		if(gCompetitorAdEntries[key])
			gCompetitorAdEntries[key] = gCompetitorAdDetailEntries[key];
	}
	if(saved){
		selectedPlannerEntry = gCompetitorAdDetailEntries[key];
		updateSummary(selectedPlannerEntry);
		$('#accordion').accordion('activate', -1);
		return true;
	}else
		return false;	
}

function showTrackerInfoDialog(content, diag, width, height) {
	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closeTrackerDialogs()"></span><br/>';
	showItdaInfoDialog(html + content, diag, width, height);
}
function updateCtxSensitiveTrackerTips(tabIndex){
    var par = $(".tracker-icon.tracker-tips").parent(), clickHtm = par.html();
    var tipFile;
    if(tabIndex === 0)
    	tipFile = 'tips-tracker-exp.gsp'
    else if(tabIndex === 1)
    	tipFile = 'tips-tracker-sale.gsp'    	
    else if(tabIndex === 2)
    	tipFile = 'tips-tracker-res.gsp'    	
    else 
    	tipFile = 'tips-tracker-main.gsp'    	

    clickHtm = clickHtm.replace(/tips-.*.gsp/i, tipFile);    	
	par.html(clickHtm);
	$(gTipsDiag).dialog('destroy');
	gTipsDiag  = undefined;
}

function updateCtxSensitiveTips(entry){//comp tracker
    var par = $(".tracker-icon.tracker-tips").parent(), clickHtm = par.html();
    if($('.tabs-4-content:visible #calendar').size() === 1)
    	clickHtm = clickHtm.replace(/tips-tracker-comp.gsp/i, 'tips-tracker-main.gsp');    	
    else if(!entry)
    	clickHtm = clickHtm.replace(/tips-tracker-main.gsp/i, 'tips-tracker-comp.gsp');
    else{
    	var ad = getEventTypeCode(entry.className);
    	par.data('entry', entry);
    	clickHtm = clickHtm.replace(/tips-tracker-comp.*.gsp/i, 'tips-tracker-comp-'+ad+'.gsp');    	
    	clickHtm = clickHtm.replace(/tips-tracker-main.gsp/i, 'tips-tracker-comp-'+ad+'.gsp');
    }
	par.html(clickHtm);
	$(gTipsDiag).dialog('destroy');
	gTipsDiag  = undefined;
}

function calcTestsNotSold () {
	var tab4 = $('#tabs-3');
	var testsSet = parseInt($('input[name="testsSet"]', tab4).val());
	var testsSold = parseInt($('input[name="testsSold"]', tab4).val());
	
	if(testsSet > 0 && testsSold >= 0 && testsSet >= testsSold) {
		$('input[name="testsNotSold"]', tab4).val("");
		var testsNotSold = testsSet - testsSold;
		$('input[name="testedNotSold"]', tab4).val(testsNotSold);
	}
}