 	   <div class='quickLink filter-element' id='tip'><a href="#tips"><img onclick="showTips('#tipsDiag', '.reportLeftCol', '/myReport/tips-report-plan.gsp', -10, 5)" class="itda-archive-icon tips-56-22" src="/images/Transparent.gif"/></a></div>
 	   <div style="padding:4px 0 0" class='quickLink filter-element' id='rpt'><a href="#close" onclick='javascript:history.back();return false;'><img class="planner-icon reports-145-22" src="/images/Transparent.gif"/></a></div>
	 	<div id='reportFilters'>
	  
		   <form id="filter-form" name="filter-form" method='post' target="#">
				<input type='hidden' name='max' value="80"/>
				<input type='hidden' name='offset' value="0"/>		
				<input type='hidden' name='tab' value=""/>
		 	   <div id='refine'  class='filter-element' style='margin-top:20px'>
		 	    <h1>Select</h1>
				<div data-id='#expenseTotalFilter' class='showExpenses hide'>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-expense" class='archive-accord'>
					<h3 id='expense-header'><a href="#">Expense Total</a></h3>
					<div id='expenseTotalFilter'>
						<select name='totalExpense' class='ui-corner-all'>
						    <option value=''>Select One...</option>
							<option value='desc'>Highest to Lowest</option>
							<option value='asc'>Lowest to Highest</option>
						</select>
					</div>
				</div>
				</div>
				<div data-id='#grossSalesFilter' class='showSales hide'>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-sale" class='archive-accord'>
					<h3 id='sale-header'><a href="#">Gross Sales</a></h3>
					<div id='grossSalesFilter'>
						<select name='grossSales' class='ui-corner-all'>
						    <option value=''>Select One...</option>
							<option value='desc'>Highest to Lowest</option>
							<option value='asc'>Lowest to Highest</option>
						</select>
					</div>
				</div>			
				</div>
				<div data-id='#roiFilter' class='showResults hide'>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-roi" class='archive-accord'>
					<h3 id='roi-header'><a href="#">Return-on-Investment</a></h3>
					<div id='roiFilter'>
						<select name='returnOnInvest' class='ui-corner-all'>
						    <option value=''>Select One...</option>
							<option value='desc'>Highest to Lowest</option>
							<option value='asc'>Lowest to Highest</option>
						</select>
					</div>
				</div>				
				</div>
				<div data-id='#cpsFilter' class='showResults hide'>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-cps" class='archive-accord'>
					<h3 id='cps-header'><a href="#">Cost per Sale</a></h3>
					<div id='cpsFilter'>
						<select name='costPerSale' class='ui-corner-all'>
						    <option value=''>Select One...</option>
							<option value='desc'>Highest to Lowest</option>
							<option value='asc'>Lowest to Highest</option>
						</select>
					</div>
				</div>		
				</div>
				<div data-id='#cplFilter' class='showResults hide'>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-cpl" class='archive-accord'>
					<h3 id='cpl-header'><a href="#">Cost per Lead</a></h3>
					<div id='cplFilter'>
						<select name='costPerLead' class='ui-corner-all'>
						    <option value=''>Select One...</option>
							<option value='desc'>Highest to Lowest</option>
							<option value='asc'>Lowest to Highest</option>
						</select>
					</div>
				</div>		
				</div>
				<div class='hr showAll'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-type" class='archive-accord showAll'>	
					<h3 id='type-header'><a href="#">Marketing Type</a></h3>
					<div id='type-panel' class='hide'>
						<input type='checkbox' name='className' value="news-planner-event" data-name='Newspapers Ads'/>&nbsp;&nbsp;Newspapers<br/>
						<input type='checkbox' name='className' value="directmail-planner-event" data-name='Direct Mail'/>&nbsp;&nbsp;Direct Mail<br/>
						<input type='checkbox' name='className' value="media-planner-event" data-name='Media'/>&nbsp;&nbsp;Media<br/>
						<input type='checkbox' name='className' value="event-planner-event" data-name='Events'/>&nbsp;&nbsp;Events<br/>
						<input type='checkbox' name='className' value="miscellaneous-planner-event" data-name='Miscellaneous'/>&nbsp;&nbsp;Miscellaneous<br/>
					</div>
				</div>
				<div data-id='#competitorList' class='showCompetition hide'>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-size" class='archive-accord'>	
					<h3 id='size-header'><a href="#">Competitor</a></h3>
					<div id='size-panel'>
						<div id='competitorList'>
	                    <g:each in="${model.competitors}" var="competitor">
	                            <input type="checkbox" name=competitors value='${competitor.id}' data-name='${competitor.businessName}'/>&nbsp;&nbsp;${competitor.businessName}<br/>
	                    </g:each>						
						</div>
					</div>
				</div>
				</div>
				<div data-id='#officeList' class='showExpenses showSales showMarketing showResults hide'>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-size" class='archive-accord'>	
					<h3 id='size-header'><a href="#">Office</a></h3>
					<div id='size-panel' class='hide'>
						<div id='officeList'>
	                    <g:each in="${model.offices}" var="office">
	                            <input type="checkbox" name='offices' value='${office.id}' data-name='${office.name}'/>&nbsp;&nbsp;${office.name}<br/>
	                    </g:each>												
						</div>
					</div>
				</div>
				</div>
				<div data-id='#vendorList' class='showExpenses showCompetition hide'>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-color" class='archive-accord'>	
					<h3 id='color-header'><a href="#">Vendor</a></h3>
					<div id='color-panel'>
						<div id='vendorList'>
	                    <g:each in="${model.publications}" var="publication">
	                            <input type="checkbox" name='publications' value='${publication.id}' data-name='${publication.newspaperOrPublicationName}'/>&nbsp;&nbsp;${publication.newspaperOrPublicationName}<br/>
	                    </g:each>												
	                    <g:each in="${model.vendors}" var="vendor">
	                            <input type="checkbox" name='vendors' value='${vendor.id}' data-name='${vendor.vendorName}'/>&nbsp;&nbsp;${vendor.vendorName}<br/>
	                    </g:each>																		
						</div>
					</div>
				</div>
				</div>				
	        	<div class='hr showAll'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-date" class='archive-accord showAll'>
					<h3 id='date-header'><a href="#">Time Period</a></h3>
					<div id="date-panel" class='hide'>
						<select name='period' class='ui-corner-all' onchange='selectPeriod(this);'>
						    <option value=''>Select One...</option>
		                    <g:each in="${model.periods.keySet()}" var="key">
		                            <option value='${model.periods[key]}'/>&nbsp;&nbsp;${key}</option>
		                    </g:each>												
						</select>
						<table>
						<tr>
							<td colspan="2" class='time'>From:<br/>					
							<g:datePicker name="from" value="" precision="month"
	              noSelection="['':'']" years="${start..end}"/>
	              			</td>
						</tr>
						<tr>
							<td colspan="2" class='time'>To:<br/>					
							<g:datePicker name="to" value="" precision="month"
	              noSelection="['':'']" years="${start..end}"/>
							</td>
						</tr>
						</table>
					</div>
				</div>				
				<div class='hr showAll'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-offers" class='archive-accord showAll'>	
					<h3 id='offers-header'><a href="#">Include</a></h3>
					<div id="offers-panel" class='hide'>
						<input type="checkbox" name='size' value="1" data-name='Size/Type'>&nbsp;&nbsp;Size/Type<br/>
						<input type='checkbox' name='color' value="1" data-name='Color'>&nbsp;&nbsp;Color<br/>
						<div dta-id='sales-results-include' id='sales-results-include' class='showSales showResults'>
							<input type='checkbox' name='includeTotalExpense' value="1" data-name='Expense Total'>&nbsp;&nbsp;Expense Total<br/>
							<input type='checkbox' name='rating' value="1" data-name='Rating'>&nbsp;&nbsp;Ratings<br/>
							<input type='checkbox' name='includeVendor' value="1" data-name='Vendor'>&nbsp;&nbsp;Vendor<br/>
						</div>
						<div data-id='#results-include' id='results-include' class='showResults'>
							<input type='checkbox' name='placement' value="1" data-name='Placement'>&nbsp;&nbsp;Placement<br/>
						</div>
					</div>
				</div>
				<div class='hr showCompetition showMarketing'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-sort" class='archive-accord showCompetition showMarketing'>	
					<h3 id='sort-header'><a href="#">Sort</a></h3>
					<div id='sort-panel'>
						<select name='sortByDate' class='ui-corner-all'>
						    <option value=''>Select One...</option>
							<option value='desc'>Newest to Oldest</option>
							<option value='asc'>Oldest to Newest</option>
						</select>
					</div>
					
				</div>
				
		 	<div class='filter-element' id='bottom'>
				<input style='float:right' name="report" class="planner-icon generateReport" value="" type="submit" onclick="submitForm('#filter-form');this.blur();return false;"/>		 	
	 	    </div>
<%-- 	 	    
	 	    <h1>File</h1>
	 	    <table cellspacing="0" cellpadding="0" border="0">
				<tr id="downloadPdf" class="result-detail-link">
					<td>
					<div class="itda-archive-icon download-pdf-icon" onclick="getPdf(true);"></div>
					</td>
					<td class="align-bottom">
					<span onclick="getPdf(true);">Download PDF</span>
					</td>
				</tr>
			</table>
	 	    <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	 	    <table cellspacing="0" cellpadding="0" border="0">
				<tr id="downloadPdf" class="result-detail-link">
					<td>
					<div class="itda-archive-icon print-pdf-icon" onclick="getPdf(true);"></div>
					</td>
					<td class="align-bottom">
					<span onclick="getPdf(true);">Print PDF</span>
					</td>
				</tr>
			</table>			
	 	    <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div><br/>
		 	</div>
--%>		 	
		 	</form>
	 	 </div>