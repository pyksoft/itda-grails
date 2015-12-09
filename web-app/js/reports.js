$(document).ready(function() {
	$('#footer a').removeClass('gold');
	$('#footer a.myPlanner').addClass('gold');		

    accordion = $("div [id^='archive-accord']").accordion({
    	active: false, 
    	autoHeight: false,
    	collapsible:true
    });
	
	var tab = 0;
	$( "#tabs" ).tabs({
		 selected: tab,
		 create: function(event, ui) {
			var html = $('#tab0').html();
			$('#tab1').html(html);
			$('#tab2').html(html);
			$('#tab3').html(html);
			$('#tab4').html(html);
		 },
		 show: function(event, ui) {
			$( "#tabs" ).removeClass('ui-corner-all');
			$('div#tabs.ui-tabs ul.ui-tabs-nav li:last').css('margin-right', '0px');
			var show;
			var all = {'.showMarketing':1, '.showExpenses':1, '.showCompetition':1, '.showSales':1, '.showResults':1};
	        if( ui.index == 0 ) {
	            show = ".showMarketing";
	        }else if( ui.index == 1 ) {
	            show = ".showExpenses";
	        }else if( ui.index == 2 ) {
	            show = ".showCompetition";
	        }else if( ui.index == 3 ) {
	            show = ".showSales";
	        }else{ //( ui.index == 4 ) {
	            show = ".showResults";
	        }
	        updateCtxSensitiveReportTips(ui.index);
	        if(gActiveTab) 
	        	gHtmlAssoArr[gActiveTab] = $('#filter-form').serialize();//save form for prev tab
	        gActiveTab = "#tab" + ui.index;
	        for(var item in all)
	    		$(item).each(function(index, element) {
	    			var id = $(element).data('id');
	    			if($(id).html() != ''){
	    				gHtmlAssoArr[id] = $(id).html();
	    				$(id).html('');
		    			$(item).hide();
	    			}
	    		});	        		

	        $(show).each(function(index, element) {
    			var id = $(element).data('id');
    			//console.info(id + ";" + ($(id).html()=='') + ";" +$(id).attr('class'));
    			if($(id).html() == ''){
    				$(id).html(gHtmlAssoArr[id]);
	    			$(show).show();
    			}
    		});	
	        //if(gHtmlAssoArr[gActiveTab])  
	        //	$('#filter-form').deserialize(gHtmlAssoArr[gActiveTab]);
	        $('select option').removeAttr('selected');
	        $('input[type=checkbox]').removeAttr('checked');
	        $('input[name=tab]').val(show);
		    return true;
	    }		
	});
	
	if($.cookie('reportPopup') == '1') {
		gdiaglogSmall = $('#dialog-small').dialog({modal: true,  height: 'auto', width: 390, resizable: false , autoOpen : false});
    	var html = '<span><img class="dialog-close-btn" style="float:right" src="images/Transparent.gif" onclick="closeTrackerDialogs()"></span><br/>';
    	html += '<h3>Generating a report is easy.<br/><br/></h3>';
    	html += 'Click on the arrows to the left to select<br/>';
    	html += 'the variables you want to include in your<br/>';
    	html += 'report. You can also save your report by<br/>';
    	html += 'downloading a PDF to your computer or<br/>';
    	html += 'sending to your printer.<br/><br/>';
    	html += 'To return to where you started, just click<br/>';
    	html += 'the CLOSE REPORT button.<br/>';
    	showItdaInfoDialog(html, gdiaglogSmall);
		$.cookie('reportPopup', null, { expires: 0, path: '/myReport'});
		$.getJSON('/myAccount/updateSettings?reportPopup=1', {}, function(data) {});

	}
	$("input.dateinput" ).datepicker('destroy');
	$("input.dateinput" ).datepicker();
	
	$('#dialogAdImage').dialog({modal: true,  height: 'auto', width:'auto', resizable: false , autoOpen : false});
	
	$(document).unbind('click').bind('click', function() {
		$('#dialogAdImage').dialog('close');
	});	
	
	var calUtil =  new FullCalUtil('calUtil', null); 
	calUtil.setYearSelect($("#from_year"));
	calUtil.setMonthSelect($("#from_month"), true);	
	calUtil.setYearSelect($("#to_year"));
	calUtil.setMonthSelect($("#to_month"), true);	
});

