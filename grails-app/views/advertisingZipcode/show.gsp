
<%@ page import="com.itda.AdvertisingZipcode" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="advertisingZipcode.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: advertisingZipcodeInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="advertisingZipcode.zipcode.label" default="Zipcode" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: advertisingZipcodeInstance, field: "zipcode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="advertisingZipcode.office.label" default="Office" /></td>
                            
                            <td valign="top" class="value"><g:link controller="office" action="show" id="${advertisingZipcodeInstance?.office?.id}">${advertisingZipcodeInstance?.office?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="advertisingZipcode.lon.label" default="Lon" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: advertisingZipcodeInstance, field: "lon")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="advertisingZipcode.lastUpdated.label" default="Last Updated" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${advertisingZipcodeInstance?.lastUpdated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="advertisingZipcode.dateCreated.label" default="Date Created" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${advertisingZipcodeInstance?.dateCreated}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="advertisingZipcode.lat.label" default="Lat" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: advertisingZipcodeInstance, field: "lat")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="advertisingZipcode.city.label" default="City" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: advertisingZipcodeInstance, field: "city")}</td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${advertisingZipcodeInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
