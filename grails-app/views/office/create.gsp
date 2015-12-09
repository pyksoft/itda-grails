
<%@ page import="com.itda.Office" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <g:set var="entityName" value="${message(code: 'office.label', default: 'Office')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
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
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${officeInstance}">
            <div class="errors">
                <g:renderErrors bean="${officeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                  <table>
                  	<tr><td>
                  	  <table>
                        <tbody>
                        
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
                                    <label for="monthlySubscriptionPrice"><g:message code="office.monthlySubscriptionPrice.label" default="Monthly Subscription Price" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'monthlySubscriptionPrice', 'errors')}">
                                    <g:select name="monthlySubscriptionPrice" from="${[0,100,300]}" value="${fieldValue(bean: officeInstance, field: 'monthlySubscriptionPrice')}" noSelection="['': '']" />
                                </td>
                            </tr>
                         
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine1"><g:message code="office.addressLine1.label" default="Address" /></label>
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
                                    <g:if test="${params.business && params.business.id}">
	                                    <g:select name="business.id" from="${com.itda.Business.findById(params.business.id)}" optionKey="id" value="${params.business.id}" optionValue="businessName" />
                                    </g:if>
                                    <g:else>
                                    	<g:select name="business.id" from="${com.itda.Business.list()}" optionKey="id" value="${officeInstance?.business?.id}" optionValue="businessName" />
                                    </g:else>
                                </td>
                            </tr>
                            
                            <g:if test="${officeInstance?.availability}">                         	
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="availability"><g:message code="office.availability.label" default="Availability" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: officeInstance, field: 'availability', 'errors')}">
                                    <strong>${fieldValue(bean: officeInstance, field: 'availability')}</strong>
                                </td>
                            </tr>
							</g:if>
							<else>
		                   <input type="hidden" name="availability" value="${fieldValue(bean: officeInstance, field: 'availability')}"/>
							</else>
							                    
                            <g:if test="${officeInstance.territoryZipcodes}">
                            
                        	<tr class="prop">
	                            <td valign="top" class="name"><label for=territoryZipcodes>
	                            <g:message code="office.territoryZipcodes.label" default="Territory Zip Codes" />
	                            </label></td>
	                            <td valign="top" class="value">
	                                <g:each in="${officeInstance.territoryZipcodes}" var="zipcode">
	                                    ${zipcode}
	                                </g:each>
	                            </td>
                        	</tr>    
                        	
	                            <g:if test="${conflictingZipcodes}">
	                       	<tr class="prop">
	                            <td valign="top" class="name">
	                            <label for="conflictingZipcodes">Conflicting Zip Codes</label>
	                            </td>
	                            <td valign="top" class="value">
	                                <g:each in="${conflictingZipcodes}" var="zip">
	                                    ${zip?.zipcode} <g:link action="show" id="${zip?.office.id}">${zip?.office.name}</g:link></br> 
	                                </g:each>
	                            </td>
                        	</tr>    
    	                    	</g:if> 
    	                    	
                        	</g:if> 
                   <input type="hidden" name="lat" value="${fieldValue(bean: officeInstance, field: 'lat')}"/>
                   <input type="hidden" name="lon" value="${fieldValue(bean: officeInstance, field: 'lon')}"/>
                   <input type="hidden" name="upperLeftLat"  value="${fieldValue(bean: officeInstance, field: 'upperLeftLat')}"/>
                   <input type="hidden" name="upperLeftLon" value="${fieldValue(bean: officeInstance, field: 'upperLeftLon')}"/>
                   <input type="hidden" name="lowerRightLat"  value="${fieldValue(bean: officeInstance, field: 'lowerRightLat')}"/>
                   <input type="hidden" name="lowerRightLon" value="${fieldValue(bean: officeInstance, field: 'lowerRightLon')}"/>
                  <input type="hidden" name="accuracyLevel" value="${fieldValue(bean: officeInstance, field: 'accuracyLevel')}"  />
 
                        </tbody>
                    </table>
                    </td>
                    <td>
						  	<div id="map_canvas" style="width: 550px; height: 300px"></div>                  	
                  	</td></tr>
                   </table>
                </div>
                <div class="buttons">
                	<span class="button"><g:submitButton name="checkAvailability" class="checkAvailability" value="${message(code: 'default.button.checkAvailability.label', default: 'Check Availability')}" /></span>
                	
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