function submitForm(formName){
	var report = $('a[href="'+gActiveTab+'"]').html();
	$('.criteria').html(report + " for " + buildCriteriaText());
    if(updateResultFlag == false)
    	$(formName + ' input[name=offset]').val(0);
    else
    	updateResultFlag = false;	
	var data = itdaPostJson("/myReport/generateReports", $(formName).serialize());
	if(data.respText == 'Success') {
		displayResults(data, gActiveTab);
	}else{
		data.results = [];
		data.total = 0;
		displayResults(data, gActiveTab);
	}
	return false;
	
}

function selectPeriod(period) {
	if(period.value == ""){
		$('.dateinput').val('');
		return;
	}
	var date = Date.parse(period.value, "M/d/yyyy");
	var month = 1 + date.getMonth();
	$('#from_month option[value="'+month+'"]').attr('selected','selected');
	$('#from_year option[value="'+date.getFullYear()+'"]').attr('selected','selected');

	date = date.add({months:2});
	month = 1 + date.getMonth();
	$('#to_month option[value="'+month+'"]').attr('selected','selected');
	$('#to_year option[value="'+date.getFullYear()+'"]').attr('selected','selected');
	
}

var total = 0; currPage=1, gResultAssoArr = [], updateResultFlag = false, gActiveTab = null, gHtmlAssoArr = [];
function displayResults(data, activeTab) {
	var results = data.results;
	total = data.total;
	var html ='', row=0;
	$(activeTab + ' .resultBody').html('');
	$(activeTab + ' .resultHeader').show();
	if(results.length == 0){
		html += "<tr><td style='height:435px;font-size:18px' class='result-left'><br/><br/><br/><b>Sorry, there are no results for your selections.<b/></td></tr>";
		$(activeTab + ' .headerNavRow').hide();
		$(activeTab + ' .noresult').show();
		$(activeTab + ' .resultFooter').hide();		
		$(activeTab + ' .resultBody').html(html);
	}else{
		var resultsLenM1 = results.length-1;//
		for(var i=0; i<results.length; i++){
				var col = i%5;//(numOfImg+j)%3;
		  		if(col == 0)
		  	  		html += "<tr id='row"+row+"'>";
		  	  	html +=  displayResultColum(results[i], col, row);
		  		if(col==4 || i==resultsLenM1 ){
		  			while(i == resultsLenM1 && col < 4) {
		  				html += '<td width="20%">&nbsp;</td>';
		  				col++;
		  			}
		  	  		row++;
		  	  		html += "</tr>";
		  		}
		}
		$(activeTab + ' .headerNavRow').show();
		$(activeTab + ' .noresult').hide();
		$(activeTab + ' .result').show();
		$(activeTab + ' .resultFooter').show();
		var totalPage = Math.ceil(total/document.forms['filter-form'].max.value);
		currPage = document.forms['filter-form'].offset.value/document.forms['filter-form'].max.value + 1;
		$(activeTab + " .gotopage," + activeTab + " .gotopage-bottom").html('');
		for(var i=0; i<=totalPage; i++)
			$(activeTab + " .gotopage," + activeTab + " .gotopage-bottom").append('<option value="'+i+'">'+ (i==0 ? ' ': i) );
		$(activeTab + ' .paginate,'+activeTab + ' .paginate-bottom').html('Page <b>'+ currPage +'</b> of ' + totalPage);
		$(activeTab + ' .resultBody').html(html);

		var preview
		$(activeTab + ' input[name="imagePreview"]').each(function(index, input) {
			if(input.checked==true)
			    preview = true; 
		});

		
		$(activeTab + ' img[id^="small-image-"]').each( function(index, image) {
			var img = $(image);
			img.bind('click', {url:img.attr('src')}, showLargeImage);
			if(preview)
				$(img).loupe(); 
		});		
	}
	
}

