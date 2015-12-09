
function initArchive(noSearch, ctrl) {	
	$('#doc').show();
    accordion = $("div [id^='archive-accord']").accordion({
    	active: false, 
    	autoHeight: false,
    	collapsible:true
    });
    if(!noSearch)
    	doSearch();
	gdiaglog = $('#dialog').dialog({ height: 90, width: 300, maxHeight: 90, maxWidth: 300, resizable: false , autoOpen : false});
	gdiaglogBigger = $('#dialogBigger').dialog({ height: 90, width: 300, maxHeight: 90, maxWidth: 300, resizable: false , autoOpen : false});
	$('#dialogAdImage').dialog({modal: true,  height: 'auto', width:'auto', resizable: false , autoOpen : false});

	$(document).unbind('click').bind('click',  function() {
			 $('#dialog').dialog('close');
			 $('#dialog-cal').dialog('close');
			 $('#dialogAdImage').dialog('close');
	});
	
	var blks = $('#timeofyear-panel-search, #focus-panel-search, #offers-panel-search, #type-panel-search, #size-panel-search');
	blks.each(function( ) {
		var blk = this;
		$('input:text', blk)
		.unbind('focus')
		.bind('focus', {blk:blk}, ctrl.onSelectCheckboxInput);	
	});	
}

function prev() { //result page
	if(parseInt(document.forms['filter-form'].offset.value) - parseInt(document.forms['filter-form'].max.value) >= 0) {
		document.forms['filter-form'].offset.value = parseInt(document.forms['filter-form'].offset.value) - parseInt(document.forms['filter-form'].max.value);
		updateResult();
	}
	else 
		return false;
}

function next() {//result page
	if(parseInt(document.forms['filter-form'].offset.value) + parseInt(document.forms['filter-form'].max.value) < total) {
		document.forms['filter-form'].offset.value = parseInt(document.forms['filter-form'].offset.value) + parseInt(document.forms['filter-form'].max.value);
		updateResult();
	}
	else 
		return false;
}

function resultsPerPage(anchor) {
	document.forms['filter-form'].max.value = anchor.innerHTML ;
	document.forms['filter-form'].offset.value = 0;
	$('.archive-link-active').attr('class', 'archive-link-default');
	anchor.setAttribute("class", "archive-link-active");
	updateResult();
	return false; 
}

function updateResult(){
	updateResultFlag = true;  //offset is set
	doSearch();
}

var results, total=0, currPage=1, updateResultFlag = false, gResultAssoArray = [];
function displayResults(results, dates, page, num) {
	
    var searchCriteria = buildCriteriaText();
    $('#searchCriteria').html(searchCriteria);
	var html ='', row=0;
	if(results.length == 0){
		$('.resultsheader').show();
		$('.noresult h3').hide();
		$('.noresult').show();
		var view = document.forms['filter-form'].viewFilter.value.replace(' ', '-');
		$('.noresult h3.nr-'+view).show();
		$('#result').hide();
		$('.resultsfooter').hide();
		$('#resultBody').html(html);
		return;
	}

	var resultsLenM1 = results.length-1;//, colorsLenM1 = colors.length-1;
	for(var i=0; i<results.length; i++){
			var date, col = i%3;//(numOfImg+j)%3;
			if (dates)
				date = dates[i];
	  		if(col == 0)
	  	  		html += "<tr id='row"+row+"'>";
	  	  	html +=  displayResultColum(results[i], date, col, row);
	  		if(col==2 || i==resultsLenM1 ){
	  			if(i == resultsLenM1 && col == 1)
	  				html += '<td>&nbsp;</td>'
	  				
	  	  		row++;
	  	  		html += "</tr>";
	  		}
		//}
	}
	$('.resultsheader').show();
	$('.noresult').hide();
	$('#result').show();
	$('.resultsfooter').show();
	var totalPage = Math.ceil(total/document.forms['filter-form'].max.value);
	currPage = document.forms['filter-form'].offset.value/document.forms['filter-form'].max.value + 1;
	$("#gotopage, #gotopage-bottom").html('');
	for(var i=0; i<=totalPage; i++)
		$("#gotopage, #gotopage-bottom").append('<option value="'+i+'">'+ (i==0 ? ' ': i) );
	$('#paginate, #paginate-bottom').html('Page <b>'+ currPage +'</b> of ' + totalPage);
	$('#resultBody').html(html);

	var preview
	$('input[name="imagePreview"]').each(function(index, input) {
		if(input.checked)
		    preview = true; 
	});

	$('img[id^="small-image-"]').each( function(index, image) {
		var img = $(image);
		//console.info(img.attr('src'));
		img.bind('click', {url:img.attr('src')}, showLargeImage);
		if(preview)
			img.loupe(); 
	});
}

