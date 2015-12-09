<div>
<form id="saveResult" method="post">
 <input type='hidden' name='entryId' value=''/>
<table style='border:1px solid #B69A2F;float:left' cellspacing='0' cellpadding='0'>
	<tr>
	    
		<td style='margin-top: 10px;background-color: white; height:600px; width:179px;; font-size:12px;line-height:140%'>
			<div style='height: 25px'></div>
			<div id='result-detail-content-selectedAd' style='display:none; margin:0px 0px 0px 10px; line-height:150%'>
				<div id='result-detail-contentselectedAdDate'></div>
				<div class="hr"><img src="/images/itd/archiver/hr-bar-205.jpg"/></div>
				<div id='result-detail-content-selectedAdInfo'></div>
				<div class="hr"><img src="/images/itd/archiver/hr-bar-205.jpg"/></div>
				<div id='result-detail-content-selectedAdImage'><img src='/images/itd/planner/sample-img.jpg' style='max-height: 250px; max-width: 180px'/></div>
			</div>
			<div class='default-tracker-msg'>Select your<br/>marketing from<br/>the list on the<br/>right to start<br/>entering your results.</div>
		</td>

		<td style='margin-top: 10px;width:520px;border:0px 1px 0px 0px solid #B69A2F;background-color: white'>
		  <div style="min-height:650px;border:1px solid #B69A2F;background-color:white;margin:7px">
		  	<h1 id='result-detail-content-result-title'>&nbsp;Results</h1>
		  	<table cellspacing='1px' cellpadding='0' style='background-color:white; margin-left:30px'>
		  		<tr style='background-color:white;color:#0076A3'>
		  		 <td width='295px' class='description'>Description</td>
		  		 <td width='100px'>Results</td>
		  		 <td width='60px'>Publish <img src="/images/Transparent.gif" style="float:right" class="tracker-icon tracker-check-icon"></td>
		  		</tr>
		  		</table>
		  	<table class='tabs-3-numbers' cellspacing='1px' cellpadding='0'>
		  		<tr class='even'>
		  		 <td width='270px' class='description'><div></div>Number of Calls</td>
		  		 <td width='100px' class='center'><div></div><input type='text' name='calls' class='integer' maxlength="9"/></td>
		  		 <td width='60px' onclick='togglePublish(this);'><div class="tracker-icon tracker-check-icon center">
		  		 	<input type='hidden' name='publishCalls' value='true'/>
		  		 </div></td>
		  		</tr>
		  		<tr class='even'>
		  		 <td class='description'><div></div>Number of Tests Set</td>
		  		 <td class='center amt'><input type='text' name='testsSet' class='integer' maxlength="9"/></td>
		  		 <td width='60px' onclick='togglePublish(this);'><div class="tracker-icon tracker-check-icon center">
		  		 	<input type='hidden' name='publishTestsSet' value='true'/>
		  		 </div></td>
		  		</tr>
		  		<tr class='even'>
		  		 <td class='description'><div></div>Number of Tests Sold</td>
		  		 <td class='center amt'><input type='text' name='testsSold' class='integer' maxlength="9"/></td>
		  		 <td width='60px' onclick='togglePublish(this);'><div class="tracker-icon tracker-check-icon center">
		  		 	<input type='hidden' name='publishTestsSold' value='true'/>
		  		 </div></td>
		  		</tr>
		  		<tr class='even'>
		  		 <td class='description'><div></div>Number of Hearing Aids Sold</td>
		  		 <td class='center amt'><input type='text' name='hearingAidsSold' class='integer' maxlength="9"/></td>
		  		 <td width='60px' onclick='togglePublish(this);'><div class="tracker-icon tracker-check-icon center">
		  		 	<input type='hidden' name='publishHearingAidsSold' value='true'/>
		  		 </div></td>
		  		</tr>
		  		<tr class='even'>
		  		 <td class='description'><div></div>Number of Tested-Not-Sold</td>
		  		 <td class='center amt'><input type='text' name='testedNotSold' class='integer' maxlength="8" onfocus="calcTestsNotSold()"/></td>
		  		 <td width='60px' onclick='togglePublish(this);'><div class="tracker-icon tracker-check-icon center">
		  		 	<input type='hidden' name='publishTestedNotSold' value='true'/>
		  		 </div></td>
		  		</tr>
		  		
		  	</table>
		  	<div style="margin: 5px 12px 5px 0px;">
		  		<input type="submit" class="tracker-icon save-btn" value="" style="margin:2px 10px 5px 365px" onclick="saveResult(event);this.blur();return false;" disabled="disabled">
		  	</div>
		  	<table class='tabs-3-numbers' cellspacing='1px' cellpadding='0' >
		  		<tr class='even'>
		  		 <td width='270px' class='description' style='background-color:white'><div style='height:20px'></div><b>EXPENSE TOTAL</b></td>
		  		 <td width='100px'>
		  		 	<div style='height:10px'></div>
		  		 	<input type='text' name='totalExpense' readonly="readonly" class='readonly amount'/>
		  		 </td>
		  		</tr>
	  		</table>	
	  		  	<br/>
		  	<table class='tabs-3-numbers' cellspacing='1px' cellpadding='0'>
		  		<tr class='even'>
		  		 <td width='270px' class='result-summary'><div></div><br/><b>Gross Sales</b></td>
		  		 <td width='100px' class='center'><input type='text' name='grossSales' readonly="readonly" class='readonly amount'/></td>
		  		 <td width='60px' onclick='togglePublish(this);'><div class="tracker-icon tracker-check-icon center">
		  		   <input type='hidden' name='publishGrossSales' value='true'/>
		  		 </div></td>
		  		</tr>
		  		<tr class='even'>
		  		 <td  class='result-summary'><div></div><br/><b>Return-on-Investment</b></td>
		  		 <td class='center amt'><input type='text' name='returnOnInvest'  readonly="readonly" class='readonly'/></td>
		  		 <td width='60px' onclick='togglePublish(this);'><div class="tracker-icon tracker-check-icon center">
		  		 	<input type='hidden' name='publishReturnOnInvest' value='true'/>
		  		 </div></td>
		  		</tr>
		  		<tr class='even'>
		  		 <td  class='result-summary'><div></div><br/><b>Cost Per Lead</b></td>
		  		 <td class='center amt'><input type='text' name='costPerLead' readonly="readonly" class='readonly amount'/></td>
		  		 <td width='60px' onclick='togglePublish(this);'><div class="tracker-icon tracker-check-icon center">
		  		 	<input type='hidden' name='publishCostPerLead' value='true'/>
		  		 </div></td>
		  		</tr>
		  		<tr class='even'>
		  		 <td  class='result-summary'><div></div><br/><b>Cost Per Sale</b></td>
		  		 <td class='center amt'><input type='text' name='costPerSale' readonly="readonly" class='readonly amount'/></td>
		  		 <td width='60px' onclick='togglePublish(this);'><div class="tracker-icon tracker-check-icon center">
		  		 	<input type='hidden' name='publishCostPerSale' value='true'/>
		  		 </div></td>
		  		</tr>
		  	</table>
		  	<div style="margin: 5px 12px 5px 0px;">
		  		<div style="float: right;">
		  		<input type="submit" class="tracker-icon save-btn" value="" style="margin:2px 2px 5px 10px;float: right" onclick="saveResult(event);this.blur();return false;" disabled="disabled">
		  		<input type='submit' class="tracker-icon calculate-icon" style="float: left"onclick='calculateResults(event, this);return false;' disabled="disabled" value=''/></div>
		  	</div>
		  	<div style='clear:both'></div>
		  	<div class='review'>
						<div id='errors' class="errors" style='display:none;width:96%'>a</div>
		  				<div id='newspaper'><span class='red'>*</span>&nbsp;Placement was: <input style='margin-left:15px' type='radio' name='placement' value='Great'/> Great
				  	                   <input style='margin-left:25px' type='radio' name='placement' value='Good'/> Good
				  	                   <input style='margin-left:25px' type='radio' name='placement' value='OK'/> OK
				  	                   <input style='margin-left:25px' type='radio' name='placement' value='Poor'/> Poor<br/>
						<span class='red'>*</span>&nbsp;Number of same-day competitive ads was: 
				  		<input type='text' class='integer' name='numberCompetitiveAd' value='' size='4' maxlength='4'/><br/>
				  		</div>
				  		&nbsp;<span>My rating for this</span> <span id="ad">ad</span> <span>is:</span> 
				  		<input type='submit' onclick="return resultRating(this, '1');" value="" class='tracker-icon tracker-0-star-icon'/><input onclick="return resultRating(this, '2');" type='submit' value="" class='tracker-icon tracker-0-star-icon'/><input onclick="return resultRating(this, '3');" type='submit' value="" class='tracker-icon tracker-0-star-icon'/><input onclick="return resultRating(this, '4');" type='submit' value="" class='tracker-icon tracker-0-star-icon'/><input onclick="return resultRating(this, '5');" type='submit' value="" class='tracker-icon tracker-0-star-icon'/>
				  		<input type='hidden' name='rating' value=''/>														  		
						<br/>&nbsp;My review:<br/>
						<div style='margin:0px 25px'>
					  		<div><span style='float:left' class='red'>Enter review title:</span><span onclick='reviewPolicy(event);return false;' class='planner-detail-link-orange' style='float:right;text-decoration:underline;color:#F6931E;cursor:pointer'>Our Review Policy</span></div>
					  		<div style='clear:both'></div>
					  		<input type='text' name='title'  maxlength='256' style='width: 100%'/>
					  						  				  	                   
					  		<br/><span class='red'>Type your review here:</span><br/>
					  		<textarea name='review' style='width: 100%;height:80px'></textarea><br/>
				  	    </div> 
					  		
					  	<div>
					  	    <span class='red' style='padding-left:25px'>* Required for rating</span>  
					  		<input type="submit" onclick="publishResult(event);this.blur();return false;" style="margin:10px 14px 5px 5px;float: right" value="" class="tracker-icon publish-btn" disabled="disabled"/>
					  		<input type="submit" onclick="saveResult(event);this.blur();return false;" style="margin:10px 5px;float: right" value="" class="tracker-icon save-btn" disabled="disabled"/>
					  	</div>
					  	<div style='height: 15px'></div>
			</div>
		  </div>
		</td>
	</tr>
</table>
</form>		
</div>