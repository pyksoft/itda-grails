<table cellpadding='0px' border='0px' cellspacing='0px' style='width: 1008px; margin:8px' id='search'>
	<tr>
	<td class='archive-left-col first'>
		<div style="position:relative;left:-15px;height:0" class='filter-element'><img onclick="showTips('#tipsDiag', '.archive-left-col.first', '/archive/tips-main.gsp', -8, 5)" class="itda-archive-icon tips-56-22" src="/images/Transparent.gif"/></div>
	 	<div id='filters'>
	       <div id='views'  class='filter-element'>
	       	  <h1 style='margin-top:20px'>View Archive</h1>
	       	  <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	       	  	<table cellspacing='0'><tr class='view-filter-ui' id='All'>
	       	  		<td class='itda-on td-wolsp'><div class='itda-archive-icon file-cabinet-icon' onclick='updateViewGroupFilters(this, "All");'></div></td>
	       	  		<td class='itda-on align-bottom'><span onclick='updateViewGroupFilters(this, "All");'>By Everything</span></td>
	       	  	</tr></table>
	       	  <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	       	  	<table cellspacing='0'><tr class='view-filter-ui' id='Purchased'>
	       	  		<td class='itda-off td-wolsp'><div class='store-icon as-cart-icon' onclick='updateViewGroupFilters(this, "Purchased");'></div></td>
	       	  		<td class='itda-off align-bottom'><span onclick='updateViewGroupFilters(this, "Purchased");'>By Purchased</span></td>
	       	  	</tr></table>
	       	  <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	       	  	<table cellspacing='0'><tr class='view-filter-ui' id='Favorites'>
	       	  		<td class='itda-off td-wolsp'><div class='itda-archive-icon favorite-black-icon' onclick='updateViewGroupFilters(this, "Favorites");'></div></td>
	       	  		<td class='itda-off align-bottom'><span onclick='updateViewGroupFilters(this, "Favorites");'>By Favorites</span></td>
	       	  	</tr></table>
	       	  <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	       	  	<table cellspacing='0'><tr class='view-filter-ui' id='PreviouslyRun'>
	       	  		<td class='itda-off td-wolsp'><div class='itda-archive-icon prev-run-black-icon' onclick='updateViewGroupFilters(this, "Previously Run");'></div></td>
	       	  		<td class='itda-off align-bottom'><span onclick='updateViewGroupFilters(this, "Previously Run");'>By Previously Run</span></td>
	       	  	</tr></table>
	       	  <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	       	  	<table cellspacing='0'><tr class='view-filter-ui' id='myScheduled'>
	       	  		<td class='itda-off td-wolsp'><div class='itda-archive-icon schedule-black-icon' onclick='updateViewGroupFilters(this, "Scheduled");'></div></td>
	       	  		<td class='itda-off align-bottom'><span onclick='updateViewGroupFilters(this, "Scheduled");'>By Scheduled</span></td>
	       	  	</tr></table>
	       	  <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	       	  	<table cellspacing='0'><tr class='view-filter-ui' id='highestRated'>
	       	  		<td class='itda-off td-wolsp'><div class='itda-archive-icon rating-black-icon' onclick='updateViewGroupFilters(this, "Highest Rated");'></div></td>
	       	  		<td class='itda-off align-bottom'><span onclick='updateViewGroupFilters(this, "Highest Rated");'>By Highest Rated</span></td>
	       	  	</tr></table>
	       	  <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	       	  	<table cellspacing='0'><tr class='view-filter-ui' id='mostDownloaded'>
	       	  		<td class='itda-off td-wolsp'><div class='itda-archive-icon download-black-icon' onclick='updateViewGroupFilters(this, "Most Downloaded");'></div></td>
	       	  		<td class='itda-off align-bottom '><span onclick='updateViewGroupFilters(this, "Most Downloaded");'>By Most Downloaded</span></td>
	       	  	</tr></table>
	       	  <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	       	  	<table cellspacing='0'><tr class='view-filter-ui' id='myUploads'>
	       	  		<td class='itda-off td-wolsp'><div class='itda-archive-icon my-uploads-icon' onclick='updateViewGroupFilters(this, "My Uploads");'></div></td>
	       	  		<td class='itda-off align-bottom '><span onclick='updateViewGroupFilters(this, "My Uploads");'>By My Uploads</span></td>
	       	  	</tr></table>
	       	  <div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	       </div>	  
		   <form action="#" name="filter-form" method='get'>
				<input type='hidden' name='max' value="60">
				<input type='hidden' name='offset' value="0">
				<%-- input type='hidden' name='allPortfolios' value="" class='search-filter-value'>
				<input type='hidden' name='newspapers' value="" class='search-filter-value'> --%>
				<input type='hidden' name='viewFilter' value="All">
			 
	 	       <div id='refineSearch'  class='filter-element' style='margin-top:20px'>
	 	       	  <h1>Refine Search</h1>
	 	       	  <div class='hr' style='margin-bottom:6px'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
					<span class='ad-all'><input type='radio' name='adType' value="Direct Mail and Newspaper Marketing" checked onclick='filterAdType(this)'/> All<br/></span>
					<span class='ad-all ad-news-planner-event'><input type='radio' name='adType' value="Newspapers Marketing" onclick='filterAdType(this);'/> Newspapers<br/></span>
					<span class='ad-all ad-directmail-planner-event'><input type='radio' name='adType' value="Direct Mail Marketing" onclick='filterAdType(this);'/> Direct Mail<br/></span>
	 	       	  <div class='hr' style='margin-top:6px'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
	 	       </div>	  

		 	   <div id='refine'  class='filter-element' style='margin-top:20px'>
		 	    <h1>Narrow Results <input name="search" onclick='doSearch();this.blur();return false' class="itda-archive-icon archive-search-button" value="" style='float:right' type="submit"></h1>
				<div style='float:right; cursor:pointer; position:relative; top:-5px' class='archive-search-link-orange' onclick='archCtrl.clearSearch();this.blur();return false'><b>Clear Search</b></div>
				<div style='clear:both'></div>		 			 	    	
	        	<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-date" class='archive-accord'>
					<h3 id='date-header'><a href="#">By Collection</a></h3>
					<div id="date-panel" style='display: none;'>
					<g:select id="portfolioDate" name='portfolioDate' value="${params?.portfolioDate}"
				    noSelection="${['null':'Select One...']}" class='ui-corner-all'
				    from='${portfolios}'
				    optionKey="portfolioDate" optionValue="description" optionValue="${{it.description + ' ' + String.format('%tb %<tY', it.portfolioDate)}}"></g:select>
					</div>
				</div>
				<div class='hr by-size by-all hidden'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-size" class='archive-accord by-size by-all hidden'>	
					<h3 id='size-header'><a href="#">By Size</a></h3>
					<div id='size-panel-search' style='display: none;'>
						<input type='checkbox' name='size' value="FP">&nbsp;&nbsp;Full Page<br/>
						<input type='checkbox' name='size' value="3_4V">&nbsp;&nbsp;3/4 Page Vertical<br/>
						<input type='checkbox' name='size' value="2_3V">&nbsp;&nbsp;2/3 Page Vertical<br/>
						<input type='checkbox' name='size' value="2_3H">&nbsp;&nbsp;2/3 Page Horizontal<br/>
						<input type='checkbox' name='size' value="1_2V">&nbsp;&nbsp;1/2 Page Vertical<br/>
						<input type='checkbox' name='size' value="1_2H">&nbsp;&nbsp;1/2 Page Horizontal<br/>
						<input type='checkbox' name='size' value="1_3V">&nbsp;&nbsp;1/3 Page Vertical<br/>
						<input type='checkbox' name='size' value="1_3H">&nbsp;&nbsp;1/3 Page Horizontal<br/>
						<input type='checkbox' name='size' value="1_4V">&nbsp;&nbsp;1/4 Page Vertical<br/>
						<input type='checkbox' name='size' value="1_4H">&nbsp;&nbsp;1/4 Page Horizontal<br/>
						<input type='checkbox' name='size' value="1_5V">&nbsp;&nbsp;1/5 Page Vertical<br/>
						<input type='checkbox' name='size' value="1_5H">&nbsp;&nbsp;1/5 Page Horizontal<br/>
						<input type='checkbox' name='size' value="1_62C">&nbsp;&nbsp;1/6 Page/Two Column<br/>
						<input type='checkbox' name='size' value="1_63C">&nbsp;&nbsp;1/6 Page/Three Column<br/>
						<input type='checkbox' name='size' value="1_8V">&nbsp;&nbsp;1/8 Page Vertical<br/>
						<input type='checkbox' name='size' value="1_8H">&nbsp;&nbsp;1/8 Page Horizontal<br/>
						<input type='checkbox' name='size' value="6CH">&nbsp;&nbsp;6 Column Horizontal<br/>
						<input type='checkbox' name='size' value="2PI">&nbsp;&nbsp;2 Panel Insert<br/>
						<input type='checkbox' name='size' value="4PI">&nbsp;4&nbsp;Panel&nbsp;Newspaper&nbsp;Insert<br/>
						<div>
							<input type='checkbox' name='otherSizeCode1' value='OTHER'>&nbsp;&nbsp;Other:
							&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' maxlength='30' name='otherSize' onclick='this.focus()'><br/>						
						</div>
					</div>
				</div>
				<div class='hr by-type by-all hidden'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-type" class='archive-accord by-type by-all hidden'>	
					<h3 id='type-header'><a href="#">By Type</a></h3>
					<div id='type-panel-search' style='display: none;'>
						<input type='checkbox' name='size' value="SL">&nbsp;&nbsp;Standard Letter<br/>
						<input type='checkbox' name='size' value="CH">&nbsp;&nbsp;Check<br/>
						<input type='checkbox' name='size' value="CL">&nbsp;&nbsp;Check Letter<br/>
						<input type='checkbox' name='size' value="IM">&nbsp;&nbsp;Invitation Mailer<br/>
						<input type='checkbox' name='size' value="SM">&nbsp;&nbsp;Self Mailer<br/>
						<input type='checkbox' name='size' value="PC">&nbsp;&nbsp;Postcard<br/>
						<input type='checkbox' name='size' value="FL">&nbsp;&nbsp;Flyer<br/>
						<div>
							<input type='checkbox' name='otherTypeCode' value='OTHER'>&nbsp;&nbsp;Other:
							&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' maxlength='30' name='otherSize' onclick='this.focus()'><br/>						
						</div>
					</div>
				</div>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-color" class='archive-accord'>	
					<h3 id='color-header'><a href="#">By Color</a></h3>
					<div id='color-panel' style='display: none;'>
						<input type='checkbox' name='color' value="1C"><span>1-Color</span><br/>
						<input type='checkbox' name='color' value="2C"><span>2-Color</span><br/>
						<input type='checkbox' name='color' value="4C" checked='checked'><span>4-Color</span>
					</div>
				</div>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-offers" class='archive-accord'>	
					<h3 id='offers-header'><a href="#">By Offers</a></h3>
					<div id="offers-panel-search" style='display: none;'>
						<input type="checkbox" name='offer' value="$995">&nbsp;&nbsp;$995<br/>
						<input type='checkbox' name='offer' value="$1495">&nbsp;&nbsp;$1495<br/>
						<input type='checkbox' name='offer' value="$500 Off">&nbsp;&nbsp;$500 Off<br/>
						<input type='checkbox' name='offer' value="50% Off">&nbsp;&nbsp;50% Off<br/>
						<input type='checkbox' name='offer' value="40% Off">&nbsp;&nbsp;40% Off<br/>
						<input type='checkbox' name='offer' value="Buy One Get One Free">&nbsp;&nbsp;Buy One Get One Free<br/>
						<input type='checkbox' name='offer' value="Try Before You Buy">&nbsp;&nbsp;Try Before You Buy<br/>
						<input type='checkbox' name='offer' value="As Low As XX Per Month">&nbsp;&nbsp;As Low As XX Per Month<br/>						
						<div>
							<input type='checkbox' name='otherOfferCode' value='OTHER'>&nbsp;&nbsp;Other:
							&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' maxlength='30' name='otherOffer' onclick='this.focus()'><br/>						
						</div>
					</div>
				</div>