function displayResultColum(result, col, row) {
	var alignClass = 'center', html, image ="", rating="";
	if(col == 0) alignClass += ' result-left';
	else if (col == 4) 	alignClass += ' result-right';

	if(result.portfolioEntry){
		image = "<img src='"+getJpgUrl(result.portfolioEntry.id, undefined, result.portfolioEntry.color)+"' style='max-height:100%;max-width:100%' class='center' onload='showImage(this)' id='small-image-"+result.id+"'/>";
	} else { 
		var ctrl = '/myPlanner';
		if($('input[name=tab]').val().indexOf('Competition') > 0)
			ctrl = '/myTracker';
    	if(result.imageFile)
    		image = "<img src='"+ctrl+"/getImageFile/"+ result.id + "?token=" +escape(result.imageFile)+"'  style='max-height:100%;max-width:100%' class='center' onload='showImage(this)' id='small-image-"+result.id+"'/>";
    	else 
    		image ='';
	}
		
	if($('input[name="rating"]').get(0).checked)
		if(result.portfolioEntry){
			if(result.portfolioEntry.rating != 0){
				rating = "<div style='left:27px;position:relative'>"+getRatingInfo(result.portfolioEntry).html+"</div>";
				rating += "<div style='clear:both'>Based on " +result.portfolioEntry.numRating+ " rating" + (result.portfolioEntry.numRating > 1 ? "s" : "") + "</div>";
			}
			else
				rating = "<div style='color:#cccccc'>Not yet rated</div>"
		}
	
	var leftTdClass = (col == 0 || col == 4 ? " class='"+alignClass+"'" : "");
	var date = $.fullCalendar.parseDate(result.start);
	var title = getEventTypeTitle(result.className);
	var sizeColor = '';
	if($('input[name="size"]').get(0).checked)
		sizeColor += getSizeText(result.size, result.otherSize).replace(/vertical/gi, "V").replace(/horizontal/gi, "H");
	if($('input[name="color"]').get(0).checked){
		if(sizeColor != '') 
			sizeColor += ' | '
		sizeColor += getColorText(result.color).replace('-', ' ');
	}
	html =  "<td width='20%'"+leftTdClass+">"+
	  	"<div id='"+ result.id +"' class='result-container result-image " + alignClass + "'>" +
	  		"<div class='result-image-container'>"+image+"</div>"
	  		+"<b>"+title.substring(0, title.length-2).toUpperCase()+ "</b><br/>"
	  		+$.fullCalendar.formatDate(date,'MMMM dd, yyyy')+"<br/>";
	  		if(result.imageFile || result.portfolioEntry){
	  			var file =getFileName(result.portfolioEntry ? result.portfolioEntry : result, result.color);
	  			if(file && file.length > 16)
	  				file =  file.slice(0, 16) + '..';
	  			html+= file+'<br/>';
	  		}
	  		if(sizeColor != '')
	  			html+= sizeColor+'<br/>';
	  		var ele = $('input[name="includeTotalExpense"]');
	  		var sel = $('div.showExpenses select[name=totalExpense] option:selected'); 
	  		if( ( (ele.size() > 0 && ele.get(0).checked)
	  			   || (sel.size() > 0 && sel.val())
	  			)  && result.totalExpense)
	  			html += 'Expenses: '+formatDollarAmount(result.totalExpense)+'<br/>';
	  		sel = $('div.showSales select[name=grossSales] option:selected'); 
	  		if( sel.size() > 0 && sel.val() && result.grossSales)
	  			html += 'Gross Sales: '+formatDollarAmount(result.grossSales)+'<br/>';
	  		sel = $('div.showResults  select[name=returnOnInvest] option:selected'); 
	  		if( sel.size() > 0 && sel.val() && result.returnOnInvest)
	  			html += 'ROI: '+formatPercent(result.returnOnInvest)+'<br/>';
	  		sel = $('div.showResults  select[name=costPerSale] option:selected'); 
	  		if( sel.size() > 0 && sel.val() && result.costPerSale)
	  			html += 'CPS: '+formatDollarAmount(result.costPerSale)+'<br/>';
	  		sel = $('div.showResults  select[name=costPerLead] option:selected'); 
	  		if( sel.size() > 0 && sel.val() && result.costPerLead)
	  			html += 'CPL: '+formatDollarAmount(result.costPerLead)+'<br/>';
	  		sel = $('div[data-id=#competitorList]'); 
	  		if( sel.size() > 0 && result['competitor.id'])
	  			html += 'Competitor: '+getCompetitorName(result['competitor.id'])+'<br/>';
	  		if(rating != '')
	  			html += rating;
	  		ele = $('input[name="includeVendor"]'); 
	  		if(ele.size() > 0 && ele.get(0).checked  && (result['vendor.id'] || result['publication.id'])){
	  			var id = result['vendor.id'] ? result['vendor.id'] : result['publication.id'];
	  			html += 'Vendor: '+getReportVendorName(id, result.className)+'<br/>';
	  		}
	  		ele = $('input[name="placement"]')
	  		if(ele.size() > 0 && ele.get(0).checked && result.placement)
	  			html += 'Placement: '+result.placement;
		    html +="</div>";		     
	    html += "</div>"+
	  "</td>";
	  return html;
}

