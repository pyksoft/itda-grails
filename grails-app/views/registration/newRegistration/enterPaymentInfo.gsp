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
        <link href="/jquery-1.7.1/css/smoothness/jquery-ui-1.8.17.custom.css" rel="stylesheet" type="text/css"/>
  		<script src="/jquery-1.7.1/js/jquery-1.7.1.min.js"></script>
  		<script src="/jquery-1.7.1/js/jquery-ui-1.8.17.custom.min.js"></script>
	<%-- map v3  --%>
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
	
	<script type="text/javascript">
	  var geocoder;
	  var map, bounds= null;
	  function initialize() {
		 $("td.errors input:checkbox").css("outline","1px solid red");
	    geocoder = new google.maps.Geocoder();
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
	    <% boolean first = true %>
	    <g:if test="${officeInstanceList}">
			<g:each in="${officeInstanceList}" status="i" var="officeInstance">
			  <g:if test='${officeInstance.availability == "true"}'>
   				point =  new google.maps.LatLng(${fieldValue(bean:officeInstance, field:'lat')},
			    	 ${fieldValue(bean:officeInstance, field:'lon')});   	 				
   				<g:if test='${first==true}'> <% first = false %>
				   bounds = new google.maps.LatLngBounds( point, new google.maps.LatLng(point.lat() + 0.05, point.lng() + 0.05));
				</g:if>
				<g:else>
					bounds.extend(point); 
				</g:else>
	          	var marker = new google.maps.Marker({map: map, position: point, title:"${officeInstance.name}"});
	          </g:if>
			</g:each>
				map.fitBounds(bounds);
				map.setCenter(bounds.getCenter());
		</g:if>
	    
	  }
	
    </script>
	<script>
	function whatisthis() {
		$( "#dialog" ).dialog();
	}
	</script>
                     
    </head>
    <body onload="initialize();"> 
        <div >
		<g:include view="common/header.gsp"  />
		</div>
		<div style='clear:both;'>
             <img style="padding: 30px 0px;" src="/images/itd/reg/register_progress3.png" class='center'  />
        </div>
        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:if test="${(paymentInstance && paymentInstance.hasErrors() ) 
                         || (businessInstance && businessInstance.hasErrors())}">
	            <div class="errors">
	            	<g:renderErrors bean="${businessInstance}" as="list" />
	                <g:renderErrors bean="${paymentInstance}" as="list" />
	            </div>            
            </g:if>            

            
            <%-- begin --%>                        
