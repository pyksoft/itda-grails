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

	<%-- map v3  --%>
   <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
	<script type="text/javascript"><!--
	  var map;
	  function initialize() {
		//geocoder = new google.maps.Geocoder();
	    var latlng = new google.maps.LatLng(37.71859032558813,-95.44921875);
	    var myOptions = {
	      zoom: 4,
	      center: latlng,
	      draggable: true,
		  navigationControl: true,
		  mapTypeControl: false,
		  scaleControl: true,	      
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	    }
	    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
        var bounds, center;

   		var currPt,lat, lng, marker;
   		<% boolean first = true %>
	    <g:if test="${officeInstanceList}">
			<g:each in="${officeInstanceList}" status="i" var="officeInstance">
			  <g:if test='${officeInstance.availability == "true"}'>
			    lat = ${fieldValue(bean:officeInstance, field:'lat')};
			    lng = ${fieldValue(bean:officeInstance, field:'lon')};
   				center =  new google.maps.LatLng(lat, lng);
   				<g:if test='${first==true}'> <% first = false %>
    				   bounds = new google.maps.LatLngBounds( center, new google.maps.LatLng(lat + 0.05, lng + 0.05));
    			</g:if>
    			<g:else>
    				bounds.extend(center); 
    			</g:else>
	          	marker = new google.maps.Marker({map: map, position: center, title:"${officeInstance.name.encodeAsHTML()}"});
              </g:if>
			</g:each>
				map.fitBounds(bounds);
				map.setCenter(bounds.getCenter());
		</g:if>
	  }
    --></script>
                     
<title>My Account</title>
</head>
<body onload="initialize();" style='border:none'> 
<g:include view="common/header.gsp" params="[controller:params.controller]"/>
<div style="clear:both;height:5px"></div>
<div class="body myAcct">
            <g:if test="${flash.message}">
            <br/><div class="message">${flash.message}</div>
            </g:if>