function updateResult(){
	updateResultFlag = true;
	submitForm("#filter-form");
}

function prev() { //result page
	var offset = $('input[name=offset]').val();
	var max = $('input[name=max]').val();
	if(offset - max >= 0) {
		$('input[name=offset]').val( offset - max);
		updateResult();
	}
}

function next() {//result page
	var offset = parseInt($('input[name=offset]').val());
	var max = parseInt($('input[name=max]').val());
	if( (offset + max) < parseInt(total)) {
		$('input[name=offset]').val( offset + max );
		updateResult();
	}
}

function resultsPerPage(anchor) {
	document.forms['filter-form'].max.value = anchor.innerHTML ;
	document.forms['filter-form'].offset.value = 0;
	$('.archive-link-active').attr('class', 'archive-link-default');
	anchor.setAttribute("class", "archive-link-active");
	updateResult();
	return false; 
}

function buildCriteriaText() {
	var searchCriteria, classNames = '', vendors = '',publications = '',
	competitors = '', offices = '', includes='';
	$('input[type="checkbox"]').each(function(index, input) {
		if(input.checked) {
			var name = input.name, value = ($(input).data('name') ? $(input).data('name') : input.value);
			if(name == 'className') {
				if(classNames != '')
					classNames += ', ';
				classNames += value; 		    
			}
			else if(name == 'competitors') {
				if(competitors != '')
					competitors += ', ';
				competitors += value; 		    
			}	
			else if(name == 'offices') {
				if(offices != '')
					offices += ', ';
				offices += value; 		    
			}	
			else if(name == 'vendors' || name == 'publications') {
				if(vendors != '')
					vendors += ', ';
				vendors += value; 		    
			}		
			else if(name == 'size' || name == 'color' || name == 'totalExpense'
				||name == 'rating' || name == 'placement') {
				if(includes != '')
					includes += ', ';
				includes += value; 		    
			}				
		}
	});
	
	searchCriteria = classNames != '' ? classNames : 'All Marketing Types ';
	if (competitors != '')
		searchCriteria += ' for ' + competitors;
	if (vendors != '')
		searchCriteria += ' for ' + vendors;
	if (offices != '')
		searchCriteria += ' for ' + offices;
	if (includes != '')
		searchCriteria += ' for ' + includes;
	value = $('select[name=period] option:selected').text();
	if(value != 'Select One...')
		searchCriteria += ' for ' + $.trim(value.replace(':', '')); 
	return searchCriteria;	
}
function getReportVendorName(id, className){
	//if($('#tmp').html() == '')
		$('#tmp').html(gHtmlAssoArr['#vendorList']);
	var name = (className == 'news-planner-event' ? 'publications' : 'vendors');
	var retVal = 'UNK';
	$('#tmp input[name='+name+']').each(function(index, input){
		if($(input).val() == id){
		 retVal = $(input).data('name');
		 return;
		}
	});
	return retVal;
}
function getCompetitorName(id){
	$('input[name=competitors]').each(function(index, input){
		if($(input).val() == id){
		 retVal = $(input).data('name');
		 return;
		}
	});
	return retVal;
}

function showImage(img){
	var mheight = 141, mwidth = 120;
	var iheight = $(img).height(), iwidth= $(img).width();
	if(iheight > mheight || iwidth > mwidth) {
		//cal scaled factors
	if( (iheight / mheight) < (iwidth / mwidth) )
			$(img).css('position', 'absolute').css('bottom', '0px').css('right', '0px');
	} else if (iheight < mheight)
		$(img).css('position', 'absolute').css('bottom', '0px').css('right', '0px');
}