<div id="canvas">
 <div class="line">            
  <div class="item" id="item1" style="padding: 0px;">
      <div class="sap-content" style="padding: 0px;">
            <g:form action="newRegistration" method="post" >
                <div >
                    <table style="padding: 0px;">
                        <tbody>
						            <tr style="padding: 0px;">
						                <td  valign="top" style="padding: 0px;">
						                    <p style="font-size: 40; font-family: arial;  line-height: 100%" >
						                    Sign Up
						                    </p><br/>
						                    <p style="padding-top: 7px; font-size: 21; font-family: arial;line-height: 105%">
						                    <strong>Step 3.</strong> Hello.<br/>
						                    Nice to meet you.
						                    </p><br/>
						                    <strong>Please introduce yourself.<strong/>
						                    <%-- p style="padding-top: 7px; font-weight: bold; color: #475659; font-size: 13;">Please introduce yourself.</p--%> 
						                </td>
						            </tr>                             
						            <tr class="prop">
						                <td  valign="top" class="value">
						                     <label>(*) indicates required field</label>
						                </td>
						            </tr>     
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'representativeName','errors')}">
		                                    <label>* Your Name:</label><br/>
		                                    <input type="text" maxlength="128" size="35" id="representativeName" name="representativeName" value="${fieldValue(bean:businessInstance,field:'representativeName')}"/>
		                                </td>
		                            </tr> 
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'businessName','errors')}">
		                                    <label for="businessName">* Your Business Name:</label><br/>
		                                    <input type="text" maxlength="128" size="35" id="businessName" name="businessName" value="${fieldValue(bean:businessInstance,field:'businessName')}"/>
		                                </td>
		                            </tr> 
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'email','errors')}">
		                                    <label for="email">* Your Email Address:</label><br/>
		                                    <input type="text" maxlength="128" size="35" id="email" name="email" value="${fieldValue(bean:businessInstance,field:'email')}"/>
		                                </td>
		                            </tr> 
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'phone','errors')}">
		                                    <label for="phone">* Your Phone Number:</label>&nbsp;&nbsp;xxx-xxx-xxxx<br/>
		                                    <input type="text" maxlength="12" size="35" id="phone" name="phone" value="${fieldValue(bean:businessInstance,field:'phone')}"/>
		                                </td>
		                            </tr> 


						            <tr class="prop">
						                <td  valign="top" class="value">
						            <p style="font-size: 23; font-family: arial; line-height: 100%">
	                    			Your Payment information<br/>
	                    			</p>
						                </td>
						            </tr>     
						                                    
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:paymentInstance,field:'firstName','errors')}">
		                                    <label for="firstName">* Your First Name:</label><br/>
		                                    <input type="text" maxlength="50" size="35" id="firstName" name="firstName" value="${fieldValue(bean:paymentInstance,field:'firstName')}"/>
		                                </td>
		                            </tr> 
		
		                            <tr class="prop">
		                                <td  valign="top" class="value ${hasErrors(bean:paymentInstance,field:'lastName','errors')}">
		                                    <label for="lastName">* Your Last Name:</label><br/>
		                                    <input type="text" maxlength="50" size="35" id="lastName" name="lastName" value="${fieldValue(bean:paymentInstance,field:'lastName')}"/>
		                                </td>
		                            </tr> 
						            <tr class="prop">
						                <td  valign="top" class="value">
						                     <label>* The credit card we may bill each month</label>
						                     <img src="/images/itd/reg/cards.jpg" />
						                </td>
						            </tr>     
		                        
		                            <tr class="prop">
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
		                        
		                            <tr class="prop">
		                            	<%
											def cal =  Calendar.getInstance();
											def startYear = cal.get(Calendar.YEAR) % 100;
											def endYear = startYear + 15;				
										 %>
		                                <td valign="top" class="value ${hasErrors(bean:paymentInstance,field:'expireMonth','errors')} ${hasErrors(bean:paymentInstance,field:'expireYear','errors')}">
		                                    <label for="expireMonth">* The Expiration Date: Month: Year:</label><br/>
		                                    <g:select id="expireMonth" name="expireMonth" from="${(new Payment()).constraints.expireMonth.inList}" value="${fieldValue(bean:paymentInstance,field:'expireMonth')}" ></g:select>
		                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                                    <g:select id="expireYear" name="expireYear" from="${startYear..endYear}" noSelection="${['':'']}" value="${fieldValue(bean:paymentInstance,field:'expireYear')}" ></g:select>
		                            </td></tr> 
		                        
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:paymentInstance,field:'cardSecurityCode','errors')}">
		                                    <label for="cardSecurityCode">* Your Card Security Code: </label><span class="red_link_button" onclick="whatisthis();">What is this?</span>
<div id="dialog" title="" style="font-size: 13; display: none; text-align:left;">
<p><strong>Your Card Security Code</strong><br/><br/>
<p><strong>What is the Security Code?</strong><br/>
The security code is an additional code on your credit card that helps validate the card's owner.<br/><br/>

