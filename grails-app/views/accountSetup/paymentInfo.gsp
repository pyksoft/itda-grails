<%@ page import="com.itda.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
    <head>
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
<body style='border:none'>
<g:include view="common/header.gsp" params="[controller:params.controller]"/>
<div style="clear:both;height:5px"></div>
<div class="body" >
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
	  	<a href='/accountSetup/usernamepassword' class='acct-link-default'>Username & Password</a><br/>
	  	<a href='/accountSetup/paymentInfo' class='acct-link-active'>Payment Information</a><br/>
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
	  	<div class="sap-content" style="text-align:left">
	        <table class='acct-content static'>
	            <tr><td>
	            	<h1>My Payment Information</h1>
	            </td></tr>     
		                            <tr>
		                                <td valign="top" class="name">
		                                <hr/>
		                                    <b>Type: </b>${paymentInstance.cardType}
		                                </td>
		                            </tr> 
		                            <tr>
		                                <td  valign="top" class="name">
		                                    <b>Number: </b>${paymentInstance.cardNumber}
		                                </td>
		                            </tr> 
		                            <tr>
		                                <td valign="top" class="name">
		                                    <b>Exp. Date: </b>${paymentInstance.expireMonth}/${paymentInstance.expireYear}
		                            </td></tr> 
		                            <tr>
		                                <td valign="top" class="name">
		                                    <b>Security Code: </b>${paymentInstance.cardSecurityCode}
		                            </td></tr> 		                            
		                            <tr>
		                                <td valign="top" class="name">
		                                    <b>Cardholder's Name: </b> ${paymentInstance.firstName} ${paymentInstance.lastName}
		                                </td>
		                            </tr> 
		                            <%-- 
		                            <tr>
		                                <td valign="top" class="name">
		                                    <b>Billing Address:</b><br/>
		                                    <div class='address'>${paymentInstance.firstName} ${paymentInstance.lastName}</div>
		                                    <div class='address'>${paymentInstance.billingAddress}</div>
		                                    <div class='address'>${paymentInstance.city}, ${paymentInstance.state} ${paymentInstance.zipcode}</div>
		                                </td>
		                            </tr>
		                             --%> 
		                            <tr>
						                <td valign="top" class="name">
		                                    <hr/>
						                		<div>
							                       <g:submitButton name="update" value="" class="acct-change-button" onclick="myAcctDialog(null, undefined); return false"/>
							                     </div>
							             </td>
		                            </tr> 
                        		 </table>
<%-- --%>	
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

	  <div id="dialog-my-acct" title="" style="font-size: 13; display: none; text-align:left;z-index:100000; overflow:hidden; width:350px">
            <div id="errorList" class="errors" style="display: none;"></div>	
		<form method='post' id='payInfoForm' action='#'>            		
  	
	        <table width="100%" class='acct-content'>
	            <tr><td width="55%">
	            	<h2>My Payment Information</h2>
	            </td></tr>
		                            <tr>
		                                <td valign="top" class="value">
		                                    <label>* First Name:</label><br/>
		                                    <input type="text" maxlength="50" size="35" name="firstName" value="${fieldValue(bean:paymentInstance,field:'firstName')}"/>
		                                </td>
		                            </tr> 
		                            <tr>
		                                <td valign="top" class="value">
		                                    <label>* Last Name:</label><br/>
		                                    <input type="text" maxlength="50" size="35" name="lastName" value="${fieldValue(bean:paymentInstance,field:'lastName')}"/>
		                                </td>
		                            </tr> 		
						            <tr>
						                <td  valign="top" class="name">
						                     <label>* The credit card we may bill each month</label><br/>
						                     <g:checkBox name="cardType" value="VISA" checked="${paymentInstance?.cardType =='VISA'}"/>
						                     <input class="acct-visa" type="submit" onclick="return false"  value="" style='margin-top:5px'>
						                     <g:checkBox name="cardType" value="MasterCard" checked="${paymentInstance?.cardType =='MasterCard'}"/>
						                     <input class="acct-master" type="submit" onclick="return false" value="" name="master">
						                     <g:checkBox name="cardType" value="Discover" checked="${paymentInstance?.cardType =='Discover'}"/>
						                     <input class="acct-discover" type="submit" onclick="return false" value="" name="discover">
						                     <%-- img src="/images/itd/reg/cards.jpg" /--%>
						                </td>
						            </tr>     
		                        
		                            <tr>
		                                <td  valign="top" class="value ${hasErrors(bean:paymentInstance,field:'cardNumber','errors')}">
		                                    <label for="cardNumber">* Your Card Number:</label><br/>
		                                    <%--value="${fieldValue(bean:paymentInstance,field:'cardNumber')}" --%>
		                                    <%
		                                      def cardNum = paymentInstance?.cardNumber;
		                                      if (cardNum == null || cardNum == "") {
		                                          def testCard = message(code:"authorize.net.test.card");
		                                          if(testCard != null)
		                      		              	cardNum  = testCard;
		                                      }
		                                    %>		                                    
		                                    <input value="${cardNum}" type="text" id="cardNumber" maxlength="16" size="35" name="cardNumber"/>
		                                </td>
		                            </tr> 
		                        
		                            <tr>
		                                <td valign="top" class="value ${hasErrors(bean:paymentInstance,field:'expireMonth','errors')} ${hasErrors(bean:paymentInstance,field:'expireYear','errors')}">
		                                    <label for="expireMonth">* The Expiration Date: Month: Year:</label><br/>
		                                    <g:select id="expireMonth" name="expireMonth" from="${(new Payment()).constraints.expireMonth.inList}" value="${fieldValue(bean:paymentInstance,field:'expireMonth')}" ></g:select>
		                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                                    <g:select id="expireYear" name="expireYear" from="${(new Payment()).constraints.expireYear.inList}" value="${fieldValue(bean:paymentInstance,field:'expireYear')}" ></g:select>
		                            </td></tr> 
		                        
		                            <tr>
		                                <td valign="top" class="value">
		                                    <label for="cardSecurityCode">* Your Card Security Code: </label><span class="red_link_button" onclick="whatisthis();">What is this?</span>