/** jquery-nmx-deserialize
 * @return         jQuery object
 * @author         Thomas Junghans (thomas.junghans@namics.com)
 * @version        0.1
 */
(function ($) {
    $.fn.extend({
        deserialize : function (d, config) {
            var data = d,
                currentDom,
                $current = null,
                $currentSavedValue = null,
                $self = this,
                i = 0,
                keyValPairString = [],
                keyValPairObject = {},
                tmp = null,
                defaults = null;

            if (d === undefined || !$self.is('form')) {
                return $self;
            }

            defaults = {
                overwrite : true
            };

            config = $.extend(defaults, config);
            if (d.constructor === String) {
                d = decodeURIComponent(d.replace(/\+/g, " "));
                keyValPairString = d.split('&');
                for (i = 0; i < keyValPairString.length; i++) {
                    tmp = keyValPairString[i].split('=');
                    if(keyValPairObject[tmp[0]] === undefined)
                    	keyValPairObject[tmp[0]] = tmp[1];
                    else{
                    	if( keyValPairObject[tmp[0]] instanceof Array)
                    		keyValPairObject[tmp[0]][tmp[1]] = 'true';
                    	else {
                    		var val1 = keyValPairObject[tmp[0]];
                    		keyValPairObject[tmp[0]] = [];
                    		keyValPairObject[tmp[0]][val1] = 'true';
                    		keyValPairObject[tmp[0]][tmp[1]] = 'true';
                    	}
                    }
                    
                }
            }

            $('input, select, textarea', $self).each(function (i) {

                $current = $(this);
                currentDom = $current.get(0);
                $currentSavedValue = keyValPairObject[$current.attr('name')];

                if (currentDom.disabled === true) {
                    return true;
                }

                if ($current.is('textarea')) {
                    if ($currentSavedValue === undefined) {
                        $current.val('');
                    } else {
                        $current.val($currentSavedValue);
                    }
                    return true;
                }

                if ($current.is('select')) {
                    if ($currentSavedValue === undefined) {
                        return true;
                    } else {
                        for(var j=0; j<currentDom.options.length; j++)
                        	if(currentDom.options[j].value == $currentSavedValue){
                        		currentDom.selectedIndex = j;
                        		return true;
                        	}
                    }
                    return true;
                }

                if ($current.is('input:radio')) {
                    if ($currentSavedValue !== undefined) {
                        $current.each(function () {
                            if ($(this).val() === $currentSavedValue) {
                                $(this).get(0).checked = true;
                            }
                        });
                    }
                    return true;
                }

                if ($current.is('input:checkbox')) {
                    if($currentSavedValue instanceof Array)
                    	currentDom.checked = ($currentSavedValue[$current.val()] === 'true');
                    else
                    	currentDom.checked = ($current.val() === $currentSavedValue);
                    
                    return true;
                }

                if ($current.is('input:text, input:hidden')) {
                    if ($currentSavedValue === undefined) {
                        $current.val('');
                    } else {
                        $current.val($currentSavedValue);
                        return true;
                    }
                }
            });
            return $self;
        }
    });
}(jQuery));	

function updateCtxSensitiveReportTips(tabIndex){
    var tipFile;
    if(tabIndex === 0)
    	tipFile = 'tips-report-plan.gsp';
    else if(tabIndex === 1)
    	tipFile = 'tips-report-exp.gsp';    	
    else if(tabIndex === 2)
    	tipFile = 'tips-report-comp.gsp';   	
    else if(tabIndex === 2)
    	tipFile = 'tips-report-sale.gsp';
    else 
    	tipFile = 'tips-report-res.gsp';    	

    var tips = $("img.itda-archive-icon.tips-56-22");
	tips.attr("onclick", tips.attr("onclick").replace(/tips-.*.gsp/i, tipFile));
    var par = tips.parent(), tipsHtm = par.html();
	par.html(tipsHtm);
	$(gTipsDiag).dialog('destroy');
	gTipsDiag  = undefined;
}

