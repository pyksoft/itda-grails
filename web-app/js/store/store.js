var StoreController = Class.extend( {

		init : function(name, loadPrices) {
	        this.ctrlName = name;
			this.updateResultFlag = false;
			this.adType = "Direct Mail and Newspaper Marketing";
			this.companionOffset = 0;
			this.currAdColor = null;
			this.companionadType = null;
			this.payments = [];
			this.purchases = [];
			if(loadPrices)
				this.prices = this.itdaPostJson("/store/getPrices", {}, null);

			$('#doc').show();
			this.accordion = $("div [id^='archive-accord']").accordion( {
				active : false,
				autoHeight : false,
				collapsible : true
			});
			
			gdiaglog = $('#dialog').dialog( {//todo: fix global var
				height : 90, width : 300,
				maxHeight : 90, maxWidth : 300,
				resizable : false, autoOpen : false
			});
			
			this.dialogSmall = $('#dialog-small').dialog({
				modal: true,  height: 'auto', width: 350, maxWidth: 350, 
				resizable: false , autoOpen : false
			});
			
			this.dialogMap = $('#dialog-map').dialog({
				modal: true,  height: 'auto', width: 350, maxWidth: 350, 
				resizable: false , autoOpen : false
			});
			
			$('#dialogAdImage').dialog({modal: true,  height: 'auto', width:'auto', resizable: false , autoOpen : false});
			
			$(document).unbind('click').bind('click', function() {
				$('#dialog').dialog('close');
				$('#dialogAdImage').dialog('close');
			});
			
			$(document).data('ctrl', this);
		},
		
		enterStore: function (viewGroupFilter){
			  $('#splash').hide();
			  $('#body').show();
			  $('#' + viewGroupFilter + ' td.td-wolsp div').click();
			  if('All' == viewGroupFilter)
				  storeCtrl.doSearch(); 
			  $('form input[type="checkbox"]').css('border-width', "0");//ie issue
		},		

		toggleView : function (hide, show){//store specific, no tips to show/hide
			$(hide).hide();
			$(show).show();
		},	
				
		getDetailLinks4Result : function (result){//store specific: 1) html differ from archive
			var price = this.prices[result.adSizeCode];
			var html= "<table class='center'  style='padding-top:4px'><tr>";
	        html +="<td width='40%' style='text-align:right;font-size:14px;font-weight:bold;vertical-align:bottom'>$"+price+"</td>"+
	        	"<td width='60%'><div class='store-icon as-detail-btn' onclick='"+this.ctrlName+".toggleDetail("+result.id+","+result.color+");'></div></td>"+
	        "<tr></table>";
	        return html;			
		},	
		
		loadCompanionPieces: function (adType, date, offset, color){//store specific: 1) date  is now datetime 2) call store ctrl  
			this.companionOffset = offset;
			this.currAdColor = color;
			this.companionadType = adType;
			var dataString = 'adType=All&max=5&companion=true&fileName=&viewFilter=All&offset=' + offset;
			if(adType == 'NP')
				    dataString = dataString + '&adTypeOrder=DM'; 
			else
			    dataString = dataString + '&adTypeOrder=NP';
			dataString += '&portfolioDate=' +  date+'&color=' +  color;
		  	var results = itdaPostJson("/store/getStoreEntries", dataString, null);
		  	this.loadCompanionPiecesSuccess(results);
 
			  return false;    	
			
		},
		
		buyNow: function(event) {
			var me = $(document).data('ctrl'), html;
		    var s = screen_now_size();
		    margin_right = (s['width']-100)/2;
		    var state_layer = document.getElementById("processingStatus");
		    state_layer.style.right = margin_right+"px";
		    $(state_layer).show();
		    
			var data = me.itdaPostJson("/store/buyNow", {id:event.data.id}, null);
			if(data.payment && data.payment.ads) {
				for(var i=0; i < data.payment.ads.length; i++)
				me.payments['adId='+data.payment.ads[i].id] = 1;//cannot use this to reference self
				me.showAdPriceAndPurchaseInfo(event.data);
				html = '<span><img onclick="'+me.ctrlName+'.dialogSmall.dialog(\'close\')" src="images/Transparent.gif" style="float:right" class="dialog-close-btn"></span><br>'
				+'<br/><h4 style="text-align:center">Thank you for your purchase.<br/></h4>'
				+'<div style="text-align:center;line-height:165%">The files for 1, 2 and 4 color ads are being downloaded<br> into your Archive.<br/><br/>'
				+'<img src="images/Transparent.gif" class="store-icon as-arrows-icon center"></div><br/>';
			}else{
				html = '<span><img onclick="'+me.ctrlName+'.dialogSmall.dialog(\'close\')" src="images/Transparent.gif" style="float:right" class="dialog-close-btn"></span><br>'
							+'<br/><h4 style="text-align:center">Sorry.<br/></h4>'
							+'<div style="text-align:center;line-height:165%">'+data.error+'<br/><br/>'
							+'<img src="images/Transparent.gif" class="store-icon as-excl-icon center"></div><br/>';
			}
			showItdaConfirmDialog(html, me.dialogSmall, 580);
		    $(state_layer).slideUp();
		},
		
		
		showAdPriceAndPurchaseInfo: function(result){
			  var isPurchased; 
			  var price = this.prices[result.adSizeCode];
			  if(price){
				  $("#adPrice").html("$"+price);
				  $("#buyBtn").unbind('click');
				  if(this.payments['adId='+result.id] == undefined){
					 var resp = this.itdaPostJson("/store/isPurchased", {adId:result.id}, null);
					 this.payments['adId='+result.id] = resp.isPurchased;
				  }
				  if(this.payments['adId='+result.id]) {
					  $("#buyBtn").addClass("itda-off");
				      $(".paid-item").show();
				  }else{
				      $(".paid-item").hide();
					  $("#buyBtn").removeClass("itda-off");
					 $("#buyBtn").bind('click', result, this.buyNow);
				  }
			  }else{
				  $("#adPrice").html("");
			  }
			  var html;
			  if(this.purchases['adId='+result.id] == undefined)  {
				  var resp = this.itdaPostJson("/store/purchasesWithin50Miles", {adId:result.id}, null);
 				  this.purchases['adId='+result.id] = resp.purchases;
			  }
			  if(this.purchases['adId='+result.id].length == 0){
				  html = "This ad has not been used within<br/>a 50 mile radius of your offices."
			  }else{
				  //var date = $.fullCalendar.parseDate(officeList[0].purchasedDate);
				  var date = $.fullCalendar.parseDate(this.purchases['adId='+result.id][0].purchasedDate);
				  date = $.fullCalendar.formatDate(date, 'MMMM dd, yyyy'); 
				  html = "This ad was last downloaded on " +date+ " within a 50 mile radius of your offices.&nbsp;&nbsp;&nbsp;&nbsp;"
					  + "<a href='javascript:void(0)' onclick='showMap("+this.ctrlName+".purchases[\"adId="+result.id+"\"])' >View Map</a>";
			  }
			  $("#adMsg").html(html);			
		},
		
		toggleDetail: function (id, color) {
			  if(id == undefined) {
				  this.toggleView('.result-detail','#search-result');
				  return false;
			  }
			  console.info('id is ' + id);
			  var result; 
			  for(var i=0; i<results.length; i++)
				  if(id == results[i].id) {
					  result = results[i];
					  if(!color) //state store in this.currAdColor
						  this.currAdColor = color = result.color;
					  else 
						  this.currAdColor = color; 
					this.currAdId =  id;
					var prev = results[i-1] ? this.ctrlName+'.toggleDetail('+results[i-1].id+','+this.currAdColor+ ');' : undefined;
					var next = results[i+1] ? this.ctrlName+'.toggleDetail('+results[i+1].id+','+ this.currAdColor+');' : undefined;
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
			  this.showDetailOfResult(result.id, result, color);
			  this.loadCompanionPieces(result.adTypeCode, result.portfolioDate, 0, color);
			  return false;
		},
		
		showDetailOfResult: function (id, result, color) { //store specific: 1) price info
			if(result == undefined) { 
				  for(var i=0; i<gCompPieces.length; i++)//user select companion piece
					  if(id == gCompPieces[i].id) {
						  result = gCompPieces[i];
						  break;
					  }
			}
			if(color == undefined )
				color = gcolor;

			  this.toggleView('#search-result', '.result-detail');
			  loadDetailImage(color, result.id);
			  $('#ad-type').html(getTypeText(result.adTypeCode));
			  $('#ad-file').html(getFileName(result, color));
			  $('#ad-size').html(getSizeText(result.adSizeCode, undefined));
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
				  $('#ad-rating-link').html('<a href="javascript:void(0);" onclick="showReview('+result.id+')">'+result.numReview+' Customer Review'+ (result.numReview > 1 ? 's' :'')+'</a>');
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
			  
			  this.showAdPriceAndPurchaseInfo(result);//store specific
			  
		},
		
		doSearch: function() {

			this.toggleView('.result-detail', '#search-result');

			if (this.updateResultFlag == false)
				document.forms['filter-form'].offset.value = 0;
			else
				this.updateResultFlag = false;

			var results = itdaPostJson("/store/getStoreEntries", $("form[name='filter-form']").serialize(), searchSuccess);
			searchSuccess(results);
		},

		resultsPerPage : function(anchor) {
			document.forms['filter-form'].max.value = anchor.innerHTML;
			document.forms['filter-form'].offset.value = 0;
			$('.archive-link-active').attr('class', 'archive-link-default');
			anchor.setAttribute("class", "archive-link-active");
			this.updateResultFlag = true; // offset is set
			this.doSearch();
			return false;
		},
		
		goToPage: function (select){
			if(select.selectedIndex == 0 || select.selectedIndex == currPage) return
			document.forms['filter-form'].offset.value = document.forms['filter-form'].max.value * (select.selectedIndex -1);
			this.updateResultFlag = true; // offset is set
			this.doSearch();
		}, 		
		
		prev: function () { // result page
			if(parseInt(document.forms['filter-form'].offset.value) - parseInt(document.forms['filter-form'].max.value) >= 0) {
				document.forms['filter-form'].offset.value = parseInt(document.forms['filter-form'].offset.value) - parseInt(document.forms['filter-form'].max.value);
				this.updateResultFlag = true; // offset is set
				this.doSearch();
			}
			else
				return false;
		},
			
		next:	function () {// result page
			if(parseInt(document.forms['filter-form'].offset.value) + parseInt(document.forms['filter-form'].max.value) < total) {
				document.forms['filter-form'].offset.value = parseInt(document.forms['filter-form'].offset.value) + parseInt(document.forms['filter-form'].max.value);
				this.updateResultFlag = true; // offset is set
				this.doSearch();
			}
			else
				return false;
		}, 		

		updateViewGroupFilters: function (element, filterVal) {
			if(view != filterVal){
				view = filterVal;
				$('tr.view-filter-ui td').removeClass('itda-on').addClass('itda-off');
				$(element).parent().parent().children().toggleClass('itda-off itda-on');
				document.forms['filter-form'].viewFilter.value = filterVal;
				this.doSearch();
			}
		}, 	
		
		filterAdType: function (element){
			if(element.value == "Direct Mail and Newspaper Marketing"){
				$('div.by-all').show();
				$('div.by-all input').removeAttr('disabled');
			}else if (element.value == "Direct Mail Marketing"){
				$('div.by-type').show();
				$('div.by-type input').removeAttr('disabled');
				$('div.by-size').hide();
				$('div.by-size input').attr('disabled', 'disabled');
			}else{
				$('div.by-size').show();
				$('div.by-size input').removeAttr('disabled');
				$('div.by-type').hide();
				$('div.by-type input').attr('disabled', 'disabled');
			}
			this.adType = element.value;  //TODO move global variable into class
			adType = element.value;
			this.doSearch();
		},		
		
		itdaPostJson : itdaPostJson,

		errorHandler : function(data1, data2, data3) {
		},
		
	    clearSearch: function() {
	    	$('div#filters input[type="checkbox"]').attr('checked', false);	
	    	$('div#filters input[type="text"]').val('');
	    	$('div#filters select').find('option:first').attr('selected','selected');
	    	var id = $('div#views .view-filter-ui .td-wolsp.itda-on').parent().attr('id');
	    	if(id == 'All')
	    		doSearch();
	    	else
	    		$('.tracker-calendar-link').click();
	    },		
		
		loadCompanionPiecesSuccess: function (data, textStatus, XMLHttpRequest) {
		    $('#companionPieces').html('');
		    var i, entries = data.entries;

			if (entries && entries.length > 0) { 
		        var date, ctrl = $(document).data('ctrl');
				$('#ad-desc').html(data.portfolioDescription);
				var html="", len = Math.min(5, entries.length);
				for(i=0; i<len; i++) {
		            if(!date) date = entries[i].portfolioDate;
		            
					if (entries[i].id == this.currAdId) {
						html += "<td width='20%'>&nbsp;</td>";//self
						continue;
					}
						
					html += "<td width='20%' style='font-weight:500;color:black;padding-left:15px'>" +
							"<div style='position:relative;height:160px'><div style='position:absolute;bottom:0'>" +
						"<img src='"+getJpgUrl(entries[i].id, undefined, ctrl.currAdColor)+"' onclick='"+ctrl.ctrlName+".showDetailOfResult("+entries[i].id+")' width='90%' style='margin-bottom:5px;max-width:100%;max-height:175px'/>"
						+ "</div></div>"
					 + getTypeText(entries[i].adTypeCode)
					+ '<br/>' + getSizeText(entries[i].size, entries[i].otherSize)
										
					+"</td>";
				}
				while(i<len)
					html += "<td width='20%'>&nbsp;</td>";

				$('#companionPieces').append(html);

				if(this.companionOffset-5 >= 0)
					$('#prev-companion').html("<img class='tracker-icon small-prev-icon center' src='/images/Transparent.gif' onclick='"+this.ctrlName+".loadCompanionPieces(\""+this.companionadType+"\",\""+date+"\","+(this.companionOffset-5)+","+this.currAdColor+")'/>");
				else
					$('#prev-companion').html("");
				if(this.companionOffset+5 < data.totalCount)
					$('#next-companion').html("<img class='tracker-icon small-next-icon center' src='/images/Transparent.gif' onclick='"+this.ctrlName+".loadCompanionPieces(\""+this.companionadType+"\",\""+date+"\","+(this.companionOffset+5)+","+this.currAdColor+")'/>");
				else
					$('#next-companion').html("");
			}
			gCompPieces = entries; //TODO
			gPortDesc = data.portfolioDescription;
					
		 }		

});

function showReview(id){
	$('table#search').hide();
	$('table#review').show();
	displayReview(id);
}

function backToDetails(){
	$('table#review').hide();
	$('table#search').show();
}


function searchSuccess (data) {
	if (data.entries) {
		results = data.entries;
		total = data.totalCount;
		gResultAssoArray = [];
		addToAssociativeArray(results, gResultAssoArray);
		for ( var i = 0; i < data.favorites.length; i++)
			gResultAssoArray['id=' + data.favorites[i]].favorite = 'true'
		if (document.forms['filter-form'].viewFilter.value == 'Favorites')
			for ( var i = 0; i < results.length; i++)
				results[i].favorite = 'true'
		displayResults(
				results,
				data.dates,
				document.forms['filter-form'].offset.value
						/ document.forms['filter-form'].max.value
						+ 1,
				document.forms['filter-form'].max.value);
	}
}

function searchError(jqXHR, textStatus, errorThrown) {
	$('.resultsheader').show();
	$('#resultBody')
			.html(
					'<br/><br/><h3> Search failed: ' + textStatus + '</h3>');
	$('.resultsfooter').hide();
}

function itdaPostJson(url, data, sCallback, eCallback) {
	$.ajaxSetup( {
		"async" : false
	});
	var xhr = $.post(url, data, sCallback,'json');
	$.ajaxSetup( {
		"async" : true
	});
	if (xhr.status == 401) {
		window.location.href = '/helper/login'
		return;
	}
	if(sCallback)
		return;
	
	var json = (new Function("return( " + xhr.responseText + " );"))();
	return json;
}

//////////////////////////////////////////////////////////

function showMap(officeList) {
  var me = $(document).data('ctrl');
  showMapDialog(me.dialogMap, 900);
  if(! me.map) {
	  var latlng = new google.maps.LatLng(37.71859032558813,-95.44921875);
	  var myOptions = {
	    zoom: 4,
	    center: latlng,
	    draggable: true,
		  navigationControl: true,
		  mapTypeControl: false,
		  scaleControl: true,	      
	    mapTypeId: google.maps.MapTypeId.ROADMAP
	  }
	  var map = new google.maps.Map(document.getElementById("map"), myOptions);
	  me.map = map;
	  me.markers = [];
  }
  
  if(me.markers.length > 0){
	  for(var i=0; i<me.markers.length; i++)
		  me.markers[i].setMap(null);
	  me.markers = [];
  }

  var bounds, center;

	var currPt,lat, lng, marker;
	var first = true;
	if(officeList) {
		for(var i=0; i<officeList.length; i++) {
		    lat = officeList[i].lat;
		    lng = officeList[i].lon;
			center =  new google.maps.LatLng(lat, lng);
			if(i == 0)
				   bounds = new google.maps.LatLngBounds( center, new google.maps.LatLng(lat + 0.03, lng + 0.1));
			else
				bounds.extend(center); 
        	marker = new google.maps.Marker({map: me.map, position: center});
        	me.markers.push(marker);
		}
		me.map.fitBounds(bounds);
		me.map.setCenter(bounds.getCenter());
	}
	var date = $.fullCalendar.parseDate(officeList[0].purchasedDate);
	date = $.fullCalendar.formatDate(date, 'MMMM dd, yyyy');
	$("#mapTitle").html("This piece was last downloaded on "+ date +" for these areas.");

}

function showMapDialog(diag, width) {
	if(width)
		diag.dialog( "option", "width", width );
	$(diag).parent().css("background-color", "white");
	diag.dialog( "option", "modal", true )
				.dialog('open')
				.removeClass('ui-dialog-content ui-widget-content')
				 .prev().remove();
}

function screen_now_size(){ // get screen current size
    var a=new Array();
    if(typeof document.compatMode!='undefined'&&document.compatMode!='BackCompat'){
      a["width"]=document.documentElement.clientWidth;
    }else{
      a["width"]=document.body.clientWidth;
    }
    return a;
}