function buildCriteriaText() {

	//var fileName = document.forms['filter-form'].fileName;
	//if(fileName && $.trim(fileName.value) != '') {
	//	return 'file number ' + $.trim(fileName.value); 
	//}
		
	var colors = '', sizes = '', featuring = '';// elements = '', focus = '';
    var searchCriteria = document.forms['filter-form'].viewFilter.value + ' ' + $('input:radio[name=adType]:checked').val();
	$('div#filters select').each(function(index, select) {
		if(select.name == 'portfolioDate' && select[select.selectedIndex].value != 'null'){
			searchCriteria += ' from "' + select[select.selectedIndex].text + '" ' + 
			$("#archive-accord-date a").html().substr(3);; 
		}
	});			

	$('div#filters input:checkbox').each(function(index, input) {
		if(input.checked && $(input).attr('disable') != 'true')
			if(input.name == 'size') {
				if(sizes != '')
					sizes += ', ';
				sizes += getSizeText(input.value); 		    
			}
			else if(input.name == 'color') {
				if(colors  != '')
					colors += ', ';
				colors += getColorText(input.value); 		    
			} else if(input.name.indexOf('other') != 0){
				if(featuring != '')
					featuring += ', ';
				featuring += input.value; 		    
			}
	});
	var osizes = $('#type-panel-search input[name=otherSize], #size-panel-search input[name=otherSize]').each( function(index, input){
		var v = $.trim(input.value);
		if(v  != '')
			sizes += (sizes == '' ? v : ', ' + v);
	});
	var ofeature = $('div#filters input[name=otherFocus], div#filters input[name=otherTimeOfYear], div#filters input[name=otherOffer]').each( function(index, input){
		var v = $.trim(input.value);
		if(v  != '')
			featuring += (featuring == '' ? v : ', ' + v);		
	});
	
	if(sizes != '')
		searchCriteria += ' in ' +  sizes; 
	if(colors != '')
		searchCriteria += ' in ' +  colors; 
	if(featuring != '')
		searchCriteria += ' featuring ' +  featuring; 
	
	var keyw = document.forms['filter-form'].keyword;
	if(keyw && $.trim(keyw.value) != '')
		searchCriteria += ' with keyword ' + $.trim(keyw.value); 
	
	return searchCriteria;	
}

function toggleOverText(id, text, element){
	$(element).toggleClass('itda-off itda-on ');
	$(element).css('cursor', 'pointer');
	$('#result-hover-'+id).html(text);
}

function selectPortfolioEntry(portEntryId, plannerId, color) {
	var xhr = itdaPost('/myPlanner/selectPortfolioEntry/' +plannerId, {selectedId:portEntryId,color:color}, undefined, errorHandler, 'json');
	var data = toJson(xhr);
	if(data.respText == 'Save completed.') {
		var planEntry = gPlannerDetailEntries['id='+plannerId];
		var portEntry = data.portEntry;
		planEntry.portfolioEntry = portEntry;
		planEntry.color = portEntry.color + 'C';
		planEntry.size = portEntry.adSizeCode;
		if(portEntry.myUploads)
			planEntry.otherSize = portEntry.otherSize;
		planEntry.size = portEntry.adSizeCode;
		planEntry.imageFile = null;
		planEntry.portfolioDesc = data.portfolioDesc;
		updateSummary (planEntry);
		$('#searchCriteria').html('');
		$('#resultBody').html('');
		swapPlannerCalView('detail');
	}
}

function unselectPortfolioEntry(plannerId) {
	var xhr = itdaPost('/myPlanner/selectPortfolioEntry/' +plannerId, {}, undefined, errorHandler, 'json');
	var data = toJson(xhr);
	if(data.respText == 'Save completed.') {
		gPlannerDetailEntries['id='+plannerId].portfolioEntry = null;
		gPlannerDetailEntries['id='+plannerId].imageFile  = null;
		updateSummary (gPlannerDetailEntries['id='+plannerId]);
	}
}


function toggleAdImage(element, color) {
	if(gResultAssoArray['id=' + gcurrAd].myUploads)
		return false;
	$('#ad-colors table tbody tr td').removeClass('itda-off itda-on').addClass('itda-off');
	$(element).parent().addClass('itda-on');
	loadDetailImage(color);
	return true;
}

var view = 'All';
function updateViewGroupFilters(element, filterVal) {
	if(view != filterVal){
		view = filterVal;
		$('tr.view-filter-ui td').removeClass('itda-on').addClass('itda-off');
		$(element).parent().parent().children().toggleClass('itda-off itda-on');
		document.forms['filter-form'].viewFilter.value = filterVal;
		doSearch();
	}
}

