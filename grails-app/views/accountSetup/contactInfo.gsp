<%@ page import="com.itda.Portfolio"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><head>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="stylesheet" href="/css/sap-fivecol.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
<link type="text/css" href="/jquery/css/smoothness/jquery-ui-1.8.7.custom.css" 	rel="stylesheet" />
<script type="text/javascript" src="/jquery/js/jquery-1.4.4.min.js"></script >
<script type="text/javascript" 	src="/jquery/js/jquery-ui-1.8.7.custom.min.js"></script>
	<script type='text/javascript' src='/js/myAccount/myAcct.js'></script>        
	<script type='text/javascript' src='/js/common.js'></script>        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>        
<title>My Account</title>
</head>
<body style='border:none'>
<div id='doc'>
	<div>
	<g:include view="common/header.gsp" params="[controller:params.controller]"/>
	</div>
	<div style="clear:both;height:5px"></div>
	<div style="width:1024px">
		<div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${businessInstance}">
            <div class="errors">
                <g:renderErrors bean="${businessInstance}" as="list" />
            </div>
            </g:hasErrors>
		            
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
			 	
				        <table class='acct-content static'>
				            <tr><td>
				            	<h1>My Contact Information</h1>
				            </td></tr>
			                            <tr>
			                                <td valign="top" class="name">
			                                	<hr/>
			                                    <b>Name:</b> ${fieldValue(bean:businessInstance,field:'representativeName')}
			                                </td>
			                            </tr> 
			                            <tr>
			                                <td valign="top" class="name">
			                                    <b>Business Name:</b> ${fieldValue(bean:businessInstance,field:'businessName')}
			                                </td>
			                            </tr> 
			                            <tr>
			                                <td valign="top" class="name">
			                                    <b>Your Email Address:</b> ${fieldValue(bean:businessInstance,field:'email')}
			                                </td>
			                            </tr> 
			                            <tr>
			                                <td valign="top" class="name">
			                                    <b>Phone Number: </b> ${fieldValue(bean:businessInstance,field:'phone')}
			                                </td>
			                            </tr> 
					                            <tr>
									                <td valign="top" class="name">
									                        <hr/>
									                		<div>
										                       <g:submitButton name="update" value="" class="acct-change-button"  onclick="myAcctDialog(null); return false"/>
										                     </div>
										             </td>
					                            </tr> 
			                    </table>                  
				  	</div>
				  </div>
				  <div class="item" id="item5">
				  	<div class="sap-content"></div>
				  </div>
				</div>
				
			</div><%--canvas--%>
		</div><%--body--%>
	 </div>
</div><%--doc--%>
<g:include view="common/footer.gsp" params="[controller:params.controller]"/>

	  <div id="dialog-my-acct" title="" style="font-size: 13; display: none; text-align:left;z-index:100000; overflow:hidden; min-height:550px; width:350px">
            <div id="errorList" class="errors" style="display: none;"></div>	
		<form method='post' id='acctInfoForm' action='#'>            		
		 <table width="100%" class='acct-content'>
	            <tr><td >
	            	<h2>My Contact Information</h2>
	            </td></tr>
                            <tr>
                                <td valign="top" class="name">
                                    <label>* Indicates require filed<br/><br/></label>
                                </td>
                            </tr> 				        
 	                        <tr>
                                <td valign="top" class="name">
                                    <label>Name:</label>
                                </td>
                            </tr> 
                            <tr>
                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'representativeName','errors')}">
                                    <input type="text" maxlength="128" id="representativeName" name="representativeName" value="${fieldValue(bean:businessInstance,field:'representativeName')}"/>
                                </td>
                            </tr> 
                            <tr>
                                <td valign="top" class="name">
                                    <label for="name">* Your Business Name:</label>
                                </td>
                            </tr> 
                            <tr>
                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'businessName','errors')}">
                                    <input type="text" maxlength="128" id="name" name="businessName" value="${fieldValue(bean:businessInstance,field:'businessName')}"/>
                                </td>
                            </tr> 
                        
                        
                            <tr>
                                <td valign="top" class="name">
                                    <label for="email">* Your Email Address:</label>
                                </td>
                            </tr> 
                            <tr>
                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'email','errors')}">
                                    <input type="text"  name="email" value="${fieldValue(bean:businessInstance,field:'email')}"/>
                                </td>
                            </tr> 
                            <tr>
                                <td valign="top" class="name">
                                    <label for="email">* Reenter Your Email Address:</label>
                                </td>
                            </tr> 
                            <tr>
                                <td valign="top" class="value">
                                    <input type="text" id="confirmEmail" name="confirmEmail" value="${confirmEmail}"/>
                                </td>
                            </tr> 
                        
                            <tr>
                                <td valign="top" class="name">
                                    <label for="phone">* Your Phone Number: xxx-xxx-xxxx</label>
                                </td>
                            </tr> 
                            <tr>
                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'phone','errors')}">
                                    <input type="text" maxlength="13" id="phone" name="phone" value="${fieldValue(bean:businessInstance,field:'phone')}"/>
                                </td>
                            </tr>                         
		                            <tr>
						                <td valign="top" >
						                		<div>
							                       <g:submitButton name="update" value="" class="acct-update-button" onclick="saveAccountInfo('/accountSetup/contactInfo', '#acctInfoForm', '#errorList'); this.blur();return false;"/>
							                       <g:submitButton name="update" value="" class="tracker-icon tracker-cancel-gray-btn" onclick="gMyAcctDiag.dialog('close');return false;"/>
							                       
							                     </div>
							             </td>
		                     </tr> 
                    </table>
                  </form> 	
	  </div> 	  	     
</body>
</html>