<div id="canvas" width="992px">

	<div class="line" id="line1">	  	
	  <div class="item" id="item1">
	    <div class="sap-content"></div>
	  </div>
	  <div class="item" id="item2">
	  	<div class="sap-content"><p>
	  	<strong>My Account</strong><br/><br/>
	  	<a href='/accountSetup/contactInfo' class='acct-link-default'>Contact Information</a><br/>
	  	<a href='/accountSetup/subscriptionHistory' class='acct-link-default'>Billing History</a><br/>
	  	<a href='/accountSetup/usernamepassword' class='acct-link-default'>Username & Password</a><br/>
	  	<a href='/accountSetup/paymentInfo' class='acct-link-default'>Payment Information</a><br/>
	  	<a href='/accountSetup/offices' class='acct-link-default'>Offices</a><br/>
	  	<a href='/accountSetup/territory' class='acct-link-active'>Zip Codes</a><br/>
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
	        <table width="100%" class='content'>
	            <tr><td >
	            	<h1>My Zip Codes</h1>
	            </td></tr>
	            <tr><td >
	                 <div id="map_canvas" style="border:1px solid #aaaaaa;width: 100%; height: 225px"></div>
	            </td></tr>
	            <tr><td >
	            	<div style='padding:2px;overflow-y:scroll;height:225px'>
					                    <g:each in="${officeInstanceList}" status="i" var="officeInstance">
					                     <table class='table'>
					                      <g:if test='${officeInstance.availability == "true"}'>
					                      	<tr><td colspan='3' class='hr'></td></tr>
					                      	<tr>
					                      		<td style='width:20%'><div class='blue'>Office number ${i+1}</div><b>${officeInstance.name}</b></td>
					                      		<td id='${officeInstance.id}'>
					                    		<g:each in="${officeInstance.advertisingZipcodes}" status="j" var="zipcode">${j != 0 ? ', ' : ''}${zipcode.zipcode}</g:each>
					                    		</td>
					                    		<td style='width:20%'><a onclick='myZipCodesDialog(${officeInstance.id}, ${i+1}, "add")' href='#'>Add Zip Codes</a><br/><a onclick='myZipCodesDialog(${officeInstance.id}, ${i+1}, "delete")' href='#'>Delete Zip Codes</a></td>
					                        </tr>
					                        </g:if>
					                     </table>   
					                    </g:each>
	            	</div>
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
	  <div id="dialog-my-acct" title="" style="font-size: 13; display: none; text-align:left;z-index:100000; overflow:hidden; width:390px">
	  </div>
	  <div style='display:none' id='addZipCodesContent'>
            <form action='#' id='addZipCodeForm'>
                <div id="errorList" class="errors" style="display: none;"></div>	
				<table width="100%" class='acct-content'>
					<tr>
						<td colspan='2'>
						<h1><span id="action">Add Zip Codes</span></h1><br/><br/>
						</td>
					</tr>
                            <tr>
                                <td class="value" style='padding-left:12px;width:190px'>
                                    Enter New<br/>Zip Codes<br/>
                                    <input type="text" maxlength="5" class='text'/>
                                    <input type="text" maxlength="5" class='text'/>
                                    <input type="text" maxlength="5" class='text'/>
                                    <input type="text" maxlength="5" class='text'/>
                                    <input type="text" maxlength="5" class='text'/>
                                    <input type="text" maxlength="5" class='text'/>
                                    <input type="text" maxlength="5" class='text'/>
                                    <input type="text" maxlength="5" class='text'/>
                                    <input style="margin:20px 0 0 70px; height:18px; width:64px" value="" type='submit' onclick="addZipCodes();done(this);return false;" class="acct-add-button my-acct"/>
                                </td>
                                <td class="value">
                                    Office Number <span class='officeNum'></span><br/>Zip Codes<br/>
                            		<select multiple="multiple" size="20"></select>
                            		<input type="hidden" name='id'/>
									<input class="tracker-icon save-btn" onclick="saveNewZipCodes();this.blur();return false;" type='submit' style="margin:14px 0 7px 85px;height:19px;width:64px" value=""/>
									<input class="tracker-icon tracker-cancel-gray-btn" onclick="gMyAcctDiag.dialog('close');return false;" type='submit' style="float:right;height:19px;width:64px;margin-bottom:0" value=""/>
                                </td>
                            </tr>
				</table>
			</form>
		</div>
	  <div id='delZipCodesContent'  style='display:none'>		
            <form action='#' id='delZipCodeForm'>
            	<div id="errorList" class="errors" style="display: none;"></div>
				<table width="100%" class='acct-content'>
					<tr>
						<td colspan='2'>
						<h1><span id="action">Delete Zip Codes</span></h1><br/><br/>
						</td>
					</tr>
                            <tr>
                                <td class="value" style='padding-left:12px;width:190px'>
                                    Zip Codes<br/>To Delete<br/>
                            		<select multiple="multiple" size="20" name='deleteZipCodes'></select>
                                </td>
                                <td class="value">
                                    Office Number <span class='officeNum'></span><br/>Zip Codes<br/>
                            		<select multiple="multiple" size="20" name='zipCodes'></select>
                                    <input style="margin:10px 0 0 36px; height:18px; width:64px" value="" type='submit' onclick="selectZipCodes4Del();done(this);return false;" class="acct-del-button my-acct"/>
                            		<input type="hidden" name='id'/>
									<input class="tracker-icon save-btn" onclick="saveDeleteZipCodes();this.blur();return false;" type='submit' style="margin:25px 0 7px 85px;height:19px;width:64px" value=""/>
									<input class="tracker-icon tracker-cancel-gray-btn" onclick="gMyAcctDiag.dialog('close');return false;" type='submit' style="float:right;height:19px;width:64px;margin-bottom:0" value=""/>
                                </td>
                            </tr>
				</table>
			</form>	  
			
	  </div>
</body>
</html>