function doSearch() {
    // validate and process form here
    //console.info('updateResultFlag '+updateResultFlag); 
  toggleView('.result-detail','#search-result');
    
    if(updateResultFlag == false)
    	document.forms['filter-form'].offset.value = 0;
    else
    	updateResultFlag = false;
	var dataString = '';
	$('div#filters input[type=hidden]').each(function(index, input) {
		    dataString = dataString + '&'+input.name + '=' + input.value; 
	});
	$('div#filters input:text').each(function(index, input) {
	    dataString = dataString + '&'+input.name + '=' + escape(input.value); 
	});
	$('div#filters input:checkbox').each(function(index, input) {
		if(input.checked && $(input).attr('disable') != "true" )
		    dataString = dataString + '&'+input.name + '=' + escape(input.value); 
	});
	$('div#filters select').each(function(index, select) {
		    dataString = dataString + '&'+select.name + '=' + escape(select[select.selectedIndex].value); 
	});

	dataString += '&adType=' +  $('input:radio[name=adType]:checked').val();

	var data = itdaPostJson("/archive/getArchivedEntries", dataString, searchError);
	
	if (data.entries) { 
		results = data.entries;
		total = data.totalCount;
		gResultAssoArray = [];
		addToAssociativeArray(results, gResultAssoArray);	
		for(var i=0; i<data.favorites.length; i++)
			gResultAssoArray['id='+data.favorites[i]].favorite = 'true'		
		if(document.forms['filter-form'].viewFilter.value == 'Favorites')
			for(var i=0; i<results.length; i++)
				results[i].favorite = 'true'
	    var f = document.forms['filter-form'];
		displayResults(results, data.dates, f.offset.value/f.max.value +1, f.max.value);
	}
	
	  return false;    	
  }

function searchError(jqXHR, textStatus, errorThrown) {
	$('.resultsheader').show();
	$('#resultBody').html('<br/><br/><h3> Search failed: '+textStatus+'</h3>');	  
	$('.resultsfooter').hide();
  }

function showResult(id) {
  if(id == undefined)
	  return;
  else
	  toggleDetail(id, gcolor)
}

function showDetailOfResult(id, result, color) {
	if(result == undefined) { 
		  for(var i=0; i<gCompPieces.length; i++)//user select companion piece
			  if(id == gCompPieces[i].id) {
				  result = gCompPieces[i];
				  break;
			  }
	}
	//loadPortfolioAndReviewInfo(result);
	if(color == undefined )
		color = gcolor;

	  toggleView('#search-result', '.result-detail');
	  loadDetailImage(color, result.id);
	  //$('#ad-desc').html('&nbsp;');
	  $('#ad-type').html(getTypeText(result.adTypeCode));
	  $('#ad-file').html(getFileName(result, color));
	  $('#ad-size').html(getSizeText(result.adSizeCode, result.otherSize));
	  var num = 'One';
	  if(4 == color) num = 'Four';
	  else if(2 == color) num = 'Two';
	  $('#ad-color').html( num + ' Color');
	  var html = '';
	  var rating = 0;
	  for(var j=0; j<5; j++)
	  	    if(j+1 <= result.rating){
		     	html +="<div class='itda-archive-icon rating-orange-icon' style='float:left'></div>";
	  			rating = j+1;
	  	    }else if(j+0.5<= result.rating){
		     	html +="<div class='itda-archive-icon rating-half-icon' style='float:left'></div>";
		     	rating = j + 0.5;
			}else{
	     		if(0<result.rating)
	     			html +="<div class='itda-archive-icon rating-white-icon' style='float:left'></div>";
	     		else
	     			html +="<div class='itda-archive-icon rating-black-icon itda-off' style='float:left'></div>";
		    }
	  $('#ad-rating').html(html);
	  if(0<result.rating){
		  $('#ad-rating-text').html(rating + ' based on '+result.numRating+' rating'+ (result.numRating > 1 ? 's' :'')  );
		  $('#ad-rating-link').html('<a href="javascript:void(0);" onclick="archCtrl.showReview('+result.id+')">'+result.numReview+' Customer Review'+ (result.numReview > 1 ? 's' :'')+'</a>');
	  }else{
		  $('#ad-rating-text').html('Not yet rated'  ).attr('style', 'color:#AAAAAA');
		  $('#ad-rating-link').html('Not yet reviewed').attr('style', 'color:#AAAAAA;font-size:12px');;
	  }
	  $('div.c'+color+'-on-icon, div.c'+color+'-off-icon').click();
	  
	  if(!result.favorite)
		  html = "<td><div class='itda-archive-icon add-favorite-icon' onclick='addToFavorites(event,undefined)'></div></td>" +
	       	 	"<td class='align-bottom'><span onclick='addToFavorites(event,undefined);return false;'>Add to Favorites</span></td>";
	  else
		  html = "<td><div class='itda-archive-icon add-favorite-icon' onclick='removeFavorite(event,undefined)'></div></td>" +
     	 	"<td class='align-bottom'><span onclick='removeFavorite(event,undefined);return false;'>Remove From Favorites</span></td>";
		  
	  $("#addFavorite").html(html);	  
}
var gPortfolio;
function loadPortfolioAndReviewInfo(result){
	var portDate = $.fullCalendar.formatDate($.fullCalendar.parseISO8601(result.portfolioDate),'yyyyMMdd');
	//if(!gPortfolios || !gPortfolio[portDate])
		//loadInfo();	
}

