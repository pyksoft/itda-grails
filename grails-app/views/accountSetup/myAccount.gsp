<%@ page import="com.itda.Portfolio"%>
<html>
<head>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="stylesheet" href="/css/sap-fivecol.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>        
<title>My Account</title>
</head>
<body style='border-width:0px'>
<g:include view="common/header.gsp" params="[controller:params.controller]"/>
<div class="body" style="padding-top: 60px;">
       	  <img style="padding:0px;" src="/images/Transparent.gif" class="center"/>
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
	  	<a href='/accountSetup/contactInfo' class='acct-link-active'>Contact Information</a><br/>
	  	<a href='/accountSetup/subscriptionHistory' class='acct-link-default'>Billing History</a><br/>
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
			<img src='/images/itd/myAccount/itda_account_home.jpg' style="padding-top:44px"/>
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
