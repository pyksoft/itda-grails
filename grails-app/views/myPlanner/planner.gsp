<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <title>In the Door Advertising</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/itda.css" />
    <link rel="stylesheet" href="/css/fullcalendar-1.4.9.css" />
	<link rel="stylesheet" href="/css/sap-threecol.css" />
	<link rel="stylesheet" href="/css/jquery.jgrowl.css" />
	<link type="text/css" href="/jquery/css/smoothness/jquery-ui-1.8.7.custom.css" 	rel="stylesheet" />
	<script type="text/javascript" src="/jquery/js/jquery-1.4.4.min.js"></script >
	<script type="text/javascript" 	src="/jquery/js/jquery-ui-1.8.7.custom.min.js"></script>
	<script type='text/javascript' src='/js/simpleClass.js'></script>
	<script type='text/javascript' src='/js/fullCalUtil/calUtil.js'></script>
	<script type='text/javascript' src='/js/archive/archiveCtrl.js'></script>
	<script type='text/javascript' src='/js/myPlanner/plannerArchiveCtrl.js'></script>
	<script type='text/javascript' src='/js/myPlanner/myPlanner.js'></script>
	<script type='text/javascript' src='/js/fullcalendar-1.4.9.js'></script>
	<script type='text/javascript' src='/js/common.js'></script>
	<script type='text/javascript' src='/js/eventFetch.js'></script>
	<script type="text/javascript" src="/plupload156/js/plupload.full.js"></script>
	<script type="text/javascript" 	src="/loupe/jquery.loupe.js"></script>
	<script type='text/javascript' src='/js/jquery-ui-numeric.js'></script>
	<script type="text/javascript" src="/js/archive.js"></script>
	<script type="text/javascript" 	src="/js/listselect.min.js"></script>
	<script type='text/javascript' src='/js/gcal-1.4.9.js'></script>
	<script type='text/javascript' src='/js/jquery.cookie.js'></script>
	<script type='text/javascript' src='/js/jquery.ui.touch-punch.min.js'></script>
	<script type='text/javascript' src='/js/jquery.jgrowl.js'></script>
    </head>
    <body style='border-width:0px' id='planner-page'>
        <div>
			<g:include view="common/header.gsp" params="[controller:params.controller]"/>
       </div>
       <div style="background-image: url(/images/itd/planner/itda-planner-leather.jpg); background-repeat: repeat-y  repeat-x;width:1024px">
        <div class="body planner" >
			<div style='clear: both; height:10px'>
				<div id='tipsplanner' style='top:15px;position:relative;left:-10px;z-index:10;width:50px'><a href="#tips"><img onclick="showTips('#tipsDiag', '#tipsplanner', '/myPlanner/tips-main.gsp')" src="/images/Transparent.gif" class="tracker-icon tracker-tips" style='background-position:-5px -153px; width:55px'/></a></div>
				<div id='planner-reports' style='top:20px;position:relative;left:-10px;z-index:10;width:50px'><a href="/myReport"><img src="/images/Transparent.gif" class="tracker-icon tracker-reports" style='background-position:-5px -131px; width:55px'/></a></div>
			</div>
			
						<g:include view="myPlanner/plannerCalInc.gsp"/>				
						<g:include view="myPlanner/plannerDetailInc.gsp"/>		   
				        <div id="gPlannerDiag"></div>
	    </div>
	   </div>
  	  <g:include view="common/footer.gsp"/>
	  <div id="dialog-send-to-vendor" title="" style="font-size: 13; display: none; text-align:left;margin-left:0px;z-index:100000">
			<g:include view="myPlanner/sendToVendorInc.gsp"  />	  
	  </div>
	  <div id="dialog-small" class='transition-bg' title="" style="font-size: 13; display: none; text-align:left;z-index:100000"></div>
	  <div id="dialog-new-newspaperr" title="" style="font-size: 13; display: none; text-align:left; overflow-x:hidden;z-index:100000">
			<g:include view="myPlanner/newNewspaper.gsp" />	
	  </div>
	  <div id="dialog-new-vendor" title="" style="font-size: 13; display: none; text-align:left;z-index:100000">
			<g:include view="myPlanner/newVendor.gsp" />	
	  </div> 	
	<div id="tipsDiag" title="" style="display:none;padding:7px;background-color:rgb(255,253,228);font-size:12px;font-weight:bold">
		<div>
			<div onclick="$('#tipsDiag').dialog('close');" style="float:left;position:relative;top:-8px;left:-8px" class="itda-archive-icon tips-long"></div>
			<div onclick="$('#tipsDiag').dialog('close');" style="float:right" class="itda-archive-icon close-blue-icon"></div>
			<div style='clear:both;height:20px'></div>
		</div>
	</div>
	<div id='dialogAdImage' title="" style="display:none"><div id="dialogCloseBtn"><input type="submit" onclick="closeDialog('dialogAdImage');return false" value="" class="itda-archive-icon close-btn" /></div><div id="adImageLarge">&nbsp;</div></div>	   
    </body>	
</html>