function toggleView(hide, show){
	$(hide).hide();
	$(show).show();
	var par = $(".itda-archive-icon.tips-56-22").parent(), clickHtm = par.html();
	if(show == '#search-result')
		clickHtm = clickHtm.replace('/archive/tips-detail.gsp', '/archive/tips-main.gsp'); 
	else
		clickHtm = clickHtm.replace('/archive/tips-main.gsp', '/archive/tips-detail.gsp'); 
	par.html(clickHtm);
	$(gTipsDiag).dialog('destroy');
	gTipsDiag  = undefined;
}

var gcolor=4, gcurrAd; 
function toggleDetail(id, color) {
  if(id == undefined) {
	  toggleView('.result-detail','#search-result');
	  return;
  }

  var result; 
  for(var i=0; i<results.length; i++)
	  if(id == results[i].id) {
		  result = results[i];

		var prev = results[i-1] ? 'showResult('+results[i-1].id+');' : undefined;
		var next = results[i+1] ? 'showResult('+results[i+1].id+');' : undefined;
		if(next)
			$('#nextResult').html("<img class='tracker-icon small-next-icon' src='/images/Transparent.gif' style='float:right' onclick='"+next+"'/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Next"+(prev?"":"&nbsp;&nbsp;"));
		else
			$('#nextResult').html("");
		if(prev)
			$('#prevResult').html("<img class='tracker-icon small-prev-icon' src='/images/Transparent.gif'  style='float:left' onclick='"+prev+"'/>&nbsp;&nbsp;Previous");
		else
			$('#prevResult').html("");
		  break;
	  }
  showDetailOfResult(result.id, result, color);

  loadCompanionPieces(result.adTypeCode, result.portfolioDate, 0, color);
}

var goffset4Comp =0, gCompPieces, gPortDesc;
function loadCompanionPieces(adType, date, offset, color){
	var dataString = 'max=5&companion=true&keyword=&fileName&viewFilter=All&offset=' + offset;
	if(adType == 'NP')
		    dataString = dataString + '&adType=Direct Mail Marketing'; 
	else
	    dataString = dataString + '&adType=Newspapers';
	dataString += '&portfolioDate=' +  date+'&color=' +  color;
    
	var results = itdaPostJson("/archive/getArchivedEntries", dataString, null);
	displayCompanionPieces(results, color, adType, date, offset);
	
}

function displayCompanionPieces(data, color, adType, date, offset) {
    $('#companionPieces').html('');
	if (data.entries) { 
		$('#ad-desc').html(data.portfolioDescription);
		var html="", i, len = Math.min(5, data.entries.length);
		for(i=0; i<len; i++) {
			html += "<td width='20%' style='font-weight:500;color:black;padding-left:15px'>" +
					"<div style='position:relative;height:160px'><div style='position:absolute;bottom:0'>" +
				"<img src='"+getJpgUrl(data.entries[i].id, undefined, color)+"' onclick='showDetailOfResult("+data.entries[i].id+")' width='90%' style='margin-bottom:5px;max-width:100%;max-height:175px'/>"
				+ "</div></div>"
			 + getTypeText(data.entries[i].adTypeCode)
			+ '<br/>' + getSizeText(data.entries[i].size, data.entries[i].otherSize)
								
			+"</td>";
		}
		while(i<len)
			html += "<td width='20%'>&nbsp;</td>";

		$('#companionPieces').append(html);
		//$('#companionPieces img').each( function(index, image) {
		//	var img = $(image);
		//	img.bind('click', {url:img.attr('src')}, showLargeImage);
		//});		
		
		if(offset-5 >= 0)
			$('#prev-companion').html("<img class='tracker-icon small-prev-icon center' src='/images/Transparent.gif' onclick='loadCompanionPieces(\""+adType+"\",\""+date+"\","+(offset-5)+","+color+")'/>");
		else
			$('#prev-companion').html("");
		if(offset+5 < data.totalCount)
			$('#next-companion').html("<img class='tracker-icon small-next-icon center' src='/images/Transparent.gif' onclick='loadCompanionPieces(\""+adType+"\",\""+date+"\","+(offset+5)+","+color+")'/>");
		else
			$('#next-companion').html("");
	}
	gCompPieces = data.entries;
	gPortDesc = data.portfolioDescription;
 }

function loadDetailImage(color, id) {
	gcolor = color; //set param; also used in onloadCompleted handler
	if(id)
		gcurrAd = id; 
	var img = new Image();
	img.onload = CreateDelegate(img, onloadDetailImageComplete);
	img.src = getJpg();	
	updateArchiveDetailSelectBtn(gcurrAd, color);
}

function CreateDelegate(contextObject, delegateMethod)
{
    return function()
    {
        return delegateMethod.apply(contextObject, arguments);
    }
}

function onloadDetailImageComplete()
{
	$('#ad-image').html("<img src='"+getJpg()+"' style='max-width:345px;max-height:410px' class='center'/>");
	var img = $('#ad-image img');
	img.bind('click', {url:img.attr('src')}, showLargeImage);
	// img.unbind('mouseenter').unbind('mouseout').loupe();
	 
}

