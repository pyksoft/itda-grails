<div class='plannerContent' style='display:none' id='detail'>
<div style="clear:both;height:1px"></div>
<table style='width: 100%;background-color: #F7F4EF;'>
	<tr>
	<td style="width: 10px; padding: 0px;">&nbsp;</td>
		<td style='width: 260px;padding:0px;'>
		<div
			style='padding:0 0 5px;margin:0;width: 270px'>
		<div id="static-tab" style='padding-top:60px;background-color:F7F4EF'>
		   <table width='100%' >
		   <tr>
		   	<td width='20%'><img class="planner-icon planner-news-small-icon news-planner-event" src="/images/Transparent.gif" onclick='selectEventType("news-planner-event")'></td>
		   	<td width='20%'><img src="/images/Transparent.gif" class="planner-icon planner-dm-small-icon itda-off directmail-planner-event" onclick='selectEventType("directmail-planner-event")'/></td>
		   	<td width='20%'><img src="/images/Transparent.gif" class="planner-icon planner-media-small-icon itda-off media-planner-event" onclick='selectEventType("media-planner-event")'/></td>
		   	<td width='20%'><img src="/images/Transparent.gif" class="planner-icon planner-event-small-icon itda-off event-planner-event" onclick='selectEventType("event-planner-event")'/></td>
		   	<td width='20%'><img src="/images/Transparent.gif" class="planner-icon planner-misc-small-icon itda-off miscellaneous-planner-event" onclick='selectEventType("miscellaneous-planner-event")'/></td>
		   </tr>
		   </table>
		</div>
		<div style='background-color:#F7F4EF;height:6px'>&nbsp;</div>
		<div style='background-color:rgb(105,96,91);' class='ui-corner-all' >
			<div id='current-working-days' style='margin-top:0px;'>
				<select id='currentWorkingDayEvents' class='ui-corner-all' name='workingDayEvents' onchange='plannerEventChanges(this);'></select>
			</div>
			<div id="accordion" class='ui-corner-all'>
		<h3 id='size-header'><a href="#">Size</a></h3>
		<div id="size-accordion" style='display: none;'>
		    <div id="size-message" style='display: none;' class="message" ></div>
			<div id='buttons'>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-size" type="submit" onclick="saveForm('#size-form', '#size-message');">
				</span>
				<br/><br/>
			</div>
			<form action="" id="size-form">
				<g:include view="myPlanner/sizeInc.gsp"/>
			</form>
		</div>
		<h3 id='color-header'><a href="#">Color</a></h3>
		<div id='color-accordion' style='display: none;'>
		    <div id="color-message" style='display: none;' class="message"></div>
			<div id='buttons'>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-color" type="submit" onclick="saveForm('#color-form', '#color-message');">
				</span>
				<br/><br/>
			</div>
			<form action="" id="color-form">
			<div>
			<input type='radio' name='color' value="4C">&nbsp;&nbsp;&nbsp;4-Color<br/>
			<input type='radio' name='color' value="2C">&nbsp;&nbsp;&nbsp;2-Color<br/>
			<input type='radio' name='color' value="1C">&nbsp;&nbsp;&nbsp;1-Color<br/>
			</div>
			</form>
		</div>
		<h3 id='offices-header'><a href="#">Office</a></h3>
		<div id='offices-accordion' style='display: none;'>
			<div id='buttons'>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-offices" type="submit" onclick="saveForm('#offices-form', '#offices-message');"/>
				</span>
				<br/><br/>
			</div>
			<form action="" id="offices-form">
			<input type="hidden" name='association' />
			<div id='officeList'>
			</div>
			</form>
		</div>
		<h3 id='vendors-header'><a href="#">Vendor</a></h3>
		<div id='vendors-accordion' style='display: none;'>
			<div id='buttons'>
				<span style='float:left' id='new-vendor-btn'></span>			
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-vendors" type="submit" onclick="saveForm('#vendors-form', '#vendors-message');"/>
				</span>
				<br/><br/>
			</div>
			<form action="" id="vendors-form">
			<div id='vendorList'>
			</div>
			</form>
		</div>
		<h3><a href="#">Deadline</a></h3>
		<div id='deadline-accordion' style='display: none;'>
			<div id='buttons'>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value='' onclick="saveForm('#deadline-form', '#deadline-message');" type="submit">
				</span>
				<br/><br/>
			</div>
			<div id="deadline-calendar" class='sm-event-cal' style='border:1px solid #B69A2F'></div>
			<form action="#" id="deadline-form">
			    <input name='deadline' value='date.struct' type='hidden'/>
				<input name='deadline_year' value='' type='hidden'/>
				<input name='deadline_month' value='' type='hidden'/>
				<input name='deadline_day' value='' type='hidden'/>
			</form>
		</div>

		<h3 id="quantity-header"><a href="#">Quantity</a></h3>
		<div id="quantity-accordion" style='display: none;'>
			<div id="quantity-message" class="message" style='display: none;'></div>
			<div id="buttons" style="display: block;">
				<span style="float: right;">
					<input type="submit" class="tracker-icon save-btn" name="save" value='' onclick="saveForm('#quantity-form', '#quantity-message');">
				</span>
				<br><br>
				<form action="" id="quantity-form">
				
			<input type='radio' name='quantity' value="500">&nbsp;&nbsp;&nbsp;500<br/>
			<input type='radio' name='quantity' value="1000">&nbsp;&nbsp;&nbsp;1000<br/>
			<input type='radio' name='quantity' value="1500">&nbsp;&nbsp;&nbsp;1500<br/>
			<input type='radio' name='quantity' value="2000">&nbsp;&nbsp;&nbsp;2000<br/>
			<input type='radio' name='quantity' value="2500">&nbsp;&nbsp;&nbsp;2500<br/>
			<input type='radio' name='quantity' value="3000">&nbsp;&nbsp;&nbsp;3000<br/>
			<input type='radio' name='quantity' value="3500">&nbsp;&nbsp;&nbsp;3500<br/>
			<input type='radio' name='quantity' value="4000">&nbsp;&nbsp;&nbsp;4000<br/>
			<input type='radio' name='quantity' value="4500">&nbsp;&nbsp;&nbsp;4500<br/>
			<input type='radio' name='quantity' value="5000">&nbsp;&nbsp;&nbsp;5000<br/>
			<input type='radio' name='quantity' value="7500">&nbsp;&nbsp;&nbsp;7500<br/>
			<input type='radio' name='quantity' value="10000">&nbsp;&nbsp;&nbsp;10000<br/>
			<input type='radio' name='quantity' id='customQty' value="">&nbsp;&nbsp;&nbsp;Other Quantity<br/>
			<input type='text' name='tmpQuantity' class='customQty' value="" style='margin-left:25px' onfocus='$("#customQty").attr("checked", true);'/>
			</form>
			<%-- a href='#addQuantity'  style='margin-left:25px'>Add Quantity</a><br/>		
			<a href='#manageQuantity'  style='margin-left:25px'>Manage Quantities</a><br/--%>		
			</div>
		</div>

		<h3 id="zipcodes-header"><a href="#">Zip Codes</a></h3>
			<div id="zipcodes-accordion" style='display: none;'>
		    	<div id="zipcodes-message" class="message" style='display: none;'></div>
				<div id="buttons" style="display: block;">
					<span style="float: right;">
						<input onclick="saveForm('#zipcodes-form', '#zipcodes-message');" type="submit" id="save-zipcodes" value="" class="tracker-icon save-btn" name="save">
					</span>
				</div>
					<br><br>
			<form action="" id='zipcodes-form'>					
			</form>
				
			</div>
 		
		<h3 ><a href="#" id='selectad-header-text'>Select Ad</a></h3>
		<div id='selectAdFrom-accordion' style='display: none;'>
		    <div id="selectAdFrom-message" style='display: none;' class="message"></div>
			<form action="" name="selectAdFrom-form">
			<div>
			<a href="javascript:void(0);" class='planner-detail-link-black' onclick='plannerArchiveCtrl.fromArchive("All");'>From Archive<br/></a>
			<%--
			<a href="javascript:void(0);" class='planner-detail-link-black' onclick='plannerArchiveCtrl.fromArchive("Favorites");'>From Favorites<br/></a>
			<a href="javascript:void(0);" class='planner-detail-link-black' onclick='plannerArchiveCtrl.fromArchive("Previously Run");'>From Previously Run<br/></a>
			<a href="javascript:void(0);" class='planner-detail-link-black' onclick='plannerArchiveCtrl.fromArchive("Purchased");'>From Purchased<br/></a>
			 --%>
			<div id="container">
				<div id="pickfiles" class='planner-detail-link-black' style='color:#222;font-size:12px;line-height:2;font-weight:bold;margin:0'>From File</div>
				<div id="filelist"></div>
			</div>
			</div>
			</form>
		</div>
		<h3><a href="#">Notes</a></h3>
		<div id="notes-accordion" style='display: none;'>
			<div id="notes-message" style='display: none;' class="message"></div>
			<div id='buttons'>
				<span style='float:left'>                
					<input name="reset" class="planner-icon clear-btn-gray" onclick="$('#notes-form textarea').val('');this.blur()" value="" id="cancel" type="reset">
				</span>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-notes" type="submit" onclick="saveForm('#notes-form', '#notes-message');">
				</span>
				<br/><br/>
			</div>
			<form action="" id="notes-form">
			<div class='textarea' style='margin:0'>
				<b>Notes to Self</b><br/>			
				<textarea rows="" cols="" name="selfNotes"></textarea>
			</div>
			<br/>
			<div class='textarea' style='margin:0'>
			<b>Notes to Vendor</b><br/>
			<textarea rows="" cols="" name="vendorNotes"></textarea>
			</div>
			</form>
		</div>
		<h3><a href="#">To Do</a></h3>
		<div  id="todos-accordion" style='display: none;'>
			<div id="todos-message" style='display: none;' class="message"></div>
			<div id='buttons'>

				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-todos" type="submit" onclick='saveTodos();$("#accordion").accordion("activate", -1);'>
				</span>
				<br/><br/>
			</div>
			<form action="#" id="todos-form" style='padding-left:5px'>
				<div id='todosList'></div>
			</form>
			
			<div>
				<div id='buttons'>
				<form action="#" id="add-todo-form" style='padding-left:5px;float:left'>
				<br/>
				<input type='hidden' name='id'/>
				<textarea name='title' style='width:205px;height:50px; border:1px solid #cccccc'></textarea>
				</form>
			
				<input name="add-todo" class="planner-icon add-todo-btn-gray"  style='float:right'
					onclick='addTodo();this.blur()' value="" type="submit">
				</div>
			 </div>
		</div>
		<h3><a href="#">Send to Vendor</a></h3>
		<div id="send-accordion" style='display:none; visibility:hidden; height:0px; padding-top:0px; padding-bottom:0px'></div>
		<h3><a href="#" id='repeadad-header-text'>Repeat Ad</a></h3>
		<div id='repeatad-accordion' style='display: none'>
			<%-- div id="repeatad-message" style='display: none;' class="message"></div--%>
			<div id='buttons'>
				<span style='float:right'>
					<input onclick="saveRepeatDates('#repeatad-form', '#repeatad-message');" name="save" class="tracker-icon save-btn" value="" id="save-repeatad" type="submit">
				</span>
				<br/><br/>
			</div>
			<div id="repeatad-calendar" class='sm-event-cal' style='border:1px solid #B69A2F'></div>
			<form action="#" id="repeatad-form"></form>
		</div>
		<h3><a href="#">Add to This Date</a></h3>
		<div id='newmarketing-accordion' style='display: none;'>

		    <div id="newmarketing-message" style='display: none;' class="message"></div>
			<div id='buttons'>
				<span style='float:right'>
					<input name="save" class="tracker-icon save-btn" value="" id="save-newmarketing" type="submit">
				</span>
				<br/><br/>
			</div>		    
			<form action="" id="newmarketing-form"></form>			
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
				
				<a href="javascript:void(0)" onclick="gotoPlannerCalView();return false;" style='float:right' ><img style="float: left;" class="tracker-calendar-link" src="/images/Transparent.gif"><span style="position: relative; top: 3px; font-weight: bold; color: rgb(85, 85, 85); font-size: 11px;">&nbsp;Calendar&nbsp;View</span></a>
				</td>
			</tr>
		</table>
		<div
			style='background-color: F7F4EF; border-width: 0 10 0 0px; border-color: F7F4EF; border-style: none'>
		<div
			style='position: relative; width: 700px; min-height: 525px; border: 1px solid #B69A2F; background-color: white;'>
		<%-- div id='planner-detail-content' --%>
		<div id='planner-detail-content'  style='border-style:none' >
			<table style='width:100%; height:100%;border-width: 10 3 10 10px'><tr>
			<td style='width:480px;text-align:center;'>
					<div id="canvas" style="width:480px">
					
						<div class="line" id="line1">	  	
						  <div class="item" id="left-border">
					
						    <div class="sap-content" ><img src='/images/itd/planner/left-side-border-35-509.jpg' usemap="#map1"/>
						             <map name="map1" >
							          	<area style='border:2px solid green;' shape="poly" coords="12,488,24,484,25,497,12,488" onclick="prevPlannerEvent(selectedPlannerEntry);" href='#prev' />
									 </map>
						    </div>
						  </div>
						  <div class="item" id="center-border">
						  	<div class="sap-content" >
						  	  <p id='adImage'></p>
						  	</div>						  
						  </div>
						  <div class="item" id="right-border">
							<div class="sap-content" id="right-border-sap-content" style='postion:relative'>
							<img src='/images/itd/planner/right-side-border-35-509.jpg' usemap="#map2"/>
						              <map name="map2">
							          	<area shape="poly" coords="10,483,22,489,8,497,10,483" onclick="nextPlannerEvent(selectedPlannerEntry);"  href='#next' />
									  </map>		  
						  	</div>
						  </div>
						</div>
						
					</div>
			</td>
			<td style='padding:5px 5px 5px 0px;'>
				<div  style='margin-bottom:3px; font-weight:bold'>
					<g:datePicker name="detailDate" value="${new Date()}" precision="month"
	              noSelection="['':'']" years="${start..end}"/> <span class='planner-detail-link-blue gobtn' onclick='detailCalUtil.gotoDate()'>Go</span>
                 </div>
			
				<div id='pdtl-calendar'
					style='width: 195px; min-height:100px; border:1px solid #B69A2F;padding:2 7 10 2px;background-color:rgb(242,252,254);'></div>
			   	<div style='padding-top:5px'>
			   	<div id='summary' style='min-height:363px; width: 185px; border: 1px solid #B69A2F;padding:5px;'>
			   		
			   	</div>
			    </div>
			</td>
			</tr></table>
<%--  --%>		</div>
		</div>
		</div>
		<br />
 
		</td>
	</tr>
</table>
<img style="padding: 5px;"
	src="/images/Transparent.gif" class="center" />
</div>