<%@ page import="com.itda.Portfolio"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="stylesheet" href="/css/sap-fivecol.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
<link type="text/css" href="/jquery/css/smoothness/jquery-ui-1.8.7.custom.css" 	rel="stylesheet" />
<script type="text/javascript" src="/jquery/js/jquery-1.4.4.min.js"></script >
<script type="text/javascript" 	src="/jquery/js/jquery-ui-1.8.7.custom.min.js"></script>
	<script type='text/javascript' src='/js/myAccount/myAcct.js'></script>        
	<script type='text/javascript' src='/js/common.js'></script>        
<title>My Account</title>
</head>
<body  style='border:none'>
<g:include view="common/header.gsp" params="[controller:params.controller]"/>
<div style="clear:both;height:5px"></div>
<div class="body">
            <g:if test="${flash.message}">
            <br/><div class="message">${flash.message}</div>
            </g:if>
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
	  	<a href='/accountSetup/offices' class='acct-link-active'>Offices</a><br/>
	  	<a href='/accountSetup/territory' class='acct-link-default'>Zip Codes</a><br/>
	  	<a href='/accountSetup/newspapers' class='acct-link-default'>Newspapers</a><br/>
	  	<a href='/accountSetup/vendors' class='acct-link-default'>Vendors</a><br/>
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
	  	   <div class='acct-content'>
	        <table width='100%'>
	            <tr><td>
	            	<h1>My Offices</h1>
	            </td></tr>
	            <tr><td>
					<g:if test='${officeInstanceList && officeInstanceList.size() > 0}'>	
					                 
<%--////////////////////////////////////////// --%>
		                <table width='90%'>
		                        <tr>
		                            <td style='padding:0 10px'>
		                    <g:each in="${officeInstanceList}" status="i" var="officeInstance">
		                    	<div id='${officeInstance.id}'>
		                        <div class="hr office"></div>
		                            <p id='summary' style='font-size:12px;padding:5 0px;'>
		                            <div>
		                            	 <span class='off-num-text'>Office Number ${i+1+offset}</span>
										 <a href="javascript:void(0)" onclick="openDelAcctInfoDialog(${officeInstance.id}, 'div#${officeInstance.id}', '/accountSetup/deleteOffice' );" class='officeLink' style='float:right'>Remove</a>		                            	 
		                            </div>
		                            <div>
		                            	<b>${officeInstance.name}</b>
		                            	<a href="javascript:void(0)" onclick="myAcctDialog(${officeInstance.id}, 'editOffice' ); return false" class='officeLink' style='float:right'>Edit</a>
		                            </div>
		                            ${officeInstance.addressLine1}<br/>
									${officeInstance.city}, ${officeInstance.state} ${officeInstance.zipcode}<br/>
									<%--${officeInstance.phone}--%>
									</p>
								</div>
		                    </g:each>
		                        <div class="hr office"></div><br/>
		                        <input type="submit" onclick="myAcctDialog(); return false" class="acct-add-office-button my-acct" value=""/>
		                            </td>
		                        </tr>
		                </table>
						<div class='paginateButtons'>
						    <g:paginate total="${officeInstanceList.totalCount}"></g:paginate>
						</div>
		                
		        

<%--////////////////////////////////////////// --%>

	            	</g:if>
	            </td></tr>
			</table>
			</div>
	  	</div>
	  </div>
	  <div class="item" id="item5"></div>
	</div>
	
</div>
</div>
<g:include view="common/footer.gsp" params="[controller:params.controller]"/>
<div id="dialog-my-acct" title="" style="font-size: 13; display: none; text-align:left;z-index:100000; overflow:hidden; width:390px">
            <div id="errorList" class="errors" style="display: none;font-size:14px"></div>	
				<table width="100%" class='acct-content'>
					<tr>
						<td>
						<h1><span id="action">Add an Office</span><span id="editOffice" class='hide'>Edit This Office</span></h1>
						</td>
					</tr>
					<tr><td>	  		
	  		     		<g:include view="accountSetup/office-new.gsp"/>
	  		     		</td>
					</tr>
					<tr>
						<td style='vertical-align:bottom; padding: 10px 10px 0 0'>	  		
							<input class="tracker-icon tracker-cancel-gray-btn" type="submit" onclick="gMyAcctDiag.dialog('close');return false;" value="" name="update" style="float:right;margin-left:10px"/>
							<input class="acct-add-button my-acct" type="submit" onclick="saveAccountRelationship('/accountSetup/saveOffice', '/accountSetup/offices', '#acctInfoForm', '#errorList'); return false;" value="" name="add-btn" style="float:right"/>
							<input class="acct-update-button" type="submit" onclick="saveAccountRelationship('/accountSetup/updateOffice', '${request.getRequestURL()}', '#acctInfoForm', '#errorList'); return false;" value="" name="update-btn" style="float:right"/>
	  		     		</td>
					</tr>
				</table>	
</div>
 <div id="dialog-small" class='transition-bg' title="" style="font-size: 16; line-height:1.3; display: none; text-align:left;z-index:100000"></div>   
</body>
</html>
