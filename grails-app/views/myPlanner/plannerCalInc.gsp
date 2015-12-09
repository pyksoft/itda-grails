
<div id='wrap' class='plannerContent'>
<table style='padding-bottom: 10px; width: 100%; border-spacing:0px 0px'>
	<tr>
		<td
			style='padding: 0; border-right: 3px solid; background-color: #F7F4EF'>
			<div id='calendar'></div>
			<div id='advertise-events'>
			<table width='100%'>
				<tr>
					<td width="20%" style='padding: 0px 0px 0px 24px; vertical-align: bottom;'>
					<div class='advertise-event' id='news-planner-event'>&nbsp;</div>
					<b>Newspaper</b></td>
					<td width="20%"	style='padding: 0px 0px 0px 30px; vertical-align: bottom;'>
					<div class='advertise-event' id='directmail-planner-event'>&nbsp;</div>
					<b>Direct Mail</b></td>
					<td width="20%" style='padding: 0px 0px 0px 35px; vertical-align: bottom;'>
					<div class='advertise-event' id='media-planner-event'>&nbsp;</div>
					<b>&nbsp;&nbsp;&nbsp;&nbsp;Media</b></td>
					<td width="20%" style='padding: 0px 0px 0px 38px; vertical-align: bottom;'>
					<div class='advertise-event' id='event-planner-event'>&nbsp;</div>
					<b>&nbsp;&nbsp;&nbsp;&nbsp;Event</b></td>
					<td width="20%" style='padding: 0px 0px 0px 45px; vertical-align: bottom;'>
					<div class='advertise-event' id='miscellaneous-planner-event'>&nbsp;</div>
					<b><span style='position: relative; left:-5px;'>Miscellaneous</span></b></td>
				</tr>
			</table>
			</div>
		</td>
		<td style='height: 100%; padding: 0;'>
			<div id='planner-detail'>
				<h2 style='text-align:left; padding:3px 0pt 10px 7px; font-size:23px'>My Marketing Plan</h2>
				<div  style='position: relative; left: 7px; margin-bottom:7px; font-weight:bold'>
					<g:datePicker name="date" value="${new Date()}" precision="month"
	              noSelection="['':'']" years="${start..end}"/> <span class='planner-detail-link-blue gobtn' onclick='calUtil.gotoDate()'>Go</span>
                 </div>
				<div id='scrollpanel' style='position: relative; left: 7px; width: 235px; overflow-y: auto; height: 662px; border: 1px solid #B69A2F; background-color: white;'>
					<div class='planner-detail-content entry-list' style='background-color: white;'></div>
				</div>
			</div>
			<br />
		</td>
	</tr>
</table>
<div style='clear: both'></div>
</div>
