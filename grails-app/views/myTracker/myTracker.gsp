<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html><head>
	<title>In the Door Advertising</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" href="/css/main.css" />
	<link rel="stylesheet" href="/css/itda.css" />
	<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
	<link type="text/css" href="/jquery/css/smoothness/jquery-ui-1.8.7.custom.css" 	rel="stylesheet" />
	<script type="text/javascript" src="/jquery/js/jquery-1.4.4.min.js"></script >
	<script type="text/javascript" 	src="/jquery/js/jquery-ui-1.8.7.custom.min.js"></script>
	<script type='text/javascript' src='/js/simpleClass.js'></script>
	<script type='text/javascript' src='/js/fullCalUtil/calUtil.js'></script>
	<script type='text/javascript' src='/js/fullcalendar-1.4.9.js'></script>
	<script type='text/javascript' src='/js/date.js'></script>
	<link rel="stylesheet" href="/css/fullcalendar-1.4.9.css" />
	<script type='text/javascript' src='/js/jquery-ui-numeric.js'></script>
	<link rel="stylesheet" href="/css/jquery-ui-numeric.css" />
	
	<script type="text/javascript" src="/js/common.js"></script>
	<link rel="stylesheet" href="/css/sap-threecol.css" />
	<script type="text/javascript" src="/js/eventFetch.js"></script>
	<script type="text/javascript" src="/js/archive.js"></script>
	<script type='text/javascript' src='/js/archive/archiveCtrl.js'></script>	
	<script type='text/javascript' src='/js/myPlanner/plannerArchiveCtrl.js'></script>	
	<script type="text/javascript" src="/plupload156/js/plupload.full.js"></script>
	<script type='text/javascript' src='/js/tracker-gcal-1.4.9.js'></script>
	<script type='text/javascript' src='/js/myTracker/compCal.js'></script>
	<script type='text/javascript' src='/js/jquery.cookie.js'></script>
	<script type='text/javascript' src='/js/jquery.ui.touch-punch.min.js'></script>

    </head>
    <body id='tracker-page' style='border-width:0px'>
        <div>
			<g:include view="common/header.gsp" params="[controller:params.controller]"/>
       </div>
       <div style="background-image: url(/images/itd/planner/itda-planner-leather.jpg); background-repeat: repeat;width:1024px">
        <div class="body tracker" >
			<div style='clear: both; height:10px'>
				<div id='trackertips' style='top:15px;position:relative;left:-10px;z-index:10;width:57px'>
					<a href="#tips"><img onclick="showTips('#tipsDiag', '#trackertips', '/myTracker/tips-tracker-exp.gsp')" src="/images/Transparent.gif" class="tracker-icon tracker-tips"/></a></div>
				<div style='top:20px;position:relative;left:-10px;z-index:10;width:57px'><a href="/myReport"><img src="/images/Transparent.gif" class="tracker-icon tracker-reports"/></a></div>						
			</div>
			<div id='wrap'>
				<div id="tabs" class='page-bg'>
					<ul>
						<li><a href="#tabs-1">&nbsp;&nbsp;&nbsp;&nbsp;My Expenses</a></li>
						<li><a href="#tabs-2">My Sales</a></li>
						<li><a href="#tabs-3">My Results</a></li>
						<li style='width:157px'><a href="#tabs-4">My Competition</a></li>
					</ul>
					<div id="tabs-1">
						<g:include view="myTracker/expensesTab.gsp" />
					</div>
					<div id="tabs-2">
						<g:include view="myTracker/salesTab.gsp" />
					</div>
					<div id="tabs-3">
					    <g:include view="myTracker/resultTab.gsp" />
					</div>
					<div id="tabs-4">
						<g:include view="myTracker/competitorTabCalendar.gsp"/>				
						<g:include view="myTracker/competitorTabDetail.gsp"/>	
					</div>
				</div>
				<table class='page-bg' id='tabs-1-detail-content' style='display:none;float:right;border:1px solid #B69A2F' cellspacing='0' cellpadding='0'>
					<tr>
						<td style='height:640px;' id='detail-content'>
								 <div  style='margin-bottom:3px; font-weight:bold'>
									<g:datePicker name="expenseDate" value="${new Date()}" precision="month"
					              noSelection="['':'']" years="${start..end}"/> <span class='planner-detail-link-blue gobtn' onclick='expenseCalUtil.gotoDate()'>Go</span>
				                 </div>
						
								<div id='expense-calendar' class='sm-event-cal'
									style='width: 250px; border:1px solid #B69A2F;background-color:rgb(242,252,254);'></div>
				
							    <div id='tracker-detail-expense'>
									<div id='content-summary'
										style='position: relative; margin-top:10px; width: 250px; overflow-y: auto; height: 480px; border: 1px solid #B69A2F; background-color: white;'>
										<div id='expense-detail-content' style='background-color: white;'>
										&nbsp;
										</div>
									</div>
								</div>
						</td>
					</tr>
				</table>		
				<div style='clear: both'></div>
		   </div>		   
		</div>
		<div style='height:1px'>
	   	</div>
	</div>  
	<g:include view="common/footer.gsp"/>	   
	<div id="dialog" class="transition-bg" title="" style="font-size: 13; display: none; text-align:left;"></div>	
	<div id="dialog-small" class="transition-bg" title="" style="font-size: 13; display: none; text-align:left;"></div>   
	<div id="dialog-new-competitor" title="" style="font-size: 13; display: none; text-align:left;">
		<g:include view="myTracker/newCompetitor.gsp" />	
	</div>  
	<div id="dialog-new-newspaperr" title="" style="font-size: 13; display: none; text-align:left;">
		<g:include view="myTracker/newNewspaper.gsp" />	
	</div>  
	<div id="dialog-new-vendor" title="" style="font-size: 13; display: none; text-align:left;">
			<g:include view="myTracker/newVendor.gsp" />	
	 </div> 	
	<div id="dialog-review-policy" title="" style="display: none; text-align:left; background-color:white">
		<h2>Our Review Policy</h2>
		We publish all reviews that are intended to help others
		make informed decisions about what marketing to run.<br/><br/>
		
		Tell us why you picked this piece, how you modified it
		and how it worked in your marketplace relative to other
		pieces you have run in the past.<br/><br/>
		
		If you want to rate a piece, you can do that as well. If it's
		a newspaper ad, however, we ask that you include the 
		number of same-day competitive ads and let us know if
		your placement in the paper was great, good, ok, or poor.
		We all know these things can greatly affect your results.<br/><br/>
		
		If you'd to comment on a review, feel free. Collective
		wisdom is better than any thought that stands alone.<br/><br/>
		
		We also appreciate your feedback, so go ahead and 
		shoot us an email. We would love to hear from you!	
	</div> 	 
	<div id="dialog-publish-review" title="" style="display: none; text-align:left; background-color:white"></div>
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
