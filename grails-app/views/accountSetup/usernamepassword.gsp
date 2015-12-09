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
	  	<a href='/accountSetup/subscriptionHistory' class='acct-link-default'>Billing History</a><br/>
	  	<a href='/accountSetup/usernamepassword' class='acct-link-active'>Username & Password</a><br/>
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
        <table width="100%" class='acct-content'>
            <tr>
            <td width="55%">
            	<h1>Change My Username</h1>
            	<div style="padding: 10px 0 0 20px;">
            	<form method="post" action='/accountSetup/usernamepassword'>
				    <label>What is your user name?</label> <br/> <input type="text" name="username" value='${username}' readonly='readonly' size="35"/><br/><br/>
				    <label>What is your new user name?</label><br/> <input type="text" name="newUsername" size="35"/><br/><br/>
				    <label>Please verify new user name.</label><br/> <input type="text" name="confirmNewUsername" size="35"/><br/><br/>
				    <g:submitButton name="button" value="" class="acct-change-button"/>
				</form>
				</div>           
            </td>
            <td width="45%">
        		<%-- div class='acct-secure-logo'></div--%>
            </td>            
            </tr>
            <tr>
            <td width="100%">
            	<h1>Change My Password</h1>
				 



            	<div style="padding: 10px 0 0 20px;">
            	<form method="post" action='/accountSetup/usernamepassword'>
					<g:if test="${params.frag}"><input type="hidden" name="frag" value="1"/></g:if>
				    <label>What is your password?</label> <br/> <input type="password" name="password" size="35"/><br/><br/>
				    <label>What is your new password?</label><br/> <input type="password" name="newPassword" size="35"/><br/><br/>
				    <label>Please verify new password.</label><br/> <input type="password" name="confirmNewPassword" size="35"/><br/><br/>
				    <g:submitButton name="change" value="" class="acct-change-button"/>
				</form>
				</div>           
            </td>
            </tr>
        </table>	  	
	  	
			<p style="padding: 45px 18px;">
			
		  	<div id="success"></div>
			<div id="error"></div>
			</p>
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