function updateArchiveDetailSelectBtn(id, color) {
	  var plannerId = $(eventSelectBox).val();
	  if(plannerId){
		  var parent = $('#select-btn').parent();
		  $('#select-btn').remove();//refresh html
		  parent.append("<div id='select-btn' class='itda-archive-icon select-btn' style='margin:5px 0px; float:left' onclick='selectPortfolioEntry("+id+","+plannerId+","+color+")'></div>");
		  //$('#select-btn').attr('onclick', 'selectPortfolioEntry('+id+','+plannerId+','+color+')')
	  		//		  .css('visibility','');	
	  }
}

function getPdf(download, id) {
	if (id == undefined)
		id = gcurrAd;
	var url = getPdfUrl(id,  download == true ? download : false , gcolor);
	if(download == false )
			window.open(url,'Print');
	else if( download == true) 
	{		
		window.location.href = url;
	} else { 
		return url;	
	}
}

function getJpg(download) {
	var url = getJpgUrl(gcurrAd,  download, gcolor);
	if(download) 		
		window.location.href = url;
	else 
		return url;
}

function getPdfUrl (id, download, color) {
	return '/archive/getPdf/' + id+ '?color=' + color +(download ? '&download=true' : '');	
}

function removeFavorite(e, id){
	var detailView;
	e.stopPropagation();
	if (id == undefined){ 
		id = gcurrAd;
		detailView = true;
	}
	
	if(gResultAssoArray['id='+id].favorite == undefined) return false;
	
	var data = itdaPostJson("/archive/removeFromFavorites/" + id,  {} , null);
	
	if (data.respText != 'Delete failed') { 
		  showArchiveInfoDialog(data.respText, gdiaglog);
    	  var html ="<div id='fav-icon-"+id+"' class='itda-archive-icon favorite-black-icon itda-off'  onclick='addToFavorites(event, "+id+")' onmouseover=\"toggleOverText("+id+", 'Add to your favorites', this)\" onmouseout=\"toggleOverText("+id+", '&nbsp;', this)\"></div>"; 
    	  var icon = $('#fav-icon-' + id);
    	  var parent = icon.parent();
    	  icon.attr('onmouseover','');
    	  icon.mouseout();
    	  toggleOverText(id, "&nbsp;", icon.get(0));
    	  icon.remove(); 
    	  parent.append(html);
    	  gResultAssoArray['id='+id].favorite = undefined;
    	  if(detailView) {
    		html = "<td><div class='itda-archive-icon add-favorite-icon' onclick='addToFavorites(event,undefined)'></div></td>" +
    		   	 	"<td class='align-bottom'><span onclick='addToFavorites(event,undefined);return false;'>Add to Favorites</span></td>";
    		$("#addFavorite").html(html);	  
    	  }
    	  if(document.forms['filter-form'].viewFilter.value == 'Favorites')
    		  $('#banner-text'+id).parent().hide();
    	 }else	
    		 showArchiveInfoDialog("Remove failed. Please try again later.", gdiaglog);	
	  return false;    		
}

var gdiaglog
function addToFavorites(e, id){
	e.stopPropagation();
	var detailView;
	if (id == undefined) {
		id = gcurrAd;
		detailView = true;
	}
	if(gResultAssoArray['id='+id].favorite != undefined) {
		  showArchiveInfoDialog('This piece has already been added.', gdiaglog);
		return false;
	}
	
	var postData = {};
	postData['color' + gcolor] = gcolor + 'C';
	var data = itdaPostJson("/archive/addToFavorites/" + id,  postData , null);
	
	if (data.respText != 'Add failed') { 
		showArchiveInfoDialog(data.respText, gdiaglog);	  
  	  var html ="<div id='fav-icon-"+id+"' class='itda-archive-icon favorite-black-icon itda-on'  onclick='removeFavorite(event, "+id+")' onmouseover=\"toggleOverText("+id+", 'Remove from your favorites', this)\" onmouseout=\"toggleOverText("+id+", '&nbsp;', this)\"></div>"; 
  	  var icon = $('#fav-icon-' + id);
  	  var parent = icon.parent();
  	  icon.attr('onmouseover','');
  	  icon.mouseout();
  	  toggleOverText(id, "&nbsp;", icon.get(0));
  	  icon.remove(); 
  	  parent.append(html);
  	  gResultAssoArray['id='+id].favorite = true;
  	  if(detailView != undefined) {
			  html = "<td><div class='itda-archive-icon add-favorite-icon' onclick='removeFavorite(event,undefined)'></div></td>" +
	     	 	"<td class='align-bottom'><span onclick='removeFavorite(event,undefined);return false;'>Remove From Favorites</span></td>";
    		$("#addFavorite").html(html);	  
  	  }
  	  if(document.forms['filter-form'].viewFilter.value == 'Favorites')
  		  $('#banner-text'+id).parent().show();
  	 }else	
  		showArchiveInfoDialog("Add failed. Please try again later.", gdiaglog);
	
}


