<%@ page import="com.itda.Office" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="${message(code: 'office.label', default: 'Office')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
        <meta name="layout" content="main" />
	<%-- map v3  --%>
   <meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
	
	<script type="text/javascript"><!--
	  var map;
	  function initialize() {
		  <% def zoomLevel = officeInstance.lat ? 11 : 4 %>
	    var latlng = new google.maps.LatLng(37.71859032558813,-95.44921875);
	    var myOptions = {
	      zoom: ${zoomLevel},
	      center: latlng,
	      draggable: true,
		  navigationControl: true,
		  mapTypeControl: false,
		  scaleControl: true,	      
	      mapTypeId: google.maps.MapTypeId.ROADMAP
	    }
	    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
        var bounds, center;
	  <g:if test='${officeInstance.lat}'>
   		var lat, lng, marker;
		    lat = ${fieldValue(bean:officeInstance, field:'lat')};
		    lng = ${fieldValue(bean:officeInstance, field:'lon')};
			center =  new google.maps.LatLng(lat, lng);
          	marker = new google.maps.Marker({map: map, position: center, title:"${officeInstance.name}"});
    		map.setCenter(center);
		</g:if>
	  }
    --></script>
            
    </head>
    <body onload="initialize();">
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${officeInstance}">
            <div class="errors">
                <g:renderErrors bean="${officeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${officeInstance?.id}" />
                <g:hiddenField name="version" value="${officeInstance?.version}" />
                <div class="dialog">
				  <table><tr><td>
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="monthlySubscriptionPrice"><g:message code="office.monthlySubscriptionPrice.label" default="Monthly Subscription Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'monthlySubscriptionPrice', 'errors')}">
                                    <g:select name="monthlySubscriptionPrice" from="${[0,100,300]}" value="${fieldValue(bean: officeInstance, field: 'monthlySubscriptionPrice')}" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="availability"><g:message code="office.availability.label" default="Availability" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'availability', 'errors')}">
                                    <select>
									  <g:if test="${officeInstance.availability == 'true'}">
									  <option value="false" >false</option>
									  <option value="true" selected="true">true</option>
									  </g:if>
									  <g:else>
									  <option value="false" selected="true">false</option>
									  <option value="true" >true</option>
									  </g:else>
									</select>
                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="office.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" maxlength="128" value="${officeInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="addressLine1"><g:message code="office.addressLine1.label" default="Address Line1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'addressLine1', 'errors')}">
                                    <g:textField name="addressLine1" maxlength="128" value="${officeInstance?.addressLine1}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="city"><g:message code="office.city.label" default="City" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'city', 'errors')}">
                                    <g:textField name="city" maxlength="128" value="${officeInstance?.city}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="state"><g:message code="office.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'state', 'errors')}">
                                    <g:select name="state" from="${officeInstance.constraints.state.inList}" value="${officeInstance?.state}" valueMessagePrefix="office.state"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="zipcode"><g:message code="office.zipcode.label" default="Zipcode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'zipcode', 'errors')}">
                                    <g:textField name="zipcode" maxlength="5" value="${officeInstance?.zipcode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="business"><g:message code="office.business.label" default="Business Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'business', 'errors')}">
                                   <select name="business.id" id="business.id" >
                                   <option value="${officeInstance?.business?.id}" >
                                   ${officeInstance?.business?.businessName}</option></select>
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                    </td>
                    <td>
						  	<div id="map_canvas" style="width: 550px; height: 300px"></div>                  	
                  	</td></tr>
                   </table>
                    
                   <input type="hidden" name="lat" value="${fieldValue(bean: officeInstance, field: 'lat')}"/>
                   <input type="hidden" name="lon" value="${fieldValue(bean: officeInstance, field: 'lon')}"/>
                   <input type="hidden" name="upperLeftLat"  value="${fieldValue(bean: officeInstance, field: 'upperLeftLat')}"/>
                   <input type="hidden" name="upperLeftLon" value="${fieldValue(bean: officeInstance, field: 'upperLeftLon')}"/>
                   <input type="hidden" name="lowerRightLat"  value="${fieldValue(bean: officeInstance, field: 'lowerRightLat')}"/>
                   <input type="hidden" name="lowerRightLon" value="${fieldValue(bean: officeInstance, field: 'lowerRightLon')}"/>
                  <input type="hidden" name="accuracyLevel" value="${fieldValue(bean: officeInstance, field: 'accuracyLevel')}"  />
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>

                <div class="dialog">
				  <table>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="newAdvertisingZipcodes">Enter New Zip Code</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'advertisingZipcodes', 'errors')}">
            <g:form method="post" >
			                <g:hiddenField name="id" value="${officeInstance?.id}" />
                                <input name="zipcode" maxLength="5"/> <g:actionSubmit class="save" action="addZipcode" value="Add Zip Code" />
            </g:form>
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="advertisingZipcodes"><g:message code="office.advertisingZipcodes.label" default="Advertising Zipcodes" /></label>
                                </td>
                                <td valign="top" style="font:14px arial" 
                                class="value ${hasErrors(bean: officeInstance, field: 'advertisingZipcodes', 'errors')}">
            <g:form method="post" >
                <g:hiddenField name="id" value="${officeInstance?.id}" />
			<g:each in="${officeInstance?.advertisingZipcodes?}" var="zip" status="i">
				${(i % 10) == 0 ? "<br/>" : ""}
				<input type="checkbox" name="zipcodes" value="${zip.id}"/>${zip.zipcode}&nbsp;&nbsp;&nbsp;&nbsp;
			</g:each>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="delete" action="deleteZipcodes" value="Delete Zip Code(s)" onclick="return confirm('Are you sure?');" /></span>
                </div>
            </g:form>

                                </td>
                            </tr>                        

                   </table>

        </div>
    </body>
</html>
