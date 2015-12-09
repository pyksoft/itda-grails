<%@ page import="com.itda.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>In the Door Advertising</title>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="stylesheet" href="/css/sap-twocol.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>  
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

<%--        
		var d2r = Math.PI / 180;   // degrees to radians
		var r2d = 180 / Math.PI;   // radians to degrees
		var earthsradius = 3963; // 3963 is the radius of the earth in miles
   		var points = 32;
   		var radius = <%= message(code:"inthedoor.office.radius")%>;             // radius in miles
   		// find the raidus in lat/lon
   		var rlat = (radius / earthsradius) * r2d;
   		var currPt,lat, lng, rlng, extp, theta, polyOPtions, poly, marker;
 --%>
   		var currPt,lat, lng, marker;
   		<% boolean first = true %>
	    <g:if test="${officeInstanceList}">
			<g:each in="${officeInstanceList}" status="i" var="officeInstance">
			  <g:if test='${officeInstance.availability == "true"}'>
			    lat = ${fieldValue(bean:officeInstance, field:'lat')};
			    lng = ${fieldValue(bean:officeInstance, field:'lon')};
		   		<%--rlng = rlat / Math.cos(lat * d2r);--%>
   				center =  new google.maps.LatLng(lat, lng);
   				<g:if test='${first==true}'> <% first = false %>
    				   bounds = new google.maps.LatLngBounds( center, new google.maps.LatLng(lat + 0.05, lng + 0.05));
    			</g:if>
    			<g:else>
    				bounds.extend(center); 
    			</g:else>
   				<%--
   				if(bounds == null)
   				   bounds = new google.maps.LatLngBounds( center, currPt);
   				  	
			 	var extp = new Array();
					   for (var i=0; i < points+1; i++) // one extra here makes sure we connect the
					   {
					      theta = Math.PI * (i / (points/2));
  			              ex = lng + (rlng * Math.cos(theta)); // center a + radius x * cos(theta)
					      ey = lat + (rlat * Math.sin(theta)); // center b + radius y * sin(theta)
					      currPt = new google.maps.LatLng(ey, ex);
					      bounds.extend(currPt);
					      extp.push(currPt);
					   }

				polyOptions = { path: extp, strokeColor: '#006DBA',
					    strokeOpacity: 1.0, strokeWeight: 3}
				poly = new google.maps.Polyline(polyOptions); poly.setMap(map);
			 --%>	
	          	marker = new google.maps.Marker({map: map, position: center, title:"${officeInstance.name}"});
				          	<%--///////////DEBUG marker = new google.maps.Marker({map: map, position: currPt, title:"${officeInstance.name}"}); --%>
							<%--g:each in="${officeInstance.advertisingZipcodes}" status="j" var="zip">
							 currPt = new google.maps.LatLng(${zip.lat}, ${zip.lon});
							 marker = new google.maps.Marker({map: map, position: currPt, title:"${zip.city }"});
							</g:each--%>
              </g:if>
			</g:each>
				map.fitBounds(bounds);
				map.setCenter(bounds.getCenter());
		</g:if>
	  }
    --></script>
                     
    </head>
    <body onload="initialize();"> 
        <div >
		<g:include view="common/header.gsp"  />
		</div>
		<div style='clear:both;'>
             <img style="padding: 30px 0px;" src="/images/itd/reg/register_progress2.png" class='center'  />
        </div>


<%--
	<g:include view="common/header.gsp"  />
	   <table class="center"><tr><td>
	   <img src="/images/itd/reg/register_progress2.png"/>
       </td></tr></table>        
 --%>
       <div class="body">
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            
            <%-- begin --%>
