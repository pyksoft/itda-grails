<%@ page import="com.itda.Office" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'office.label', default: 'Office')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
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
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
            <table><tr><td>
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.name.label" default="Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "name")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.monthlySubscriptionPrice.label" default="Monthly Subscription Price" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "monthlySubscriptionPrice")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.availability.label" default="Availability" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "availability")}</td>
                            
                        </tr>
                    
                                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.addressLine1.label" default="Address Line1" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "addressLine1")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.city.label" default="City" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "city")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.state.label" default="State" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "state")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.zipcode.label" default="Zipcode" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "zipcode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.business.label" default="Business" /></td>
                            
                            <td valign="top" class="value"><g:link controller="business" action="show" id="${officeInstance?.business?.id}">${officeInstance?.business?.businessName}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.advertisingZipcodes.label" default="Advertising Zipcodes" /></td>
                            
                            <td valign="top" class="value">
                                <g:each in="${officeInstance.advertisingZipcodes}" var="zip">
                                    ${zip?.zipcode}
                                </g:each>
                            </td>
                            
                        </tr>
<%--
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.accuracyLevel.label" default="Accuracy Level" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "accuracyLevel")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.lat.label" default="Lat" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "lat")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.lon.label" default="Lon" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "lon")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.upperLeftLat.label" default="Upper Left Lat" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "upperLeftLat")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.upperLeftLon.label" default="Upper Left Lon" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "upperLeftLon")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.lowerRightLat.label" default="Lower Right Lat" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "lowerRightLat")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="office.lowerRightLon.label" default="Lower Right Lon" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: officeInstance, field: "lowerRightLon")}</td>
                            
                        </tr>
--%>                    
                    </tbody>
                </table>
                    </td>
                    <td>
						  	<div id="map_canvas" style="width: 550px; height: 300px"></div>                  	
                  	</td></tr>
                   </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${officeInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