<div id="dialog" title="Your Card Security Code" style="font-size: 13; display: none; text-align:left;">
<p><strong>What is the Security Code?</strong><br/>
The security code is an additional code on your credit card that helps validate the card's owner.<br/><br/>

<strong>Where can I find the security code if I have a Visa, MasterCard or Discover Card?</strong><br/>
You will find the 3 digit security code on the back of your credit card in the signature box. Use the last three numbers. </p>
</div>

		                                    <br/>
		                                    <%
		                                      def code = paymentInstance?.cardSecurityCode;
		                                      if (code != null && code.startsWith("*")){
		                                    	  code = "";
		                                      }
		                                    %>			                                    
		                                    <input type="text" maxlength="4" size="35" id="cardSecurityCode" name="cardSecurityCode" value="${code}"/>
		                                </td>
		                            </tr> 
		                        
		                            <tr>
		                                <td valign="top" class="value">
		                                    <label for="billingAddress">* Your Billing Address:</label><br/>
		                                    <input type="text" maxlength="60" size="35" id="billingAddress" name="billingAddress" value="${fieldValue(bean:paymentInstance,field:'billingAddress')}"/>
		                                </td>
		                            </tr> 
		                        
		                            <tr>
		                                <td valign="top" class="value">
		                                    <label for="city">* Your City:</label><br/>
		                                    <input type="text" maxlength="40" size="35" id="city" name="city" value="${fieldValue(bean:paymentInstance,field:'city')}"/>
		                                </td>
		                            </tr> 
		                        
		                            <tr><td>
		                               <table width="100%">
		                                 <tr>
		                                <td  style='padding:0px' valign="top" class="value">
		                                    <label for="state">* Your State:</label><br/>
		                                    <g:select id="state" name="state" from="${(new Payment()).constraints.state.inList}" value="${fieldValue(bean:paymentInstance,field:'state')}" ></g:select>
		                                </td>
		                                <td  valign="top" class="value" style='padding:0px'>
		                                    <label for="zipcode">* Your Zipcode:</label>&nbsp;&nbsp;xxxxx<br/>
		                                    <input type="text" maxlength="5" size="23" id="zipcode" name="zipcode" value="${fieldValue(bean:paymentInstance,field:'zipcode')}"/>
		                                </td>
		                                </table>
		                            </td></tr> 
		                        
		                            <tr>
						                <td valign="top" >
						                		<div>
							                       <g:submitButton name="update" value="" class="acct-update-button" onclick="saveAccountInfo('/accountSetup/paymentInfo', '#payInfoForm', '#errorList');this.blur(); return false;"/>
							                       <g:submitButton name="cancel" value="" class="tracker-icon tracker-cancel-gray-btn" onclick="gMyAcctDiag.dialog('close');return false;"/>
							                       
							                     </div>
							             </td>
		                     </tr> 
                    </table>
                  </form> 	
	  </div> 
</body>
</html>