var fcal, plannerDiag, addPlannerDate; 
function addToPlanner(evt){
	evt.stopPropagation();
	if(plannerDiag) {
		if(plannerDiag.dialog("isOpen"))
			return false;
		plannerDiag.dialog("open");
	}
	else {
		plannerDiag =$('#dialog-cal').dialog({ height: 'auto', width: 270, maxWidth: 270, resizable: false });
	
		plannerDiag.unbind('dialogclose')
		.bind('dialogclose',  function(event, ui) {
			  if(addPlannerDate == undefined)
				  return false;
			   var postData = {color:gcolor+'C', entryId:gcurrAd, addPlannerDate:addPlannerDate, size:gResultAssoArray['id=' + gcurrAd].adSizeCode};
  			   var classname = '#fc-day-' + addPlannerDate;
				$('div.fc-day-number').attr('style' , '');
				$(classname + ' div.fc-day-number').attr('style' , '');
			    addPlannerDate = undefined;
			    
				var data = itdaPostJson("/archive/addToPlanner",  postData , null);
				
				if (data.respText == 'Completed') { 
			      	if(data.respText ) 
			      		showArchiveInfoDialog("This piece has been added to your planner.", gdiaglog);
			      	 else 
			      		 showArchiveInfoDialog('Adding to planner failed.', gdiaglog);
			  	 }else	
		    		 showArchiveInfoDialog('Adding to planner failed.', gdiaglog);
			  
			  return false;    	
		});
		
		plannerDiag.unbind('click').bind('click',  function() {return false;});
	}
	
	if(!fcal)
	fcal = $('#fc-calendar').fullCalendar({
		theme: true,
		selectable: true, unselectAuto: false, weekMode: 'variable',
		titleFormat: {month: 'MMMM yyyy'}, columnFormat: { month: 'ddd'/* ,week: 'ddd M/d', day: 'dddd M/d'*/ },
		header: {left: 'prev', center: 'title', right: 'next'}, 
		select: function( startDate, endDate, allDay, jsEvent, view ) {
			addPlannerDate = $.fullCalendar.formatDate( startDate, 'yyyyMMdd');
			var classname = '#fc-day-' + addPlannerDate;
			$('div.fc-day-number').attr('style' , '');
			$('div.fc-day-number').removeClass('ui-active');
			$(classname + ' div.fc-day-number').addClass('ui-active');
			addPlannerDate = $.fullCalendar.formatDate( startDate, 'yyyy-MM-dd');
		}		
	});
	
  return false;    		
}

function showArchiveInfoDialog(content, diag) {
	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" ></span><br/>';
	showItdaInfoDialog(html + content, diag, 220, '70px');
}

var adType = "Direct Mail and Newspaper Marketing";
function filterAdType(element){
	if(element.value == "Direct Mail and Newspaper Marketing") {
		$('div.by-all').show();
		$('div.by-all input').attr('disable', false);
	}else if (element.value == "Direct Mail Marketing"){
		$('div.by-type').show();
		$('div.by-size').hide();
		$('div.by-type input').attr('disable', false);
		$('div.by-size input').attr('disable', true);
	}else{
		$('div.by-size').show();
		$('div.by-type').hide();
		$('div.by-type input').attr('disable', true);
		$('div.by-size input').attr('disable', false);
	}
	adType =  element.value;
	doSearch();
}

function showImage(img){
	var mheight = 229, mwidth = 192;
	var iheight = $(img).height(), iwidth= $(img).width();
	if(iheight > mheight || iwidth > mwidth) {
		//cal scaled factors
		if( (iheight / mheight) < (iwidth / mwidth) )
			$(img).css('position', 'absolute').css('bottom', '0px');
	} else if (iheight < mheight)
		$(img).css('position', 'absolute').css('bottom', '0px');
	//filter scroll bar
	var resulth = $('#results-bot').position().top - $('#results-top').position().top;
	
	var filterTop = $('#filters').position().top;
	var filterBot = $('#filters div#bottom').position().top;
	var filterBotH = $('#filters div#bottom').height();
	var filterH = filterBot - filterTop + filterBotH;
	if(resulth >= 812){
		$('#filters').css('max-height', resulth + 'px');
		if(filterH >= resulth){
			$('#filters').css('height', '100%');
		}else{
			$('#filters').css('height', '');
		}
	} else {
		$('#filters').css('max-height', '812px');
		$('#filters').css('height', '100%');
	}
}

function getTypeText(key) {
  if(key == 'NP') return 'Newspaper';
  if(key == 'DM') return 'Direct Mail';
}

function addToAssociativeArray(src, dest){
	for(var i=0; i<src.length; i++)
		dest['id=' + src[i].id] = src[i];
}


