<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN">
<html>
<head>
<title>In the Door Advertising</title>
<link rel="stylesheet" href="/css/jquery.jgrowl.css">
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet" href="/css/itda.css" />
<link rel="stylesheet" href="/css/sap-threecol.css" />
<style type="text/css">
.learn.more {color:#0076A3; text-decoration:underline; font-style:italic}
td.archive-left-col.my-upload, td.archive-left-col.my-upload > form > table, table.marketing-type{width:100%}
.archive-left-col.my-upload h1 {margin:0; line-height:110%; font-size:20px}
.archive-left-col.my-upload h3 {margin:0; line-height:110%; margin:7px 0}
.archive-left-col.my-upload tr td {padding:1px}
.archive-left-col.my-upload tr td.bottom {vertical-align:bottom; width:15%}
.archive-left-col.my-upload tr td.middle {vertical-align:middle; width:25%; padding:0px}
.archive-left-col.my-upload table::nth-of-type(1) tr td:nth-of-type(2) {width:100%}
#progressBar {border-radius:0}
#progressBar .ui-progressbar-value {background:#0076A3; }
.checked-box-icon{background-position:-222px -66px; height:22px;width:22px;float:right}	
.select-pdf-btn{background-position:-66px -212px; height:19px;width:70px;float:left;margin-left:10px}	
.select-jpg-btn{background-position:-72px -231px; height:19px;width:70px}	
.back-red-btn{background-position:-2px -174px; height:19px;width:61px;float:left}
.next-red-btn{background-position:-152px -32px; height:19px;width:61px;float:left}
.edit-gray-btn{background-position:-2px -231px; height:19px;width:70px}
.cancel-gray-btn{background-position:-66px -70px; height:19px;width:64px;float:right}
.delete-red-btn{background-position:-2px -212px; height:19px;width:64px;float:right}
.up2-archive-btn{background-position:-11px -438px; height:23px;width:164px}
</style>
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link type="text/css" href="/jquery/css/smoothness/jquery-ui-1.8.7.custom.css" 	rel="stylesheet" />
<script type="text/javascript" src="/jquery/js/jquery-1.4.4.min.js"></script >
<script type="text/javascript" 	src="/jquery/js/jquery-ui-1.8.7.custom.min.js"></script>
<script type='text/javascript' src='/js/jquery-ui-numeric.js'></script>
<script type="text/javascript" 	src="/loupe/jquery.loupe.js"></script>
<script type='text/javascript' src='/js/fullcalendar-1.4.9.js'></script>
<script type='text/javascript' src='/js/eventFetch.js'></script>
<script type='text/javascript' src='/js/archive.js'></script>
<script type='text/javascript' src='/js/common.js'></script>
<script type='text/javascript' src='/js/simpleClass.js'></script>
<script type='text/javascript' src='/js/archive/archiveCtrl.js'></script>
<script type="text/javascript" src="/plupload156/js/plupload.full.js"></script>
<script src="/js/jquery.jgrowl.js" type="text/javascript"></script>
<script type='text/javascript'><!--
var archCtrl; 
$(document).ready(function() {	
	$('#footer a').removeClass('gold');
	$('#footer a.myArchive').addClass('gold');
	archCtrl = new ArchiveUploadController();	
	initArchive(false, archCtrl);
	 $('form input[type="checkbox"]').css('border-width', "0");//ie issue
});

function getDetailLinks4Result(result){
	var html="<div id='result-hover-"+result.id +"' style='margin:3px 0px 0px 0px; color:#0076A3'>&nbsp;</div>"+
        "<table class='center'><tr>";
    var view = document.forms['filter-form'].viewFilter.value.toLowerCase().replace(' ', '-');
  	if(view != 'favorites' && (gResultAssoArray['id='+result.id] == undefined 
  	    							|| gResultAssoArray['id='+result.id].favorite == undefined))
        	html +="<td><div id='fav-icon-"+result.id+"' class='itda-archive-icon favorite-black-icon itda-off'  onclick='addToFavorites(event, "+result.id+")' onmouseover=\"toggleOverText("+result.id+", 'Add to your favorites', this)\" onmouseout=\"toggleOverText("+result.id+", '&nbsp;', this)\"></div></td>"; 
    else            		 
        	html +="<td><div id='fav-icon-"+result.id+"' class='itda-archive-icon favorite-black-icon itda-on' onclick='removeFavorite(event,"+result.id+")' onmouseover=\"toggleOverText("+result.id+", 'Remove from your favorites', this)\" onmouseout=\"toggleOverText("+result.id+", '&nbsp;', this)\"></div></td>"; 
        html +="<td><div class='itda-archive-icon download-black-icon itda-off'  onclick='getPdf(true,"+result.id+" )' onmouseover=\"toggleOverText("+result.id+", 'Download PDF', this)\" onmouseout=\"toggleOverText("+result.id+", '&nbsp;', this)\"></div></td>"+
        	"<td><div class='itda-archive-icon detail-gray-icon itda-off' onclick='toggleDetail("+result.id+","+result.color+" )' onmouseover=\"toggleOverText("+result.id+", 'Detail view', this)\" onmouseout=\"toggleOverText("+result.id+", '&nbsp;', this)\"></div></td>"+
        "<tr></table>"+
    	"</div>";	
    return html;
}
--></script>
</head>
<body style='border-width:0px'>

<div id='doc' style='display:none'>
	<div><g:include view="common/header.gsp" params="[controller:params.controller]"/></div>
	<div
		style="width:1024px;background-image: url(/images/itd/planner/itda-planner-leather-long.jpg); background-repeat: repeat-x repeat-y;">
		<div id="body" >
			<div style='clear: both'></div>
			<g:include view="archive/archiveIncl.gsp" />
			<g:include view="archive/archiveReviewIncl.gsp" />
			<g:include view="archive/archiveUploadIncl.gsp" />
			<div style='clear: both; height:1px'></div>
		</div>
	</div>
</div> <%-- doc --%>
<g:include view="common/footer.gsp"/>
<div id="dialog" title="" class='transition-bg-short' style="font-size:13;display:none;text-align:left;min-height:70px"></div>
<div id="dialogBigger" title="" class='transition-bg' style="font-size:13;display:none;text-align:left;min-height:70px"></div>
<div id="tipsDiag" title="" style="display:none;padding:7px;background-color:rgb(255,253,228);font-size:12px;font-weight:bold">
	<div>
		<div onclick="$('#tipsDiag').dialog('close');" style="float:left;position:relative;top:-8px;left:-8px" class="itda-archive-icon tips-long"></div>
		<div onclick="$('#tipsDiag').dialog('close');" style="float:right" class="itda-archive-icon close-blue-icon"></div>
		<div style='clear:both;height:20px'></div>
	</div>
</div>
<div id='dialogAdImage' title="" style="display:none"><div id="dialogCloseBtn"><input type="submit" onclick="closeDialog('dialogAdImage');return false" value="" class="itda-archive-icon close-btn" /></div><div id="adImageLarge"></div></div>
</body>
</html>
