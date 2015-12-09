<!DOCTYPE HTML>
<html>
<head>
<title>In the Door Advertising</title>
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet" href="/css/itda.css" />
<link rel="stylesheet" href="/css/sap-threecol.css" />
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
<script type='text/javascript' src='/js/simpleClass.js'></script>
<script type='text/javascript' src='/js/store/store.js'></script>
<script type='text/javascript' src='/js/common.js'></script>
<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type='text/javascript'><!--
var storeCtrl;
$(document).ready(function() {	
	$('#footer a').removeClass('gold');
	$('#footer a.store').addClass('gold');	
	storeCtrl = new StoreController('storeCtrl', true);
	//storeCtrl.doSearch();	
});

function getDetailLinks4Result(result){
	return  storeCtrl.getDetailLinks4Result(result);   
}

--></script>
</head>
<body style='border-width:0px'>

<div id='doc' style='display:none'>
	<div><g:include view="common/header.gsp" params="[controller:params.controller]"/></div>
	<div
		style="width:100%;background-image: url(/images/itd/planner/itda-planner-leather-long.jpg); background-repeat: repeat-x repeat-y;">
    <div id="splash" style="width:1022px;border:1px solid;background:white;font-size:12px;font-weight:bold;clear:both">
       <table cellspacing="0" cellpadding="0" border="0" class="result-detail" style="display: table;">
        <tbody><tr>
          <td onclick='storeCtrl.enterStore("All")' style="cursor: pointer;">
             <div style="float:right; line-height:20px;color:#555555"><b>&nbsp;What's New at the AD STORE</b></div>
             <div style="float:right" class="tracker-calendar-link"></div>
          </td>
          <td onclick='storeCtrl.enterStore("highestRated");' style="cursor: pointer;">
             <div style="float:right; line-height:20px;color:#555555"><b>&nbsp;Highest Rated</b></div>
             <div style="float:right" class="itda-archive-icon rating-black-icon"></div>
          </td>
          <td onclick='storeCtrl.enterStore("mostDownloaded");' style="cursor: pointer;">
             <div style="float:right; line-height:20px;color:#555555"><b>&nbsp;Most Downloaded</b></div>
             <div onclick="toggleDetail()" style="float:right" class="itda-archive-icon download-black-icon"></div>
          </td>
        </tr>
      </tbody></table>
      <a onclick='storeCtrl.enterStore("All")' href="javascript:void(0)"><img src="images/itda_AdStoreHomePage.jpg" style="width:1022px"></a>
    </div>		
		<div id="body" style="display:none">
			<div style='clear: both'></div>
				<g:include view="store/storeIncl.gsp" />
				<g:include view="store/storeReviewIncl.gsp" />
			<div style='clear: both; height:1px'></div>
		</div>
	</div>
</div> <%-- doc --%>
<g:include view="common/footer.gsp"/>
<div id="dialog" title="" class='transition-bg-short' style="font-size:13;display:none;text-align:left;min-height:70px"></div>
<div id="dialog-small" class="transition-bg" title="" style="font-size: 13; display: none; text-align:left;"></div>   
<div id="dialog-map" title="" style="font-size: 13; display: none; text-align:left;background-color:white">
	<div><span><img onclick="storeCtrl.dialogMap.dialog('close')" src="images/Transparent.gif" style="float:right;margin:10px 10px 0 0" class="dialog-close-btn"></span></div>
	<div><h4 style="text-align:center;clear:both;postion:relative;top:-5px;line-height:100%" id="mapTitle"></h4></div>
	<div style="width:850px;height:650px;margin:10px 0 25px 25px" id="map"></div>
</div>
<div id='dialogAdImage' title="" style="display:none"><div id="dialogCloseBtn"><input type="submit" onclick="closeDialog('dialogAdImage');return false" value="" class="itda-archive-icon close-btn" /></div><div id="adImageLarge"></div></div>
<div id="processingStatus">proccessing...</div>
</body>
</html>