function displayReview(id) {

    var entry = findById(id, results);//archive results 
	var	html = "<img src='"+getJpgUrl(entry.id, false, entry.color)+"' style='max-height: 250px; max-width: 170px'/>";
	$('#reviewAdImage').html(html);
	var img = $('#reviewAdImage img');
	img.bind('click', {url:img.attr('src')}, showLargeImage);
	var type = getTypeText(entry.adTypeCode)+ ((entry.adTypeCode == 'NP') ? ' Ad' : '');
	html = '<br/><h3>'+gPortDesc+'</h3>'
	     +'<span style="text-transform:uppercase">'+type+'</span>';
	html += '<br/>'+getFileName(entry, entry.color);
	html += '<br/>'+getSizeText(entry.adSizeCode, entry.otherSize);
	html += '<br/>'+getColorText(entry.color)+'<br/>';
	html += '<br/><b>AVERAGE RATING</b><br/>';
	$('#reviewSummary').html(html);
	var ratingInfo = getRatingInfo(entry);
	  $('#review-rating').html(ratingInfo.html);
	  $('#review-rating-text').html('<div style="clear:both"/>'+ratingInfo.rating + ' based on '+entry.numRating+' rating'+ (entry.numRating > 1 ? 's' :'')  );

	 html =  entry.numReview + ' Customer Review' + (entry.numReview > 1 ? 's' :'') + ' for this ' + type;
	 $('#numReviews').html(html);
	 
	 if(!entry.reviews)
		 entry.reviews = getCustomerReviews(entry.id);
     $('#reviews').html(getCutomerReviewsHtml(entry.reviews, entry));
}

function showReviewComments(id, reviewId){
	$('#reviews').html("");
	$('#numReviews').html("");
    var entry = findById(id, results);//archive search results 
	var review = findById(reviewId, entry.reviews); //reviews for a archive result
	var html ="<span>Customer Review</span>";
	if(review.helpfulCount != 0 )
		 html =  review.helpfulCount + ' of ' + (review.helpfulCount + review.notHelpfulCount) + ' people found this review helpful.';
	$('#numReviews').html(html);
	if(review) {
		$('#reviews').html(getCutomerReviewsHtml([review], entry, true));
		if(!review.comments)
			review.comments = getComments(review.id);
		if(review.comments) {
			for(var k=0; k<review.comments.length; k++){
				if(k==0) 
					$('#reviews').append("<div id='comments'/>");
				else
					$('#comments').append("<div class='review-hr'/>");
				var date = $.fullCalendar.parseISO8601(review.comments[k][2]);
				$('#comments').append("<span style='color:#888888'>"+$.fullCalendar.formatDate(date, 'MMM d, yyyy')+"</span><br/>");
				$('#comments').append('<span style="color:#0076A3"><strong>'+htmlEncode(review.comments[k][1]) + ' says:<strong></span><br/>');
				$('#comments').append(htmlEncode(review.comments[k][0]).replace( /\n/g, '<br/>'));//comment
			}
			if(review.comments.length > 0)
				$('#reviews').append("<div class='review-hr'/>");
		}
	}
	var text;
	if(!review.comments || review.comments.length == 0){
		text ="Be the first to comment on this review";
	}else{
		text ="Leave a comment";		
	}
	html ="<div><span style='font-size:13px'><strong>"+text+"</strong></span><span style='float:right;text-decoration:underline;cursor:pointer' class='planner-detail-link-orange' onclick='reviewPolicy(event);return false;'>Our Comment Policy</span></div>";
	html += "<div class='review-hr'/><textarea id='comment'/><br/>"
	html += "<input type='submit' value='' class='itda-archive-icon add-comment-btn' onclick='addComment("+id+','+reviewId+")'/>";
	$('#reviews').append(html);
}

function getComments(rId){
	var xhr = itdaPost('/archive/getComments', {id:rId}, undefined, errorHandler, 'json');	
	var data = toJson(xhr);
	if(data.respText == 'Success')
		return data.list;
	else
		return null;				
}

function addComment(id, rId){
	var c = $('#comment').val();
	var xhr = itdaPost('/archive/addCommentForReview', {id:rId,comment:c}, undefined, errorHandler, 'json');	
	var data = toJson(xhr);
	if(data.respText == 'Save completed.') {
	    var entry = findById(id, results);//find in archive results 
		var review = findById(rId, entry.reviews); //find in reviews for a archive result	
		addToArr(data.comment, review.comments)
		showReviewComments(id, rId);
	}
}

function getCustomerReviews(id) {
	var xhr = itdaPost('/archive/getCustomerReviews', {id:id}, undefined, errorHandler, 'json');	
	var data = toJson(xhr);
	return data;
}

function wasHelpful(id, rId, val) {
	bindAjaxFunctions();
	var xhr = itdaPost('/archive/wasHelpful', {id:rId, vote:val}, undefined, errorHandler, 'json');	
	unbindAjaxFunctions();
	var data = toJson(xhr);
	if(data.respText == 'Success'){
	    var entry = findById(id, results);//find in archive results 
		var review = findById(rId, entry.reviews); //find in reviews for a archive result
		review.helpfulCount = data.helpfulCount;
		review.notHelpfulCount = data.notHelpfulCount;
	}
}

