<table style='display:none' id='myUpload'>
  <tr>
		<td class='archive-left-col my-upload'>
		  <h1>How to Upload Marketing to your Archive</h1><br/>
		  <form id="uploadForm">
			<table>
				<tr id="Step1">
					<td><h1>1)</h1></td>
					<td>
						<h1>Select a high resolution PDF<br />for printing and modification.</h1>
					    <a class="learn more" href="javascript:void(0);">Learn more</a> <br/><br/>
		   				<div id="uploadContainer" style="position: relative;">
						    <span class="NotDone">
						      <img onclick="archCtrl.cancelUpload();" src="/images/Transparent.gif" class="itda-archive-icon back-red-btn">
						      <img onclick="" src="/images/Transparent.gif" class="itda-archive-icon select-pdf-btn" id='pickFile'>
						    </span>
						</div>
						<%--
					    <span class="Done">
					      <img onclick="archCtrl.uploadPdf()" src="/images/Transparent.gif" class="itda-archive-icon edit-gray-btn">
					    </span>
					     --%>
					   <br/><br/><br/>
					</td>
				</tr>
				<tr id="Step2">
					<td><h1>2)</h1></td>
					<td>
						<h1>Select a JPG for viewing and tracking.</h1>
					<a class="learn more" href="javascript:void(0);">Learn more</a><br/><br/>
					<span class="NotDone">
						<img onclick="archCtrl.uploadImage()" src="/images/Transparent.gif" class="itda-archive-icon select-jpg-btn"> 
					</span>
					<%-- 
					<span class="Done">
					      <img onclick="archCtrl.uploadImage()" src="/images/Transparent.gif" class="itda-archive-icon edit-gray-btn">
					</span>
					--%>
					<br /><br/><br/>
					</td>
				</tr>
				<tr id="Step3">
					<td><h1>3)</h1></td>
					<td>
						<h1 id="marketingTypeLabel">What type of marketing is this?</h1>
						<a class="learn more NotDone Done" href="javascript:void(0);">Learn more</a><br/><br/>
							<table class="marketing-type NotDone Done">
							   <tbody><tr>
							   	<td class="bottom"><img onclick="archCtrl.selectMarketingType('NP', this)" class="planner-icon planner-news-small-icon NP itda-off" src="/images/Transparent.gif" ></td>
							   	<td class="bottom"><img onclick="archCtrl.selectMarketingType('DM', this)" class="planner-icon planner-dm-small-icon DM itda-off" src="/images/Transparent.gif"></td>
							   	<td class="bottom"><img onclick="archCtrl.selectMarketingType('ME', this)" class="planner-icon planner-media-small-icon ME itda-off" src="/images/Transparent.gif"></td>
							   	<td class="bottom"><img onclick="archCtrl.selectMarketingType('EV', this)" class="planner-icon planner-event-small-icon EV itda-off" src="/images/Transparent.gif"></td>
							   	<td class="bottom"><img onclick="archCtrl.selectMarketingType('MI', this)" class="planner-icon planner-misc-small-icon MI itda-off" src="/images/Transparent.gif"></td>
							   	<td>&nbsp;</td>
							   </tr>
							   </tbody>
						   </table><br/>
						   <img onclick="archCtrl.saveMarketingType()" class="itda-archive-icon next-red-btn NotDone" src="/images/Transparent.gif">
						 <%-- 
						<span class="Done">
						       <h3 id="marketingTypeValue"></h3>
						       </span><img onclick="archCtrl.editMarketingDesc()" src="/images/Transparent.gif" class="itda-archive-icon edit-gray-btn">
						</span>
						--%>
						<br/>
					</td>
				</tr>
				<tr id="Step4">
					<td><h1>4)</h1></td>
					<td>
						<h1 id="marketingNameLabel">Give the marketing a descriptive name.</h1>
						<a class="learn more" href="javascript:void(0);">Learn more</a><br/><br/>
						<span class="NotDone Done">
						<input type='text' name='adDescription' style='width:90%; margin:10px 0'/><br/><br/>
						</span>
					   <img onclick="archCtrl.saveMarketingDesc()" class="itda-archive-icon next-red-btn NotDone" src="/images/Transparent.gif">
						<%-- 
						<span class="Done">
						       <h3 id="marketingNameValue"></h3>
						       <img onclick="archCtrl.editMarketingDesc()" src="/images/Transparent.gif" class="itda-archive-icon edit-gray-btn">
						</span>
						--%>
						<br/>
					</td>
				</tr>				
				<tr id="Step5">
					<td><h1>5)</h1></td>
					<td>
						<h1>Open arrows to add a few more details.</h1>
						<a class="learn more" href="javascript:void(0);">Learn more</a>
						<br/><br/>
						<div id="archive-accord-size" class='archive-accord by-size by-all'>	
							<h3 id='size-header'><a href="#">Size</a></h3>
							<div id='size-panel' style='display: none;'>
								<g:include view="archive/sizeInc.gsp"/>
							</div>
						</div>
	
						<div id="archive-accord-color" class='archive-accord'>	
							<h3 id='color-header'><a href="#">Color</a></h3>
							<div id='color-panel' style='display: none;'>
								<input type='radio' name='color' value="1C"><span>1-Color</span><br/>
								<input type='radio' name='color' value="2C"><span>2-Color</span><br/>
								<input type='radio' name='color' value="4C" checked="checked"><span>4-Color</span>
							</div>
						</div>
	
						<div id="archive-accord-offers" class='archive-accord'>	
							<h3 id='offers-header'><a href="#">Offers</a></h3>
							<div id="my-uploads-offers-panel" style='display: none;'>
								<input type="radio" name='offerCode' value="$995">&nbsp;&nbsp;$995<br/>
								<input type='radio' name='offerCode' value="$1495">&nbsp;&nbsp;$1495<br/>
								<input type='radio' name='offerCode' value="$500 Off">&nbsp;&nbsp;$500 Off<br/>
								<input type='radio' name='offerCode' value="50% Off">&nbsp;&nbsp;50% Off<br/>
								<input type='radio' name='offerCode' value="40% Off">&nbsp;&nbsp;40% Off<br/>
								<input type='radio' name='offerCode' value="Buy One Get One Free">&nbsp;&nbsp;Buy One Get One Free<br/>
								<input type='radio' name='offerCode' value="Try Before You Buy">&nbsp;&nbsp;Try Before You Buy<br/>
								<input type='radio' name='offerCode' value="As Low As XX Per Month">&nbsp;&nbsp;As Low As XX Per Month<br/>
								<div>
									<input type='radio' name='offerCode' value='OTHER'>&nbsp;&nbsp;Other:<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;
									<input type='text' maxlength='30' name='otherOffer' onclick='this.focus()'><br/>						
								</div>
							</div>
						</div>
	
						<div id="archive-accord-focus" class='archive-accord'>	
							<h3 id='focus-header'><a href="#">Focus</a></h3>
							<div id='focus-panel' style='display: none;'>
								<input type="checkbox" name='testimonial'>&nbsp;&nbsp;Testimonial<br/>
								<input type='checkbox' name='sale'>&nbsp;&nbsp;Sale<br/>
								<input type='checkbox' name='trial'>&nbsp;&nbsp;Trial<br/>
								<input type='checkbox' name='seminar'>&nbsp;&nbsp;Seminar<br/>
								<input type='checkbox' name='advertorial'>&nbsp;&nbsp;Advertorial<br/>
								<input type='checkbox' name='features'>&nbsp;&nbsp;Product Features<br/>
								<input type='checkbox' name='benefits'>&nbsp;&nbsp;Product Benefits<br/>
								<input type='checkbox' name='upgrade'>&nbsp;&nbsp;Upgrade<br/>
								<input type='checkbox' name='tinnitus'>&nbsp;&nbsp;Tinnitus<br/>
								<input type='checkbox' name='notice'>&nbsp;&nbsp;Public Notice<br/>
								<input type="checkbox" name='opening'>&nbsp;&nbsp;Grand Opening<br/>
								<input type='checkbox' name='hearingTest'>&nbsp;&nbsp;Free Hearing Test<br/>
								<input type='checkbox' name='consultDemo'>&nbsp;&nbsp;Free Consultation/Demonstration<br/>
								<input type='checkbox' name='endorsement'>&nbsp;&nbsp;Endorsement<br/>
								<input type='checkbox' name='technology'>&nbsp;&nbsp;Technology Study<br/>
								<div>
									<input type='checkbox' name='otherFocusCkbox'>&nbsp;&nbsp;Other:<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;
									<input type='text' maxlength='30' name='otherFocus' onclick='this.focus()'><br/>						
								</div>
							</div>
						</div>
	
						<div id="archive-accord-timeofyear" class='archive-accord'>	
							<h3 id='timeofyear-header'><a href="#">Time of Year</a></h3>
							<div id='timeofyear-panel' style='display: none;'>
								<input type="checkbox" name='thanksgiving'>&nbsp;&nbsp;Thanksgiving<br/>
								<input type='checkbox' name='christmas'>&nbsp;&nbsp;Christmas<br/>
								<input type='checkbox' name='newYear'>&nbsp;&nbsp;New Year's<br/>
								<input type='checkbox' name='valentine'>&nbsp;&nbsp;Valentine's Day<br/>
								<input type='checkbox' name='president'>&nbsp;&nbsp;President's Day<br/>
								<input type='checkbox' name='july4'>&nbsp;&nbsp;Fourth of July<br/>
								<input type='checkbox' name='spring'>&nbsp;&nbsp;Spring<br/>
								<input type='checkbox' name='summer'>&nbsp;&nbsp;Summer<br/>
								<input type='checkbox' name='fall'>&nbsp;&nbsp;Fall<br/>
								<input type='checkbox' name='winter'>&nbsp;&nbsp;Winter<br/>
								<div>
									<input type='checkbox' name='otherTimeOfYearCkbox'>&nbsp;&nbsp;Other:<br/>
										&nbsp;&nbsp;&nbsp;&nbsp;
									<input type='text' maxlength='30' name='otherTimeOfYear' onclick='this.focus()'><br/>						
								</div>
							</div>
						</div>
					
					</td>
				</tr>
			</table>
			<div id="line3" style="line-height:130%;background-color:#F7F4EF;display:none">
				<h4 id='errorMsg' style="clear:both; margin-bottom:3px"></h4>
				<h4 class='learn more' >
					<img onclick="archCtrl.upload2Archive()" src="/images/Transparent.gif" class="itda-archive-icon up2-archive-btn" style='float:left;margin-right:25px;vertical-align:top'>
				</h4>
				
			</div>			
			<input type='hidden' name='pdfFile'/>
			<input type='hidden' name='imageFile'/>
			<input type='hidden' name='uuid'/>
			<input type='hidden' name='adTypeCode'/>
		  </form>
		</td>
		<td class='archive-right-col my-upload'>
		<div style='float:right'>
			   <div id="canvas" style="width:480px">
					<div class="line" id="line1">	  	
						  <div class="item" id="left-border">
						     <div class="sap-content planner-icon frame-left"></div>
						  </div>
						  <div class="item" id="center-border">
						  	<div class="sap-content">
						  	  <p id="adImage" style="text-align:center;line-height:120%"></p>
						  	  <div id="progressBar" style='margin-top:55%'></div>
							  <div id="filelist" style='text-align:center;line-height:120%'></div>
						  	</div>						  
						  </div>
						  <div class="item" id="right-border">
							<div class="sap-content  planner-icon frame-right"></div>
						  </div>
					</div>
					<div class="line" id="line2" style="line-height:130%;background-color:#F7F4EF">
					    <br/>
						<h4>Your Current Archive Usage (including this file):</h4>
						<h4 style='color:#0076A3'>0 MB of 15 GB</h4>
						<br/>
						<h4><span style='text-decoration:underline'>Add More</span> Storage to Your Archive</h4>
					    <br/>
						<h4 class='learn more' >
							<a href='javascript:void(0)' onclick='archCtrl.cancelUpload()'><span style='color:#0076A3'>Cancel Upload</span></a>
						</h4>
						<br/><br/>
					</div>

	      	    </div>
		</div>
	</td>
  </tr>
</table>