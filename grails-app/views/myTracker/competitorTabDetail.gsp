<div class='tabs-4-content' style='padding:5px;background-color:white;border:1px solid #B69A2F; display:none'>
<table  style='padding:5px;background-color: #F7F4EF; width:100%; border:1px solid #B69A2F'>
	<tr>
		<td style='width: 260px;padding:0px;'>
		<div
			style='padding:0px;margin:0px;width: 260px'>


		<div id="static-tab" style='padding-top:37px;background-color:#F7F4EF'>
		   <table width='100%' >
		   <tr>
		   	<td width='20%'><img onclick='selectEventType("news-planner-event")' src="/images/Transparent.gif" class="tracker-icon tracker-news-small-icon itda-off news-planner-event" /></td>
		   	<td width='20%'><img onclick='selectEventType("directmail-planner-event")' src="/images/Transparent.gif" class="tracker-icon tracker-dm-small-icon itda-off directmail-planner-event" /></td>
		   	<td width='20%'><img onclick='selectEventType("media-planner-event")' src="/images/Transparent.gif" class="tracker-icon tracker-media-small-icon itda-off media-planner-event" /></td>
		   	<td width='20%'><img onclick='selectEventType("event-planner-event")' src="/images/Transparent.gif" class="tracker-icon tracker-event-small-icon itda-off event-planner-event" /></td>
		   	<td width='20%'><img onclick='selectEventType("miscellaneous-planner-event")' src="/images/Transparent.gif" class="tracker-icon tracker-misc-small-icon itda-off miscellaneous-planner-event" /></td>
		   </tr>
		   </table>	   		   
		</div>
		<div style='background-color:#F7F4EF;height:15px'>&nbsp;</div>
		<div style='background-color:rgb(105,96,91);' class='ui-corner-all' >
			<div id='current-working-days' style='margin-top:0px;'>
				<select id='currentWorkingDayEvents' style='width:250px;margin:5px 5px 0px;font-size:14px' class='ui-corner-all' name='workingDayEvents' onchange='trackerEventChanges(this);'></select>
			</div>
		<div id="accordion" class='ui-corner-all'>
<%-- 
		<h3><a href="#">Date</a></h3>
		<div id='repeatad-accordion' style='display: none;'>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="cancel" class="tracker-icon tracker-cancel-orange-btn" onclick="$('#accordion').accordion('activate', -1);" value="" id="cancel" type="reset"/>
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-date" type="submit"/>
				</span>
				<br/><br/>
			</div>
			<div id="repeatad-calendar"></div>
		</div>