<%-- 
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-elements" class='archive-accord'>	
					<h3 id='elements-header'><a href="#">By Elements</a></h3>
					<div id='elements-panel' style='display: none;'>
						<input type="checkbox" name='anatomy' value="Anatomy Image">&nbsp;&nbsp;Anatomy Image<br/>
						<input type='checkbox' name='product' value="Product Image">&nbsp;&nbsp;Product Image<br/>
						<input type='checkbox' name='patient' value="Patient Photo">&nbsp;&nbsp;Patient Photo<br/>
						<input type='checkbox' name='map' value="Map">&nbsp;&nbsp;Map<br/>
						<input type='checkbox' name='calendar' value="Calendar">&nbsp;&nbsp;Calendar<br/>
						<input type='checkbox' name='testing' value="Testing photos">&nbsp;&nbsp;Testing photos<br/>
						<input type='checkbox' name='coupons' value="Coupons">&nbsp;&nbsp;Coupons<br/>
						<input type='checkbox' name='policies' value="Policies">&nbsp;&nbsp;Policies<br/>
						<input type='checkbox' name='company' value="Company Logo">&nbsp;&nbsp;Company Logo<br/>
						<input type='checkbox' name='address' value="Address">&nbsp;&nbsp;Address<br/>
						<input type="checkbox" name='phone' value="Phone Number">&nbsp;&nbsp;Phone Number<br/>
					</div>
				</div>
