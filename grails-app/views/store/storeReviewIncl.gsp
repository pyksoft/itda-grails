<table cellpadding='0px' border='0px' cellspacing='0px' style='width: 1008px; ${actionName =='selectFile' ? '' : 'margin:8px;'} display:none' id='review'>
	<tr>
	<td class='store-left-col'>
		<div id='left-cont'>
			<div id='reviewAdImage'></div>
			<div id='reviewSummary'></div>
			<div id='review-rating'></div>
			<div id='review-rating-text'></div>
		</div>
	</td>
	<td style='width: 8px; padding: 0px;'>&nbsp;</td>

	<td class='archive-right-col'>
		<div id='right-cont'>
			<h1 class='resultTitle' style='margin-bottom:0px'>Reviews</h1>
			<div>
				<a href="javascript:void(0)" onclick="backToDetails()" style='float:right'>
				<span style="position: relative; top: -2px; color: rgb(85, 85, 85);font-size:11px">
				<img class="tracker-icon tracker-detail-view-icon" src="/images/Transparent.gif" style="float: left;"/>
				<span style='position:relative;top:5px'>&nbsp;Back&nbsp;to&nbsp;Details</span>
				</span>
				</a>		
			</div>
		</div>
		<div style='width: 677px; margin: 23px 20px 10px; padding: 15px; border:1px solid #B69A2F; background:white'>
			    <h3 id='numReviews'></h3>
			    <div class='review-hr'></div>
			    <div id='reviews'></div>
		</div>
		</td>
	</tr>
</table>
