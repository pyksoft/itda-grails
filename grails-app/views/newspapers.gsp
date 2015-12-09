<%@ page import="com.itda.Portfolio"%>
<html>
<head>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="stylesheet" href="/css/sap-fivecol.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
  <g:javascript library="prototype"/>        
<title>My Account</title>
</head>
<body>
<g:include view="common/header.gsp" params="[controller:params.controller]"/>
<div class="body" style="padding-top: 60px;">
       	  <img style="padding:0px;" src="/images/Transparent.gif" class="center"/>
       <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
      </g:if>
      <g:hasErrors bean="${publicationInstance}">
         <div class="errors">
      		<g:renderErrors bean="${publicationInstance}" as="list" />
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
	  	<a href='/accountSetup/contactInfo' class='acct-link-default'>Contact Information</a><br/>
	  	<a href='/accountSetup/subscriptionHistory' class='acct-link-default'>Billing History</a><br/>
	  	<a href='/accountSetup/usernamepassword' class='acct-link-default'>Username & Password</a><br/>
	  	<a href='/accountSetup/paymentInfo' class='acct-link-default'>Payment Information</a><br/>
	  	<a href='/accountSetup/offices' class='acct-link-default'>Offices</a><br/>
	  	<a href='/accountSetup/territory' class='acct-link-default'>Zip Codes</a><br/>
	  	<a href='/accountSetup/newspapers' class='acct-link-active'>Newspapers</a><br/>
	  	<a href='/accountSetup/vendors' class='acct-link-default'>Vendors</a><br/>
	  	<a href='/accountSetup/manufacturers' class='acct-link-default'>Manufacturers</a><br/>
	  	<a href='/accountSetup/competition' class='acct-link-default'>Competition</a><br/>
	  	</p>
	  	</div>
	  </div>
	  <div class="item" id="item3">

	  	<div class="sap-content"></div>
	  </div>
	  <div class="item" id="item4">
	  	<div class="sap-content">
	  		<g:if test='${(edit == "true" || add == "true")&& publicationInstance}'><%--eho --%>
				<table width="100%" class='acct-content'>
					<tr>
						<td>
						<h2>${add == "true" ? 'Add' : 'Edit'} Newspapers Entry</h2>
						</td>
					</tr>
					<tr><td width='50%'>	  		
	  		     		<g:include view="accountSetup/publication.gsp"/>
	  		     		</td>
						<td style='vertical-align:bottom;padding-bottom:25px'>	  		
	  		     		<g:if test='${edit}'>
		  		     		<g:submitButton name="updatePublication" value="" class="acct-update-button" onclick='document.forms[0].submit();' />
	  		     		</g:if>
	  		     		<g:elseif test='${add}'>
							<g:submitButton name="addpub" value="" class="add_publication" onclick='document.forms[0].submit();'/>
	  		     		</g:elseif>
	  		     		</td>
					</tr>									
				</table>
	  		</g:if>
	  		<g:else>
		        <table width="100%" class='acct-content'>
		            <tr><td >
		            	<h2>My Newspapers</h2>
						<g:include view="accountSetup/listPublicationTabFrag.gsp"/>	  
						<form method='post' action='/accountSetup/newspapers'>
							<input type='hidden' name='token' value='newspapers'/>
							<input type='hidden' name='add' value='true'/><%-- adding from list --%>
							<g:submitButton name="addPublication" value="" class="add_publication" /><br/>
						</form>
						<div class='paginateButtons'>
							<g:paginate controller="accountSetup" action="newspapers" total="${publicationInstanceList.totalCount}"></g:paginate>
						</div>  
		            </td></tr>
				</table>
			</g:else>
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