--%>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-focus" class='archive-accord'>	
					<h3 id='focus-header'><a href="#">By Focus</a></h3>
					<div id='focus-panel-search' style='display: none;'>
						<input type="checkbox" name='testimonial' value="Testimonial">&nbsp;&nbsp;Testimonial<br/>
						<input type='checkbox' name='sale' value="Sale">&nbsp;&nbsp;Sale<br/>
						<input type='checkbox' name='trial' value="Trial">&nbsp;&nbsp;Trial<br/>
						<input type='checkbox' name='seminar' value="Seminar">&nbsp;&nbsp;Seminar<br/>
						<input type='checkbox' name='advertorial' value="Advertorial">&nbsp;&nbsp;Advertorial<br/>
						<input type='checkbox' name='features' value="Product Features">&nbsp;&nbsp;Product Features<br/>
						<input type='checkbox' name='benefits' value="Product Benefits">&nbsp;&nbsp;Product Benefits<br/>
						<input type='checkbox' name='upgrade' value="Upgrade">&nbsp;&nbsp;Upgrade<br/>
						<input type='checkbox' name='tinnitus' value="Tinnitus">&nbsp;&nbsp;Tinnitus<br/>
						<input type='checkbox' name='notice' value="Public Notice">&nbsp;&nbsp;Public Notice<br/>
						<input type="checkbox" name='opening' value="Grand Opening">&nbsp;&nbsp;Grand Opening<br/>
						<input type='checkbox' name='hearingTest' value="Free Hearing Test">&nbsp;&nbsp;Free Hearing Test<br/>
						<input type='checkbox' name='consultDemo' value="Free Consultation/Demonstration">&nbsp;&nbsp;Free Consultation/<br/>Demonstration<br/>
						<input type='checkbox' name='endorsement' value="Endorsement">&nbsp;&nbsp;Endorsement<br/>
						<input type='checkbox' name='technology' value="Technology Study">&nbsp;&nbsp;Technology Study<br/>
						<div>
							<input type='checkbox' name='otherFocusCode' value='OTHER'>&nbsp;&nbsp;Other:
								&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' maxlength='30' name='otherFocus' onclick='this.focus()'><br/>						
						</div>
					</div>
				</div>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-timeofyear" class='archive-accord'>	
					<h3 id='timeofyear-header'><a href="#">By Time of Year</a></h3>
					<div id='timeofyear-panel-search' style='display: none;'>
						<input type="checkbox" name='thanksgiving' value="Thanksgiving">&nbsp;&nbsp;Thanksgiving<br/>
						<input type='checkbox' name='christmas' value="Christmas">&nbsp;&nbsp;Christmas<br/>
						<input type='checkbox' name='newYear' value="New Year's">&nbsp;&nbsp;New Year's<br/>
						<input type='checkbox' name='valentine' value="Valentine's Day">&nbsp;&nbsp;Valentine's Day<br/>
						<input type='checkbox' name='president' value="President's Day">&nbsp;&nbsp;President's Day<br/>
						<input type='checkbox' name='july4' value="Fourth of July">&nbsp;&nbsp;Fourth of July<br/>
						<input type='checkbox' name='spring' value="Spring">&nbsp;&nbsp;Spring<br/>
						<input type='checkbox' name='summer' value="Summer">&nbsp;&nbsp;Summer<br/>
						<input type='checkbox' name='fall' value="Fall">&nbsp;&nbsp;Fall<br/>
						<input type='checkbox' name='winter' value="Winter">&nbsp;&nbsp;Winter<br/>
						<div>
							<input type='checkbox' name='otherTimeOfYearCode' value='OTHER'>&nbsp;&nbsp;Other:
							&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' maxlength='30' name='otherTimeOfYear' onclick='this.focus()'><br/>						
						</div>						
					</div>
				</div>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div id="archive-accord-filename" class='archive-accord'>	
					<h3 id='filename-header'><a href="#">By Keyword</a></h3>
					<div id="filename-panel" style='display: none;'>
						<input type='text' maxlength='30' name='keyword' value="" onclick='this.focus()'><br/>	
					</div>
				</div>
		 	</div>
		 	</form>
		 	<div class='filter-element' id='bottom'>
				<div class='hr'><img src='/images/itd/archiver/hr-bar.jpg'/></div>
				<div style='cursor:pointer' onclick='doSearch();this.blur();return false'><input name="search" class="itda-archive-icon archive-search-button" value="" id="search-button" type="submit"> <span class='archive-search-link-blue'><b>Search</b></span> </div>
				<div style='clear:both'></div>		 	
				<div style='float:right; cursor:pointer;line-height:130%' class='archive-search-link-orange' onclick='archCtrl.clearSearch();this.blur();return false'><b>Clear Search</b></div>
				<div style='clear:both'></div>		 			 	    	
	 	    </div> 
	 	 </div>
		</td>
		<td style='width: 8px; padding: 0px;'>&nbsp;</td>

		<td class='archive-right-col'>
		<div id='search-result'>
			<div id='results-top'>
		  	  <h1 class='resultTitle' style='float:left;margin-top:0'>Search Results</h1>
		  	  <span id='back-2-planner' style='float:right;display:none;cursor:pointer;position:relative;left:30px' onclick="swapPlannerCalView('detail')"><b style='bottom:2px;position:relative'>Back to Planner</b> <input class='tracker-icon tracker-detail-view-icon'/></span>
		  	  <img class='itda-archive-icon upload-pdf-btn' style='float:right' src='/images/Transparent.gif' onclick='archCtrl.showUpload();'/>
		  	</div>  
		  	<div style='clear:both'></div>
		  <table class='searchCriteriaHeader' cellpadding='0' border='0' cellspacing='0' width='100%'>
		  <tr>
		  	  <td style='width:132px'><b>You searched for:</b></td>
		      <td> <span id='searchCriteria'></span></td>
		  	  </tr>
		  </table>
		  <table class='resultsheader' cellpadding='0' border='0' cellspacing='0' width='100%'>
		  <tr class='noresult'><td><br/><br/><br/>
		  	<h3 class='nr-All nr-Highest-Rated nr-Most-Downloaded'>We are sorry, there are no results for your search.</h3>
		  	<h3 class='nr-Favorites'>You have not yet designated any Favorites.</h3>
		  	<h3 class='nr-Previously-Run'>You have not yet run any marketing in your Archive.</h3>
		  	<h3 class='nr-Scheduled'>You have not yet scheduled any marketing from your Archive.</h3>
		  </td></tr>
		  <tr id='result'>
		     <td id='resultPerPage' style='font-size:10.5px' width='230px'>
		  	  Items per Page <span style='letter-spacing:-1px'>| <a href='#' class='archive-link-default' onclick='resultsPerPage(this)'>6</a> |  <a href='#' class='archive-link-default'  onclick='resultsPerPage(this)'>12</a> |  <a href='#' class='archive-link-default'  onclick='resultsPerPage(this)'>24</a> |  <a href='#' class='archive-link-default' onclick='resultsPerPage(this)'>36</a> | <a href='#' class='archive-link-active'  onclick='resultsPerPage(this)'>60</a></span>
		     </td>
		     <td style='font-size:10.5px'>
		  	  <input type='checkbox' name='imagePreview' value='true' onclick="toggleImagePreview(this);"/> Image Preview
			</td>
			<td>
		  	  <span style='width:20px:float:left'></span>
		  	</td>
            <td style='font-size:10.5px'>
             Go to Page <select id='gotopage' onchange="goToPage(this);" class='ui-corner-all'><option value=''></select>
             </td>
            <td><span id='paginate' style='font-size:10.5px;top:2px;position:relative'></span></td>

			<td style="width:75px">&nbsp;
             
		  </td>
		  </tr></table>
		  <table cellpadding='0' border='0' cellspacing='0' width='100%' id='resultBody'>
		  <%------------- Dymanic content here ----------------%>
		  </table>
		  <table class='resultsfooter' cellpadding='0' border='0' cellspacing='0' width='100%'>
		   <tr>
            <td>
             <img class='itda-archive-icon left-arrow-btn' src='/images/Transparent.gif' onclick='prev();'/>
            </td>
			<td style='width:280px'>&nbsp;</td>
            <td>
             &nbsp;&nbsp;Go to Page&nbsp;<select id='gotopage-bottom' onchange="goToPage(this);" class='ui-corner-all'><option value=''></select>       
             </td>
             <td>
			</td>
			<td style='width:10px'>&nbsp;</td>			
            <td><span id='paginate-bottom' style='top:5px;position:relative'></span></td>
            <td> 		  	  
             <img class='itda-archive-icon right-arrow-btn' src='/images/Transparent.gif'  onclick='next();'/>
            </td>
		  </tr></table>
		  <div id='results-bot' style='height:1px'></div>
		 </div>
		<%------------ RESULT DETAIL --------------------------------%> 
		<div class='result-detail' style='width: 697px; margin:15px 30px 10px 30px; display:none'>
		  <table cellpadding='0' border='0' cellspacing='0' width='100%' class='result-detail' >
		  	<tr>
		  		<td width='487px'><h1 class='title'>Detail View</h1></td>
		  		<td width='180px' class='itda-off' onmouseover='toggleOverText(undefined, undefined, this)' onmouseout='toggleOverText(undefined,undefined, this)' onclick='toggleDetail()'><div style='float:right; line-height:20px;color:#555555'><b>&nbsp;Return to Search Results</b></div><div class='itda-archive-icon back-to-search-icon' style='float:right' onclick='toggleDetail()'></div></td>
		  	</tr>
		  </table>
		  
		  <div style='border:1px solid #B69A2F; background:white'>
		  <table cellpadding='0' border='0' cellspacing='0' width='100%'>
		  	<tr>
		  		<td width='280px' style='padding-left:25px'>
		  			<div id='ad-desc'></div>
		  			<div id='ad-type'></div>
		  			<div id='ad-file'></div>
		  			<div><img style="padding: 2px"	src="/images/Transparent.gif" /></div>
		  			<div id='ad-size'></div>
		  			<div id='ad-color'></div>
		  			<div class='hr' style='padding:5px 0px'><img src='/images/itd/archiver/hr-bar-205.jpg'/></div>
		  			<div id='ad-rating-title'>AVERAGE RATING</div>
		  			<div id='ad-rating' style='margin:5px 0px 5px 0px'></div>
		  			<div style='clear:both'><img src="/images/Transparent.gif"/></div>
		  			<div id='ad-rating-text' style='margin:5px 0px 5px 0px'></div>
		  			<div id='ad-rating-link' style='margin:5px 0px 5px 0px'></div>
		  			<div class='hr' style='padding:5px 0px'><img src='/images/itd/archiver/hr-bar-205.jpg'/></div>
		  			<%-- --%>
	       	  	<table cellpadding='0' border='0' cellspacing='0'><tr class='result-detail-link' id='addFavorite'>
	       	  	</tr></table> 
				<div id="status-message"></div>      	  	
	       	  	<table cellpadding='0' border='0' cellspacing='0'><tr class='result-detail-link' id='addPlanner'>
	       	  		<td><div class='itda-archive-icon add-planner-icon' onclick='addToPlanner(event)'></div></td>
	       	  		<td class='align-bottom'><span onclick='addToPlanner(event)'>Add to Planner</span></td>
	       	  	</tr></table>
				<div id="dialog-cal" title="" style="font-size: 11px; display: none; text-align:left; margin-bottom:5px">
				  <div style='margin-right:10px;color:black'>
				   <span id='news-planner-event' style="float:left; margin:-4px 7px 0px 4px;"></span> Select a date you would like this ad to appear in your planner then click the close button.
				   </div>
				   <img style="padding-top: 9px;clear:both" src="/images/Transparent.gif"/>
				   <div style='background-color:white; clear:both;border:1px solid #B69A2F;' >
				   	<%--<div id="planner-calendar" ></div> --%>
				   	<div id='fc-calendar' style='margin:5px 20px 5px 15px'></div>
				   </div>
				</div>	       	  	
	       	  	<table cellpadding='0' border='0' cellspacing='0'><tr class='result-detail-link' id='downloadPdf'>
	       	  		<td><div class='itda-archive-icon download-pdf-icon' onclick='getPdf(true);'></div></td>
	       	  		<td class='align-bottom'><span onclick='getPdf(true);'>Download PDF</span></td>
	       	  	</tr></table>
	       	  	<table cellpadding='0' border='0' cellspacing='0'><tr class='result-detail-link' id='downloadJpg'>
	       	  		<td><div class='itda-archive-icon download-jpg-icon' onclick='getJpg(true);'></div></td>
	       	  		<td class='align-bottom'><span onclick='getJpg(true);'>Download JPG</span></td>
	       	  	</tr></table>
