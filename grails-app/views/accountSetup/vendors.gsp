<%@ page import="com.itda.Portfolio"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <link rel="stylesheet" href="/css/main.css" />
    <link rel="stylesheet" href="/css/itda.css" />
    <link rel="stylesheet" href="/css/sap-fivecol-2.css" />
    <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
<link type="text/css" href="/jquery/css/smoothness/jquery-ui-1.8.7.custom.css" 	rel="stylesheet" />
<script type="text/javascript" src="/jquery/js/jquery-1.4.4.min.js"></script >
<script type="text/javascript" 	src="/jquery/js/jquery-ui-1.8.7.custom.min.js"></script>
	<script type='text/javascript' src='/js/myAccount/myAcct.js'></script>        
	<script type='text/javascript' src='/js/common.js'></script>        
	<script type='text/javascript' src='/js/jquery.cookie.js'></script>
	<script type='text/javascript'>
	$(document).ready(function() {
		$('#tabs').tabs({
			selected: 1,
		    select: function(event, ui) {
			        if( ui.index == 0 )
			            location.href = '/accountSetup/newspapers';
			        else if( ui.index == 1 )
			            location.href = '/accountSetup/vendors';
			        else if( ui.index == 2 )
			            location.href = '/accountSetup/competition';
			        else if( ui.index == 3 )
			            location.href = '/accountSetup/manufacturers';
			        return false;
			    }
			});		
			$('body.myAcct div#tabs.ui-tabs ul.ui-tabs-nav li a[href="#tabs-4"]').parent().addClass('last-tab');
			if($.cookie('accountVendorPopup') == '1') {
				var title = 'Enter your Vendor contact<br/>information here.';
				var desc = 'The business name will show up in<br/>your drop down menus and their email<br/>address will be used when sending<br/>a link to download direct mail files.';
				openAcctInfoDialog(title, desc);
	    		$.cookie('accountVendorPopup', null, { expires: 0, path: '/accountSetup/vendors'});
	    		$.getJSON('/myAccount/updateSettings?accountVendorPopup=1', {}, function(data) {});
    		}				

			//if( $('div#tabs table.acct-content table').length == 0 ){
			//	openAcctInfoDialog(title, desc);
			//}
	});
	</script>    
<title>My Account</title>
</head>
<body class="myAcct" style='border:none'>
<g:include view="common/header.gsp" params="[controller:params.controller]"/>
<div class="body" style="padding-top: 60px;">
       	  <img style="padding:0px;" src="/images/Transparent.gif" class="center"/>
            <g:if test="${flash.message}">
            <br/><div class="message">${flash.message}</div>
            </g:if>
          <%-- 
 	      <g:hasErrors bean="${vendorInstance}">
	         <div class="errors">
	      		<g:renderErrors bean="${vendorInstance}" as="list" />
	         </div>
	      </g:hasErrors>
	      --%>            
<div id="canvas" width="992px">

	<div class="line" id="line1">	  	
	  <div class="item" id="item1">
	    <div class="sap-content"></div>
	  </div>
	  <div class="item" id="item2">
	  	<div class="sap-content"><p style="padding: 45px 18px;">
	  	<strong>My Account</strong><br/><br/>
	  	 <br/>
	  	<a href='/accountSetup/contactInfo' class='acct-link-default'>Contact Information</a><br/>
	  	<a href='/accountSetup/subscriptionHistory' class='acct-link-default'>Billing History</a><br/>
	  	<a href='/accountSetup/usernamepassword' class='acct-link-default'>Username & Password</a><br/>
	  	<a href='/accountSetup/paymentInfo' class='acct-link-default'>Payment Information</a><br/>
	  	<a href='/accountSetup/offices' class='acct-link-default'>Offices</a><br/>
	  	<a href='/accountSetup/territory' class='acct-link-default'>Zip Codes</a><br/>
	  	<a href='/accountSetup/newspapers' class='acct-link-default'>Newspapers</a><br/>
	  	<a href='/accountSetup/vendors' class='acct-link-active'>Vendors</a><br/>
	  	<a href='/accountSetup/competition' class='acct-link-default'>Competition</a><br/>
	  	<a href='/accountSetup/manufacturers' class='acct-link-default'>Manufacturers</a><br/>
	  	</p>
	  	</div>
	  </div>
	  <div class="item" id="item3">

	  	<div class="sap-content"></div>
	  </div>
	  <div class="item" id="item4">
	  	<div class="sap-content">
  			<div id="tabs" class='page-bg'>
				<ul>
					<li><a href="#tabs-1">Newspapers</a></li>
					<li><a href="#tabs-2">Vendors</a></li>
					<li><a href="#tabs-3">Competitors</a></li>
					<li><a href="#tabs-4">Manufacturers</a></li>
				</ul>
				<div id="tabs-1">
					Newspapers
				</div>
				<div id="tabs-2">
					<table width="100%" class='acct-content'>
		            <tr><td >
						<g:include view="accountSetup/listVendorTabFrag2.gsp"/>	 
						<g:submitButton name="addVendor" value="" class="acct-add-vendor-button my-acct" style="float:right" onclick="myAcctDialog(); return false"/><br/>

						<div style="clear:both"></div>
						<div class='paginateButtons' style="float:right">
							<g:paginate controller="accountSetup" action="vendors" total="${vendorInstanceList.totalCount}"></g:paginate>
						</div>  
		            </td></tr>
					</table>
				</div>
				<div id="tabs-3">
				    Competitors
				</div>
				<div id="tabs-4">
					Manufacturers	
				</div>
			</div>			
	  	</div>
	  </div>
	  <div class="item" id="item5">
	  	<div class="sap-content"></div>
	  </div>
	</div>
	
</div>
</div>
<g:include view="common/footer.gsp" params="[controller:params.controller]"/>
	  <div id="dialog-my-acct" title="" style="font-size: 13; display: none; text-align:left;z-index:100000; overflow:hidden; min-height:550px; width:280px">
            <div id="errorList" class="errors" style="display: none;font-size:14px"></div>	
				<table width="100%" class='acct-content'>
					<tr>
						<td>
						<h1><span id="action">Who are your Vendors?</span></h1>
						</td>
					</tr>
					<tr><td>	  		
	  		     		<g:include view="accountSetup/vendor-new.gsp"/>
	  		     		</td>
					</tr>
					<tr>
						<td style='vertical-align:bottom; padding: 10px 10px 0 0'>	  		
							<input class="acct-add-button my-acct" type="submit" onclick="saveAccountRelationship('/accountSetup/saveVendor', '/accountSetup/vendors', '#acctInfoForm', '#errorList'); return false;" value="" name="add-btn" style="float:right;margin-left:10px">
							<input class="acct-update-button" type="submit" onclick="saveAccountRelationship('/accountSetup/updateVendor', '${request.getRequestURL()}', '#acctInfoForm', '#errorList'); return false;" value="" name="update-btn" style="float:right;margin-left:10px">
							<input class="tracker-icon tracker-cancel-gray-btn" type="submit" onclick="gMyAcctDiag.dialog('close');return false;" value="" name="update" style="float:right">
	  		     		</td>
					</tr>
				</table>	
	  </div> 	  	   
	  <div id="dialog-small" class='transition-bg' title="" style="font-size: 16; line-height:1.3; display: none; text-align:left;z-index:100000"></div>   
</body>
</html>