--%>		
		<h3><a href="#">Competitor</a></h3>
		<div id='competitors-accordion' style='display: none;'>
		    <div id="competitors-message" style='display: none;' class="message"></div>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="cancel" class="tracker-icon tracker-cancel-orange-btn" onclick="$('#accordion').accordion('activate', -1);" value="" id="cancel" type="reset"/>
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" onclick="saveTrackerForm('#competitors-form', '#competitors-message');" type="submit"/>
				</span>
				<br/><br/>
			</div>
			<form action="" id="competitors-form">
			<div id='competitorList'>
			</div>
			<input name="new-competitor" class="tracker-icon new-competitor-icon" value="" type="submit" onclick='newCompetitor();return false;' style='margin:10px 0px 0px 5px'/>
			</form>
		</div>
		<h3 id='size-header'><a href="#">Size</a></h3>
		<div id="size-accordion" style='display: none;'>
		    <div id="size-message" style='display: none;' class="message" ></div>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="cancel" class="tracker-icon tracker-cancel-orange-btn" onclick="$('#accordion').accordion('activate', -1);" value="" id="cancel" type="reset"/>
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-size" type="submit" onclick="saveTrackerForm('#size-form', '#size-message');">
				</span>
				<br/><br/>
			</div>
			<form action="" id="size-form">
			<div>
			   <div class='news-planner-event'>
			<input type='radio' name='size' value="FP"/>&nbsp;&nbsp;&nbsp;Full Page<br/>
			<input type='radio' name='size' value="3_4V"/>&nbsp;&nbsp;&nbsp;3/4 Page Vertical<br/>
			<input type='radio' name='size' value="2_3V"/>&nbsp;&nbsp;&nbsp;2/3 Page Vertical<br/>
			<input type='radio' name='size' value="2_3H"/>&nbsp;&nbsp;&nbsp;2/3 Page Horizontal<br/>
			<input type='radio' name='size' value="1_2V"/>&nbsp;&nbsp;&nbsp;1/2 Page Vertical<br/>
			<input type='radio' name='size' value="1_2H"/>&nbsp;&nbsp;&nbsp;1/2 Page Horizontal<br/>
			<input type='radio' name='size' value="1_3V"/>&nbsp;&nbsp;&nbsp;1/3 Page Vertical<br/>
			<input type='radio' name='size' value="1_3H"/>&nbsp;&nbsp;&nbsp;1/3 Page Horizontal<br/>
			<input type='radio' name='size' value="1_4V"/>&nbsp;&nbsp;&nbsp;1/4 Page Vertical<br/>
			<input type='radio' name='size' value="1_4H"/>&nbsp;&nbsp;&nbsp;1/4 Page Horizontal<br/>
			<input type='radio' name='size' value="1_5V"/>&nbsp;&nbsp;&nbsp;1/5 Page Vertical<br/>
			<input type='radio' name='size' value="1_5H"/>&nbsp;&nbsp;&nbsp;1/5 Page Horizontal<br/>
			<input type='radio' name='size' value="1_62C"/>&nbsp;&nbsp;&nbsp;1/6 Page/Two Column<br/>
			<input type='radio' name='size' value="1_63C"/>&nbsp;&nbsp;&nbsp;1/6 Page/Three Column<br/>
			<input type='radio' name='size' value="1_8V"/>&nbsp;&nbsp;&nbsp;1/8 Page Vertical<br/>
			<input type='radio' name='size' value="1_8H"/>&nbsp;&nbsp;&nbsp;1/8 Page Horizontal<br/>
			<input type='radio' name='size' value="6CH"/>&nbsp;&nbsp;&nbsp;6 Column Horizontal<br/>
			<input type='radio' name='size' value="2PI"/>&nbsp;&nbsp;&nbsp;2 Panel Insert<br/>
			<input type='radio' name='size' value="4PI"/>&nbsp;&nbsp;&nbsp;4 Panel Newspaper Insert<br/>
			<input type='radio' name='size' value="OTHER"/>&nbsp;&nbsp;&nbsp;Other Size<br/>
			<div class="otherSize"></div>
			     </div>
			<%-- DM --%>
				<div class='directmail-planner-event'>
			<input type='radio' name='size' value="SL"/>&nbsp;&nbsp;&nbsp;Standard Letter<br/>
			<input type='radio' name='size' value="CH"/>&nbsp;&nbsp;&nbsp;Check<br/>
			<input type='radio' name='size' value="CL"/>&nbsp;&nbsp;&nbsp;Check Letter<br/>
			<input type='radio' name='size' value="IM"/>&nbsp;&nbsp;&nbsp;Invitation Mailer<br/>
			<input type='radio' name='size' value="SM"/>&nbsp;&nbsp;&nbsp;Self Mailer<br/>
			<input type='radio' name='size' value="PC"/>&nbsp;&nbsp;&nbsp;Postcard<br/>
			<input type='radio' name='size' value="FL"/>&nbsp;&nbsp;&nbsp;Flyer<br/>			
			<input type='radio' name='size' value="OTHER"/>&nbsp;&nbsp;&nbsp;Other Type<br/>
			<div class="otherSize"></div>
				</div>
			<%-- Media --%>
				<div class='media-planner-event'>
			<input type='radio' name='size' value="TV_30_SEC"/>&nbsp;&nbsp;&nbsp;TV 30 Sec<br/>
			<input type='radio' name='size' value="TV_60_SEC"/>&nbsp;&nbsp;&nbsp;TV 60 Sec<br/>
			<input type='radio' name='size' value="RADIO_30_SEC"/>&nbsp;&nbsp;&nbsp;Radio 30 Sec<br/>
			<input type='radio' name='size' value="RADIO_60_SEC"/>&nbsp;&nbsp;&nbsp;Radio 60 Sec<br/>
			<input type='radio' name='size' value="INTERNET_AD"/>&nbsp;&nbsp;&nbsp;Internet Ad<br/>
			<input type='radio' name='size' value="SOCIAL_MEDIA"/>&nbsp;&nbsp;&nbsp;Social Media<br/>
			<input type='radio' name='size' value="OTHER">&nbsp;&nbsp;&nbsp;Other Type<br/>
			<div class='otherSize'></div>
	
				</div>
			<%-- Event --%>
				<div class='event-planner-event'>
			<input type='radio' name='size' value="OPEN_HOUSE"/>&nbsp;&nbsp;&nbsp;Open House<br/>
			<input type='radio' name='size' value="HEALTH_FAIR"/>&nbsp;&nbsp;&nbsp;Health Fair<br/>
			<input type='radio' name='size' value="OUTREACH_PROGRAM"/>&nbsp;&nbsp;&nbsp;Outreach Program<br/>
			<input type='radio' name='size' value="OTHER">&nbsp;&nbsp;&nbsp;Other Type<br/>
			<div class='otherSize'></div>
				</div>
			<%-- Misc --%>
				<div class='miscellaneous-planner-event'>
			<input type='radio' name='size' value="LEAD_PULL"/>&nbsp;&nbsp;&nbsp;Lead Pull<br/>
			<input type='radio' name='size' value="BUS_AD"/>&nbsp;&nbsp;&nbsp;Bus Ad<br/>
			<input type='radio' name='size' value="BILLBOARD"/>&nbsp;&nbsp;&nbsp;Billboard<br/>
			<input type='radio' name='size' value="CONTEST"/>&nbsp;&nbsp;&nbsp;Contest<br/>
			<input type='radio' name='size' value="OTHER">&nbsp;&nbsp;&nbsp;Other Type<br/>
			<div class='otherSize'></div>
				</div>		
			</div>
			</form>
		</div>
		<h3 id='color-header'><a href="#">Color</a></h3>
		<div id='color-accordion' style='display: none;'>
		    <div id="color-message" style='display: none;' class="message"></div>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="cancel" class="tracker-icon tracker-cancel-orange-btn" onclick="$('#accordion').accordion('activate', -1);" value="" id="cancel" type="reset"/>
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-color" type="submit" onclick="saveTrackerForm('#color-form', '#color-message');"/>
				</span>
				<br/><br/>
			</div>
			<form action="" id="color-form">
			<div>
			<input type='radio' name='color' value="4C"/>&nbsp;&nbsp;&nbsp;4-Color<br/>
			<input type='radio' name='color' value="2C"/>&nbsp;&nbsp;&nbsp;2-Color<br/>
			<input type='radio' name='color' value="1C"/>&nbsp;&nbsp;&nbsp;1-Color<br/>
			</div>
			</form>
		</div>
		<h3 id='vendors-header'><a href="#">Newspaper</a></h3>
		<div id='vendors-accordion' style='display: none;'>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="cancel" class="tracker-icon tracker-cancel-orange-btn" onclick="$('#accordion').accordion('activate', -1);" value="" id="cancel" type="reset"/>
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-vendors" type="submit" onclick="saveTrackerForm('#vendors-form', '#vendors-message');"/>
				</span>
				<br/><br/>
			</div>
			<form action="" id="vendors-form">
			<div id='vendorList'>
			</div>
			<div id='new-vendor-btn'>
			</div>
			</form>
			
		</div>		
