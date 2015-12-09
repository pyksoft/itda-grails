<%@ page import="com.itda.*"%>
<html>
<head>
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet" href="/css/itda.css" />
<link rel="stylesheet" href="/css/sap-fivecol.css" />
<link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>My Account</title>
</head>
<body>
<g:include view="common/header.gsp" params="[controller:params.controller]"/>
<div class="body" style="padding-top: 60px;"><img style="padding: 0px;" src="/images/Transparent.gif" class="center" />
       <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${officeInstance}">
         <div class="errors">
      		<g:renderErrors bean="${officeInstance}" as="list" />
         </div>
      </g:hasErrors>
<div id="canvas" width="992px">

<div class="line" id="line1">
	<div class="item" id="item1">
		<div class="sap-content"></div>
	</div>
	
	<div class="item" id="item2">
		<div class="sap-content">
			<p style="padding: 45px 18px;"><strong>My Account</strong><br />
				<br />
				<br />
	  	<a href='/accountSetup/contactInfo' class='acct-link-default'>Contact Information</a><br/>
	  	<a href='/accountSetup/subscriptionHistory' class='acct-link-default'>Billing History</a><br/>
	  	<a href='/accountSetup/usernamepassword' class='acct-link-default'>Username & Password</a><br/>
	  	<a href='/accountSetup/paymentInfo' class='acct-link-default'>Payment Information</a><br/>
	  	<a href='/accountSetup/offices' class='acct-link-active'>Offices</a><br/>
	  	<a href='/accountSetup/territory' class='acct-link-default'>Zip Codes</a><br/>
	  	<a href='/accountSetup/newspapers' class='acct-link-default'>Newspapers</a><br/>
	  	<a href='/accountSetup/vendors' class='acct-link-default'>Vendors</a><br/>
	  	<a href='/accountSetup/competition' class='acct-link-default'>Competition</a><br/>
	  	<a href='/accountSetup/competition' class='acct-link-default'>Competition</a><br/>
			</p>
		</div>
	</div>
	
	<div class="item" id="item3"><div class="sap-content"></div></div>

	<div class="item" id="item4">
		<div class="sap-content">
			<div class='acct-content'>
				<table width="100%">
					<tr>
						<td>
						<h2>Add Office</h2>
						</td>
					</tr>
						<tr><td>	
							<g:form action="addOffice" method="post">
							<input type="hidden" value='true' name='create'/>
							<table>
								<tbody>
									<tr>
										<td width="33%" style="padding: 0px;">
										<table>
											<tr class="prop">
												<td colspan="2" valign="top" class="value"><label>(*)
												indicates required field</label></td>
											</tr>
				
											<tr class="prop">
												<td colspan="2 valign="
													top" class="value ${hasErrors(bean:officeInstance,field:'name','errors')}">
												<br />
												<br />
												<label for="name">* Office Location Name:</label><br />
												<input type="text" maxlength="128" size="40" id="name"
													name="name"
													value="${fieldValue(bean:officeInstance,field:'name')}" /></td>
											</tr>
				
											<tr class="prop">
												<td colspan="2 valign="
													top" class="value ${hasErrors(bean:officeInstance,field:'addressLine1','errors')}">
												<label for="addressLine1">* Office Address:</label><br />
												<input type="text" maxlength="128" size="40" id="addressLine1"
													name="addressLine1"
													value="${fieldValue(bean:officeInstance,field:'addressLine1')}" />
												</td>
											</tr>
				
											<tr class="prop">
												<td colspan="2 valign="
													top" class="value ${hasErrors(bean:officeInstance,field:'city','errors')}">
												<label for="city">* Office City:</label><br />
												<input type="text" maxlength="64" size="40" id="city"
													name="city"
													value="${fieldValue(bean:officeInstance,field:'city')}" /></td>
											</tr>
				
											<tr class="prop">
												<td valign="top"
													class="value ${hasErrors(bean:officeInstance,field:'state','errors')}">
												<label for="state">* State:</label><br />
												<g:select id="state" name="state"
													from="${(new Office()).constraints.state.inList}"
													value="${fieldValue(bean:officeInstance,field:'state')}"></g:select>
												</td>
												<td valign="top" style="text-align: left;"
													class="value ${hasErrors(bean:officeInstance,field:'zipcode','errors')}">
												<label for="zipcode">* ZIP Code </label><span
													style="font-weight: bold">xxxxx</span><br />
												<input type="text" id="zipcode" maxlength="5" size="30"
													name="zipcode"
													value="${fieldValue(bean:officeInstance,field:'zipcode')}" /></td>
											</tr>
				
											<tr class="prop">
												<td colspan="2" valign="top">
												<div><g:submitButton name="addOffice" value=""
													class="my-acct acct-add-office-button" style='border:0px'/></div>
												</td>
				
											</tr>
										</table>
										</td>
				
									</tr>
								</tbody>
							</table>
							</g:form>
						</td>
					</tr>
				
				</table>
			</div>
		</div>
	</div>

	<div class="item" id="item5"><div class="sap-content"></div></div>
 </div>
</div>
</div>
<g:include view="common/footer.gsp" params="[controller:params.controller]"/>
</body>
</html>