<div id="canvas">
 <div class="line">            
  <div class="item" id="item1" style="padding: 0px">
      <div class="sap-content">
				            <g:form action="newRegistration" method="post" >
				                <div class="dialog" style="padding: 0px">
				                    <table width="100%" style="padding: 0px">
				                        <tbody>
											<tr width="100%" >
											<td width="33%" style="padding: 0px">	
													<table style="padding: 0px">		                        
						                            <tr class="prop" style="padding: 0px">
										                <td colspan="2" valign="top" class="value" style="padding: 0px; width:85%">
										                    <p style="padding-bottom: 7px; font-size: 40; font-family: arial; line-height: 100%" >
										                    Sign Up
										                    </p><br/>
										                    <p style="font-size: 22; font-family: arial; line-height: 100%">
										                    <strong>Step 2.</strong> Your Offices...<br/>
										                    </p>
										                    <p style="font-size: 16; font-family: arial; line-height: 100%">
										                    Review the summary below and<br/>
										                    click <span class="red">Next</span> to continue.</p><br/>
										                    <p style="font-size: 14; font-family: arial; line-height: 100%">
										                    Summary:</p><br/><hr style="width:100%"/><br/>
													            <g:if test="${officeInstanceList}">
														            <div >
														                <table width="100%">
														                    <tbody>
														                    <g:each in="${officeInstanceList}" status="i" var="officeInstance">
														                      <g:if test='${officeInstance.availability == "true"}'>
														                        <tr>
														                        
														                            <td align="left" class="summaryText">${fieldValue(bean:officeInstance, field:'name')}</td>
														                        
														                            <td align="right" class="summaryText">
														                               Included&nbsp;&nbsp;
														                            </td>
														                        </tr>
														                       </g:if>
														                    </g:each>
														                        <tr>
														                            <td width="100%" colspan="2" class="summaryText-hr-td">
														                            <br/><hr/>
														                            </td>
														                        </tr>
														                        <tr>
														                            <td align="left" class="summaryText">
														                            Total</td>
														                            <td align="right" class="summaryText">
														                               $${Payment.priceAsString(totalPrice as double)}&nbsp;/&nbsp;month
														                            </td>
														                        </tr>
														                    </tbody>
														                </table>
<%--											                            <br/><hr style="width:95%"/>
														                <table width="90%">
														                    <tbody>
														                        <tr>
														                            <td align="left" class="summaryText">
														                            Total</td>
														                            <td align="right" class="summaryText right-element">
														                               $${Payment.priceAsString(totalPrice as double)}&nbsp;/&nbsp;month
														                            </td>
														                        </tr>
														                    </tbody>
														                </table>--%>
														            </div>
													            </g:if>
										                <div >
										            <br/><br/>
										           <g:submitButton name="next" value="" class="view_territory" />
							                       <%-- g:submitButton name="next" value="" class="reserve_territory" />--%><br/>
							                       <g:submitButton name="back" value="" class="back"/>
										                </div>

										                </td>
						                            </tr> 
						                        
						                            </table> 
						                     </td>
											</tr>			                        
				                        </tbody>
				                    </table>
				                </div>
				            </g:form>
        </div><%-- item1 sapcontend --%>
    </div>
    <div class="item" id="item2">
        <div class="sap-content">
            					<p style="font-size: 23; font-family: arial; padding: 10px 0px; text-align:left">
									Office and Nearby Zip Codes
								<p/>
        
						  	<div id="map_canvas" style="width: 100%; height: 600px"></div>
				            <g:if test="${officeInstanceList}">
				               <br/>
					            <div class="list">
					                <table class="table">
					                    <thead>
					                        <tr>
					                   	        <th>Office&nbsp;Location&nbsp;Name</th>
					                   	        <th>&nbsp;&nbsp;Address</th>
					                   	        <th>ZIP Codes</th>
					                   	        <%-- th>Action</th--%>
					                        </tr>
					                    </thead>
					                    <tbody>
					                    <g:each in="${officeInstanceList}" status="i" var="officeInstance">
					                      <g:if test='${officeInstance.availability == "true"}'>
					                        <tr class='last-${(i+1)==officeInstanceList.size}'>
					                            <td>${fieldValue(bean:officeInstance, field:'name')}</td>
					                        
					                            <td>
					                               	<pre style="font:11px/12px verdana,arial,helvetica,sans-serif;">${fieldValue(bean:officeInstance, field:'addressLine1')}</pre>
					                            	<pre style="font:11px/12px verdana,arial,helvetica,sans-serif;">${fieldValue(bean:officeInstance, field:'city')}, ${fieldValue(bean:officeInstance, field:'state')}</pre> 
					                            	${fieldValue(bean:officeInstance, field:'zipcode')}
					                            </td>
					                            <td width="50%">
					                    		<g:each in="${officeInstance.advertisingZipcodes}" status="j" var="zipcode">${j != 0 ? ', ' : ''}${zipcode.zipcode}</g:each>
					                            </td>
					                          <%--   
					                            <td>
					                            
				            <g:form action="newRegistration" method="post" >
				            		<input type="hidden" name="index" value="${i}" />
							                       <g:submitButton name="removeOffice" value="Remove" class="red_link_button"/>					       </g:form>
					                            </td>
					                        --%>
					                        </tr>
					                        </g:if>
					                    </g:each>
					                    </tbody>
					                </table>
					            </div>
				            </g:if>
         </div><%-- item2 sapcontend --%>
	</div>

  </div>
</div>
        </div>
 <br/><br/><br/><img src="/images/itd/bottom_bar.jpg"/>           
    </body>
</html>