<%--		
		<div id='newspaper-accordion' style='display: none;'>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="cancel" class="tracker-icon tracker-cancel-orange-btn" onclick="$('#accordion').accordion('activate', -1);" value="" id="cancel" type="reset"/>
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value=""  type="submit" onclick="saveTrackerForm('#newspaper-form', '#newspaper-message');"/>
				</span>
				<br/><br/>
			</div>
			<form action="" id="newspaper-form">
			<div id='newspaperList'>
			<br/>
			</div>
			<span id='new-vendor-btn'>
			<input name="new-newspaper" class="tracker-icon new-newspaper-icon" value="" type="submit" onclick='newNewspaper();return false;' style='margin:10px 0px 0px 5px'/>
			</span>
			</form>
		</div>
--%>
		<h3 ><a href="#" id='selectad-header-text'>Select Ad</a></h3>
		<div id='selectAdFrom-accordion' style='display: none;'>
		    <div id="selectAdFrom-message" style='display: none;' class="message"></div>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="cancel" class="tracker-icon tracker-cancel-orange-btn" onclick="$('#accordion').accordion('activate', -1);" value="" id="cancel" type="reset"/>
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-selectAdFrom" type="submit"/>
				</span>
				<br/><br/>
			</div>
			<form action="/myTracker/uploadAdImage" id="selectAdFrom-form">
								
								
<div id="container">
	<div id="filelist"></div>
	<br />
	<a id="pickfiles" href="javascript:void(0);" class='center acct-link-active'>From File</a>
