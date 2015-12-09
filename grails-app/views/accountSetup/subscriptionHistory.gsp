<%@ page import="com.itda.Portfolio"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="stylesheet" href="/css/sap-fivecol.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
  <g:javascript library="prototype"/>        
<title>My Account</title>
</head>
<body style='border:none'>
<g:include view="common/header.gsp" params="[controller:params.controller]"/>
<div style="clear:both;height:5px"></div>
<div class="body">
            <g:if test="${flash.message}">
            <br/><div class="message">${flash.message}</div>
            </g:if>
			<g:elseif test="${flash.passwordShort || flash.passwordsMismatch}">
	        <br/>
	            <div class="errors" style="padding-top: 10px">
					${flash.passwordShort}
					${flash.passwordsMismatch}
	            </div>            
            </g:elseif>            
			<g:elseif test="${flash.generalError}">
	        <br/>
	            <div class="errors" style="padding-top: 10px">
					${flash.generalError}
	            </div>            
            </g:elseif>            
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
	  	<a href='/accountSetup/subscriptionHistory' class='acct-link-active'>Billing History</a><br/>
	  	<a href='/accountSetup/usernamepassword' class='acct-link-default'>Username & Password</a><br/>
	  	<a href='/accountSetup/paymentInfo' class='acct-link-default'>Payment Information</a><br/>
	  	<a href='/accountSetup/offices' class='acct-link-default'>Offices</a><br/>
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
	        <table width="100%" >
	            <tr><td >
	            	<h1>My Billing History</h1>
	            </td></tr>
	            <tr><td>
					<g:if test='${paymentInstanceList && paymentInstanceList.size() > 0}'>	
<%--////////////////////////////////////////// --%>
		                <table width='100%' style="padding-left:10px">
		                	<tr>
		                		<th class='border-none' width='20%'>Date</th>
		                		<th class='border-none' width='65%'>Description</th>
		                		<th class='border-none' width='15%'>Total</th>
		                	</tr>
		                    <g:each in="${paymentInstanceList}" status="i" var="paymentInstance">
		                        <tr>
		                            <td class='border-none'>
		                              ${paymentInstance.dateCreated.format('MM/dd/yyyy')}
		                            </td>
		                            <td class='border-none'>
		                              ${paymentInstance.description}
		                            </td>
		                            <td class='border-none'>
		                               $${com.itda.Payment.priceAsString(paymentInstance.amount)}
		                            </td>
		                        </tr>
		                    </g:each>
		                </table>
						<div class='paginateButtons'>
						    <g:paginate total="${paymentInstanceList.totalCount}"></g:paginate>
						</div>
<%--////////////////////////////////////////// --%>
	            	</g:if>
	            </td></tr>
	            </table>
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
</body>
</html>