<strong>Where can I find the security code if I have a Visa, MasterCard or Discover Card?</strong><br/>
You will find the 3 digit security code on the back of your credit card in the signature box. Use the last three numbers. </p>
</div>

		                                    <br/>
		                                    <input type="text" maxlength="4" size="35" id="cardSecurityCode" name="cardSecurityCode" value="${fieldValue(bean:paymentInstance,field:'cardSecurityCode')}"/>
		                                </td>
		                            </tr> 
		                        
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:paymentInstance,field:'billingAddress','errors')}">
		                                    <label for="billingAddress">* Your Billing Address:</label><br/>
		                                    <input type="text" maxlength="60" size="35" id="billingAddress" name="billingAddress" value="${fieldValue(bean:paymentInstance,field:'billingAddress')}"/>
		                                </td>
		                            </tr> 
		                        
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:paymentInstance,field:'city','errors')}">
		                                    <label for="city">* Your City:</label><br/>
		                                    <input type="text" maxlength="40" size="35" id="city" name="city" value="${fieldValue(bean:paymentInstance,field:'city')}"/>
		                                </td>
		                            </tr> 
		                        
		                            <tr class="prop"><td>
		                               <table>
		                                 <tr>
		                                <td  valign="top" style="padding:0" class="value ${hasErrors(bean:paymentInstance,field:'state','errors')}">
		                                    <label for="state">* Your State:</label><br/>
		                                    <g:select id="state" name="state" from="${(new Payment()).constraints.state.inList}" value="${fieldValue(bean:paymentInstance,field:'state')}" ></g:select>
		                                </td>
		                                <td  valign="top" style="padding:0" class="value ${hasErrors(bean:paymentInstance,field:'zipcode','errors')}">
		                                    <label for="zipcode">* Your Zipcode:</label>&nbsp;&nbsp;xxxxx<br/>
		                                    <input type="text" maxlength="5" size="23" id="zipcode" name="zipcode" value="${fieldValue(bean:paymentInstance,field:'zipcode')}"/>
		                                </td>
		                                </table>
		                            </td></tr> 
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'acceptedTerms','errors')}">
		                                    <g:checkBox name="acceptedTerms" value="${'true'}" checked="${businessInstance?.acceptedTerms}"/>
		                                    <label>* Accept </label><span onclick='window.open("http://inthedooradvertising.com/terms-of-use/", "new", "scrollbars=1,width=1024");' class='red_link_button'>Terms of Agreement</span><br/>
		                                </td>
		                            </tr> 
		                        
		                            <tr>
						                <td valign="top" >
						                		<div>
							                       <g:submitButton name="next" value="" class="purchase" /><br/>
							                       <g:submitButton name="back" value="" class="back"/>
							                     </div>
							             </td>
		                            </tr> 
		                            
                        		 </table>
                        	
                        </tbody>
                    </table>
                </div>
            </g:form>
        </div><%-- item1 sapcontend --%>
    </div>
    <div class="item" id="item2">
        <div style="padding: 10px 0px;" class="sap-content">
		                    <p style="padding: 10px 0px; font-size: 23; font-family: arial; text-align:left">
		                    Your Office Locations
		                    </p>
		                    <br/>
				            <div id="map_canvas" style="width: 100%; height: 450px"></div>
                            <br/>
		                    <p style="padding: 10px 0px; font-size: 23; font-family: arial; text-align:left">
		                    Summary
		                    </p>
					            <div class="list" id='regSummary'>
					                <table>
					                    <thead >
					                        <tr>
					                   	        <th>Office&nbsp;Name&nbsp;</th>
					                   	        <th>&nbsp;Address&nbsp;</th>
					                        	<th>&nbsp;<%-- ZIP Codes&nbsp;--%></th>
					                        	<th>Price</th>                        
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
					                            <td>&nbsp;
					                    		<%--<g:each in="${officeInstance.advertisingZipcodes}" status="j" var="zipcode">${j != 0 ? ', ' : ''}${zipcode.zipcode}</g:each>--%>
					                            </td>
					                            <td style="font-weight: bold">Included</td>					                           					                        
					                        </tr>
					                       </g:if>
					                    </g:each>
					                    </tbody>
					                </table>
					                <div style='margin-top:15px;font-weight:bold;font-size:13.5px;float:right;border:1px solid #ddd;padding:5px 10px'>Your Total: $${Payment.priceAsString(totalPrice as double)}&nbsp;/&nbsp;month</div>
					                
					            </div>
                            <%-- office list --%>

                            
         </div><%-- item2 sapcontend --%>
	</div>

  </div>
</div>
            <%-- end canvas --%>
</div>
 <br/><br/><br/><img src="/images/itd/bottom_bar.jpg"/>           
    </body>
</html>