</div>
								

			</form>
		</div>
		<h3><a href="#">Notes</a></h3>
		<div id="notes-accordion" style='display: none;'>
			<div id="notes-message" style='display: none;' class="message"></div>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="cancel" class="tracker-icon tracker-cancel-orange-btn" onclick="$('#accordion').accordion('activate', -1);" value="" id="cancel" type="reset"/>
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-notes" type="submit" onclick="saveTrackerForm('#notes-form', '#notes-message');"/>
				</span>
				<br/><br/>
			</div>
			<form action="" id="notes-form">
			<div class='textarea' style='margin:0'>
				<b>Notes:</b><br/>			
				<textarea rows="" cols="" name="notes" ></textarea>
			</div>
			</form>
		</div>
		<h3><a href="#">New Marketing</a></h3>
		<div id='newmarketing-accordion' style='display: none;'>

		    <div id="newmarketing-message" style='display: none;' class="message"></div>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="cancel" class="tracker-icon tracker-cancel-orange-btn" onclick="$('#accordion').accordion('activate', -1);" value="" id="cancel" type="reset"/>
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-newmarketing" type="submit"/>
				</span>
				<br/><br/>
			</div>		    
			<form action="" id="newmarketing-form"><%--
			<div>
			<input type='checkbox' name='newmarketing' value='directmail'/>
			<input type='checkbox' name='newmarketing' value='event'/>
			<input type='checkbox' name='newmarketing' value='media'/>
			<input type='checkbox' name='newmarketing' value='miscellaneous'/>
			</div>
			--%></form>
		    
		</div>
		</div>
	</div>
	</div>
		</td>
		<td style='width: 15px; padding: 0px'>&nbsp;</td>

		<td style='height: 100%; padding: 0; width: 715px'>
		
		<table
			style='background-color: F7F4EF; width: 100%; padding: 0 10 0 10px;'>
			<tr>
				<td style='vertical-align: bottom;padding-bottom:5px;'>
				<div id="date" style='height: 100%'></div>
				</td>
				<td style='vertical-align: bottom;padding: 5px;'>
				<a href="javascript:void(0)" onclick='swapCalView(true);' style='float:right' ><img style="float: left;" class="tracker-calendar-link" src="/images/Transparent.gif"><span style="position: relative; top: 3px; font-weight: bold; color: rgb(85, 85, 85); font-size: 11px;">&nbsp;Calendar&nbsp;View</span></a>
				</td>
			</tr>
		</table>		
		<div
			style='background-color: #F7F4EF; border-width: 0px; border-color: #F7F4EF; border-style: solid'>
		<div
			style='position: relative; width: 685px; min-height: 525px; border: 1px solid #B69A2F; background-color: white;'>
		<div id='tracker-detail-content'>
			<table style='width:100%; height:100%;border-width: 10px 3px 10px 10px'><tr>
			<td style='width:457px;text-align:center;padding:5px'>
					<table cellpadding="0" cellspacing="0">
						<tr>
							<td class='tracker-icon left-side-border-35-509'>
							    <%-- 
						          	<area style='border:2px solid green;' shape="poly" coords="12,488,24,484,25,497,12,488" onclick="prevPlannerEvent(selectedPlannerEntry);" href='#prev' />
								 --%>
					<img onclick="prevPlannerEvent(selectedPlannerEntry);" style="top:482px;left:13px;position:relative" class="tracker-icon small-prev-icon" src="/images/Transparent.gif">								 
							</td>
							<td style='background-image: url("/images/itd/planner/center-border.jpg");background-position: 0 0;background-repeat: repeat-x;height: 509px;width: 390px;'>
						  	  <p style='vertical-align:middle' id='adImage'>
						  	  
						  	  </p>
							</td>
							<td class='tracker-icon right-side-border-35-509'>
							    <%-- 
							          	<area shape="poly" coords="10,483,22,489,8,497,10,483"   href='#next' />
								--%>
								<img style="position:relative;top:468px;left:10px" class="tracker-icon small-next-icon" src="/images/Transparent.gif" onclick="nextPlannerEvent(selectedPlannerEntry);">
						</tr>
					</table>
			</td>
			<td style='padding:5px 5px 5px 0px;'>
				<div  style='margin-bottom:3px; font-weight:bold'>
					<g:datePicker name="detailDate" value="${new Date()}" precision="month"
	              noSelection="['':'']" years="${start..end}"/> <span class='planner-detail-link-blue gobtn' onclick='detailCalUtil.gotoDate()'>Go</span>
                 </div>
				<div id='pdtl-calendar' class='itda-fc'
					style='width: 195px; border:1px solid #B69A2F;padding:2px 7px 10px 2px;background-color:#F2FCFE'></div>
			    <div id='tracker-detail'>
					<div
						style='position: relative; margin-top:10px; width: 205px; overflow-y: auto; height: 333px; border: 1px solid #B69A2F; background-color: white;'>
						<div id='summary' style='background-color: white;padding:10px'>
						</div>
					</div>
				</div>
			</td>
			</tr></table>
		</div>
		</div>
		</div>

		</td>
	</tr>
</table>
</div>