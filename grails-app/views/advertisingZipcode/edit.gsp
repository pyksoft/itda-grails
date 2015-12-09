
<%@ page import="com.itda.AdvertisingZipcode" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${advertisingZipcodeInstance}">
            <div class="errors">
                <g:renderErrors bean="${advertisingZipcodeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${advertisingZipcodeInstance?.id}" />
                <g:hiddenField name="version" value="${advertisingZipcodeInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="zipcode"><g:message code="advertisingZipcode.zipcode.label" default="Zipcode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: advertisingZipcodeInstance, field: 'zipcode', 'errors')}">
                                    <g:textField name="zipcode" maxlength="5" value="${advertisingZipcodeInstance?.zipcode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="office"><g:message code="advertisingZipcode.office.label" default="Office" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: advertisingZipcodeInstance, field: 'office', 'errors')}">
                                    <g:select name="office.id" from="${com.itda.Office.list()}" optionKey="id" value="${advertisingZipcodeInstance?.office?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lon"><g:message code="advertisingZipcode.lon.label" default="Lon" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: advertisingZipcodeInstance, field: 'lon', 'errors')}">
                                    <g:textField name="lon" value="${fieldValue(bean: advertisingZipcodeInstance, field: 'lon')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="lat"><g:message code="advertisingZipcode.lat.label" default="Lat" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: advertisingZipcodeInstance, field: 'lat', 'errors')}">
                                    <g:textField name="lat" value="${fieldValue(bean: advertisingZipcodeInstance, field: 'lat')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="city"><g:message code="advertisingZipcode.city.label" default="City" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: advertisingZipcodeInstance, field: 'city', 'errors')}">
                                    <g:textField name="city" value="${advertisingZipcodeInstance?.city}" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
