
<%@ page import="com.itda.Manufacturer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'manufacturer.label', default: 'Manufacturer')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
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
            <g:hasErrors bean="${manufacturerInstance}">
            <div class="errors">
                <g:renderErrors bean="${manufacturerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${manufacturerInstance?.id}" />
                <g:hiddenField name="version" value="${manufacturerInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="manufacturerName"><g:message code="manufacturer.manufacturerName.label" default="Manufacturer Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'manufacturerName', 'errors')}">
                                    <g:textField name="manufacturerName" maxlength="128" value="${manufacturerInstance?.manufacturerName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="phone"><g:message code="manufacturer.phone.label" default="Phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'phone', 'errors')}">
                                    <g:textField name="phone" value="${manufacturerInstance?.phone}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="contactName"><g:message code="manufacturer.contactName.label" default="Contact Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'contactName', 'errors')}">
                                    <g:textField name="contactName" maxlength="128" value="${manufacturerInstance?.contactName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="contactPhone"><g:message code="manufacturer.contactPhone.label" default="Contact Phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'contactPhone', 'errors')}">
                                    <g:textField name="contactPhone" value="${manufacturerInstance?.contactPhone}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="manufacturer.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${manufacturerInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="alternateEmail"><g:message code="manufacturer.alternateEmail.label" default="Alternate Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'alternateEmail', 'errors')}">
                                    <g:textField name="alternateEmail" value="${manufacturerInstance?.alternateEmail}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="address"><g:message code="manufacturer.address.label" default="Address" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'address', 'errors')}">
                                    <g:textField name="address" maxlength="128" value="${manufacturerInstance?.address}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="city"><g:message code="manufacturer.city.label" default="City" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'city', 'errors')}">
                                    <g:textField name="city" maxlength="128" value="${manufacturerInstance?.city}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="state"><g:message code="manufacturer.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'state', 'errors')}">
                                    <g:select name="state" from="${manufacturerInstance.constraints.state.inList}" value="${manufacturerInstance?.state}" valueMessagePrefix="manufacturer.state"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="zipcode"><g:message code="manufacturer.zipcode.label" default="Zipcode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'zipcode', 'errors')}">
                                    <g:textField name="zipcode" maxlength="5" value="${manufacturerInstance?.zipcode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="business"><g:message code="manufacturer.business.label" default="Business" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerInstance, field: 'business', 'errors')}">
                                    <g:select name="business.id" from="${[manufacturerInstance?.business]}" optionKey="id" value="${manufacturerInstance?.business?.id}" optionValue="businessName" />
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
