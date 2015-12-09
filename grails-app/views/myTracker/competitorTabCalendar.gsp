<table  class='tabs-4-content' style='padding-bottom: 11px; width: 100%;border:1px solid #B69A2F; background-color:white' cellspacing='0'
	cellpadding='0' id='comp-cal'>
	<tr>
		<td id='event-cal'>
		<div id='calendar'></div>
		<div id='advertise-events'>
		<table width='100%' style='background-color: #F7F4EF;'>
			<tr>
				<td width="20%"
					style='padding: 0px 0px 0px 24px; vertical-align: bottom;'>
				<div class='advertise-event' id='news-planner-event'>&nbsp;</div>
				<b>Newspaper</b></td>
				<td width="20%"
					style='padding: 0px 0px 0px 30px; vertical-align: bottom;'>
				<div class='advertise-event' id='directmail-planner-event'
					>&nbsp;</div>
				<b>&nbsp;Direct Mail</b></td>
				<td width="20%"
					style='padding: 0px 0px 0px 35px; vertical-align: bottom;'>
				<div class='advertise-event' id='media-planner-event'>&nbsp;</div>
				<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Media</b></td>
				<td width="20%"
					style='padding: 0px 0px 0px 38px; vertical-align: bottom;'>
				<div class='advertise-event' id='event-planner-event'>&nbsp;</div>
				<b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Event</b></td>
				<td width="20%"
					style='padding: 0px 0px 0px 45px; vertical-align: bottom;'>
				<div class='advertise-event' id='miscellaneous-planner-event'>&nbsp;</div>
				<b><span style='position: relative; left: -10px;'>&nbsp;Miscellaneous</span></b></td>
			</tr>
		</table>
		</div>
		</td>
		<td>

		<div id='planner-detail'>
			<h1 style='text-align: left; padding-left: 7px'>My Competition</h1>
			<div  style='position: relative; left: 7px; margin-bottom:7px; font-weight:bold'>
				<g:datePicker name="date" value="${new Date()}" precision="month"
              noSelection="['':'']" years="${start..end}"/> <span class='planner-detail-link-blue gobtn' onclick='calUtil.gotoDate()'>Go</span>
            </div>			
			<div
				style='position: relative; left: 7px; width: 220px; overflow-y: auto; height: 688px; border: 1px solid #B69A2F; background-color: white;'>
				<div class='tracker-detail-content entry-list' style='background-color: white;'>
				</div>
			</div>
		</div>
		<br />

		</td>
	</tr>
<%--  	
	<tr><td>
		<div>
			<div id='detail-view' style='float:right;width:100px; margin-left:20px'><a href="javascript:void(0)" onclick='gotoDetailView(gCompetitorAdDetailEntries);'><img src="/images/Transparent.gif" class="tracker-icon tracker-detail-view-icon" style='float:left'/><span style='position:relative;top:3px;color:#555555'>&nbsp;Details&nbsp;View</span></a></div>			
			<div id='print-cal' style='float:right;width:120px'><a href="javascript:void(0)" onclick='window.print()'><img src="/images/Transparent.gif" class="tracker-icon tracker-print-icon" style='float:left'/><span style='position:relative;top:3px;font-weight:bold;color:#555555'>&nbsp;Print&nbsp;Calendar</span></a></div>			
		</div>	
	</td></tr>
--%>	
</table>