<%--	       	  	
				<table cellpadding='0' border='0' cellspacing='0'><tr class='result-detail-link' id='printPdf'>
	       	  		<td><div class='itda-archive-icon print-pdf-icon' onclick='getPdf(false);'></div></td>
	       	  		<td class='align-bottom'><span onclick='getPdf(false);'>Print PDF</span></td>
	       	  	</tr></table>
	       	  	
	       	  	<table cellpadding='0' border='0' cellspacing='0'><tr class='result-detail-link' id='sendVendor'>
	       	  		<td><div class='itda-archive-icon send-vendor-icon' onclick=''></div></td>
	       	  		<td class='align-bottom'><span onclick='/*sendToVendorDiag(event,gcurrAd)*/'>Send to Vendor</span></td>
	       	  	</tr></table>
 --%>		  			
		  			<%-- --%>
		  			<div class='hr' style='padding:5px 0px'><img src='/images/itd/archiver/hr-bar-205.jpg'/></div>
		  			<div id='ad-colors' style='float:left'>
						<table><tr>
							<td class='itda-off'><div class='itda-archive-icon c1-on-icon center' onclick='toggleAdImage(this, "1");'></div><b>1-Color</b></td>
							<td class='itda-off'><div class='itda-archive-icon c2-on-icon center' onclick='toggleAdImage(this, "2");'></div><b>2-Color</b></td>
							<td class='itda-on'><div class='itda-archive-icon c4-on-icon center' onclick='toggleAdImage(this, "4");'></div><b>4-Color</b></td>
						</tr></table>
					</div>
		  			<div class='hr' style='padding:5px 0px'><img src='/images/itd/archiver/hr-bar-205.jpg'/></div>
		  			<div id='select-btn' class='itda-archive-icon select-btn' style='margin:5px 0px; float:left;visibility:hidden'></div>
		  		</td>
		  		<td width='417px'>
		  			<div id='ad-image2' style='width:375px;height:410px;margin:15px; border:1px solid #B69A2F;padding:15px 0px'>
		  			    <p style='vertical-align:bottom;line-height:410px;' id='ad-image'>
						  	  
						  	  </p>
		  			</div>
		  		</td>
		  	</tr>
		  	<tr>
		  		<td></td>
		  		<td>
		  			<table class='center'><tr>
			            <td id='prevResult' width='50%'>
			            </td>
			            <td id='nextResult' width='50%'> 		  	  
			            </td>
		  			</tr></table>
		  		</td>
		  	</tr>
		  </table>
		  </div>
		</div>
		<div class='result-detail' style='width: 697px; margin:15px 30px 10px 30px; display:none'>
		  <h1 class='title'>Companion Pieces</h1>
		</div>
		  <table class='result-detail' style='display:none' cellpadding='0' border='0' cellspacing='0'>
		  	<tr>
		  		<td width='30px' id='prev-companion'>
		  		</td>
		   		<td>
		  			<div  style='width: 697px;'>
					  <div style='border:1px solid /*red*/#B69A2F; background:white'>
						<table style='margin: 10px 20px; height:190px; width:655px'>
							<tr id='companionPieces'>
							</tr>
						</table>
					  </div>
					</div>
			  </td>
			  <td width='30px' id='next-companion'></td>
		  	</tr>
		  </table>
		  
		  
		<%---------------------------- --%>
		<br />
 
		</td>
	</tr>
</table>