function getCutomerReviewsHtml(data, entry, comment) {
	var reviews = {my:'', others:''};

	for(var j=0; j<data.length; j++){
		var rev = data[j];
		var html = '';
		var date = $.fullCalendar.parseISO8601(rev.lastUpdated);
		if(!comment){
			var rating = getRatingInfo(rev);
			html += '<span style="font-size:13px;font-weight:bold">' + htmlEncode(rev.title) + '</span><br/>';
			html +=  rating.html + '<div style="clear:both"/>';
			//html +=  '<h3 style="color:#0076A3">By '+htmlEncode(rev.author)+' | '+htmlEncode(rev.location)+', '+ $.fullCalendar.formatDate(date, 'MMM d, yyyy') +' </h3><br/>';
			html +=  '<h3 style="color:#0076A3">'+ $.fullCalendar.formatDate(date, 'MMM d, yyyy') +' </h3><br/>';
		}else{
			html += '<span style="font-size:15px;font-weight:bold">' + htmlEncode(rev.title) + '</span> ';
			//html += '<span style="color:#0076A3;font-size:13px;font-weight:bold">By '+htmlEncode(rev.author)+' | '+htmlEncode(rev.location)+' , '+ $.fullCalendar.formatDate(date, 'MMM d, yyyy') +' </span><br/>';
			html += '<span style="color:#0076A3;font-size:13px;font-weight:bold">'+ $.fullCalendar.formatDate(date, 'MMM d, yyyy') +' </span><br/>';
		}
		html +=  '<div class="revText">'+htmlEncode(rev.review).replace( /\n/g, '<br/>') + '</div><b>';
		var separator = '';
		if(rev.calls) {
			html +=  +rev.calls + ' Call' + (rev.calls > 1 ? 's' :'');
			separator = ' | ';
		}
		if(rev.testsSet){
			html +=  separator + rev.testsSet + ' Tests Set';
			separator = ' | ';
		}
		if(rev.testsSold){
			html += separator +  rev.testsSold + ' Test' + (rev.testsSold > 1 ? 's' :'') + ' Sold';
			separator = ' | ';
		}
		if(rev.hearingAidsSold){
			html += separator +  rev.hearingAidsSold + ' Hearing Aid' + (rev.hearingAidsSold > 1 ? 's' :'') + ' Sold';
			separator = ' | ';
		}
		if(rev.testedNotSold){
			html += separator +  rev.testedNotSold + ' Tested-Not-Sold';
			separator = ' | ';
		}
		if(rev.grossSales && rev.grossSales != '0.0'){
			html += separator +  formatDollarAmount(rev.grossSales) + ' Gross Sales';
			separator = ' | ';
		}
		if(rev.returnOnInvest && rev.returnOnInvest != '0.0'){
			html += separator +  formatPercent(rev.returnOnInvest) + ' ROI';
			separator = ' | ';
		}
		if(rev.costPerLead && rev.costPerLead != '0.0')
			html += separator +  formatDollarAmount(rev.costPerLead) + ' Cost Per Lead';
		if(rev.costPerSale && rev.costPerSale != '0.0')
			html += separator +  formatDollarAmount(rev.costPerSale) + ' Cost Per Sale';

		if(separator != "") html += "<br/>";
		date = $.fullCalendar.parseISO8601(rev.runDate);
		var day = $.fullCalendar.formatDate(date, 'dddd');
		day = '<span style="text-transform:capitalize;">' + day.toLowerCase() + '</span>, ';
		day +=  $.fullCalendar.formatDate(date, 'MMMM d, yyyy');	
		html += 'Ran ' + day ;
		if(entry.adTypeCode == 'NP'){
			if(rev.placement != null)
				html +=' | ' + rev.placement +    ' Placement';
			if(rev.numberCompetitiveAd != null)
				html += ' | ' +rev.numberCompetitiveAd + ' Same-day Competitive Ads';
		}
		html += '<br/><br/></b>';
		if(!comment) {
			//html += "<div id='helpful'>Was this review helpful to you?&nbsp;&nbsp;&nbsp;<input type='submit' value='Yes' onclick='wasHelpful("+entry.id+","+rev.id+",\"Yes\")' style='padding:2px'/>&nbsp;&nbsp;<input type='submit' value='No' onclick='wasHelpful("+entry.id+","+rev.id+",\"No\")'/>"+
			//'&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a onclick="showReviewComments('+entry.id+','+rev.id+')" href="javascript:void(0)">' +
			html += '<a onclick="showReviewComments('+entry.id+','+rev.id+')" href="javascript:void(0)">' +
			'<span>'+
			'<input class="itda-archive-icon comment-icon" value="" type="submit" style="position:relative; top:5px;">'+
			'<span style="position:relative;top:5px">&nbsp;Comment</span>'+
			'</span></a></div>';
		}else
			html += '<br/>';
		html += "<div class='review-hr'></div>";
		
		if(rev.myReview)
			reviews.my += html;
		else
			reviews.others += html;
			
	}
	return reviews.my + reviews.others;
}