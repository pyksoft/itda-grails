
<%@ page import="com.itda.Vendor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vendor.label', default: 'Vendor')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${vendorInstance}">
            <div class="errors">
                <g:renderErrors bean="${vendorInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="vendorName"><g:message code="vendor.vendorName.label" default="Vendor Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'vendorName', 'errors')}">
                                    <g:textField name="vendorName" maxlength="128" value="${vendorInstance?.vendorName}" />
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contactName"><g:message code="vendor.contactName.label" default="Contact Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'contactName', 'errors')}">
                                    <g:textField name="contactName" maxlength="128" value="${vendorInstance?.contactName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contactPhone"><g:message code="vendor.contactPhone.label" default="Contact Phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'contactPhone', 'errors')}">
                                    <g:textField name="contactPhone" value="${vendorInstance?.contactPhone}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="vendor.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${vendorInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="alternateEmail"><g:message code="vendor.alternateEmail.label" default="Alternate Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'alternateEmail', 'errors')}">
                                    <g:textField name="alternateEmail" value="${vendorInstance?.alternateEmail}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="address"><g:message code="vendor.address.label" default="Address" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'address', 'errors')}">
                                    <g:textField name="address" maxlength="128" value="${vendorInstance?.address}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city"><g:message code="vendor.city.label" default="City" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'city', 'errors')}">
                                    <g:textField name="city" maxlength="128" value="${vendorInstance?.city}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="vendor.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'state', 'errors')}">
                                    <g:select name="state" from="${vendorInstance.constraints.state.inList}" value="${vendorInstance?.state}" valueMessagePrefix="vendor.state"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zipcode"><g:message code="vendor.zipcode.label" default="Zipcode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'zipcode', 'errors')}">
                                    <g:textField name="zipcode" maxlength="5" value="${vendorInstance?.zipcode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="business"><g:message code="vendor.business.label" default="Business" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: vendorInstance, field: 'business', 'errors')}">
                                    <g:select name="business.id" from="${com.itda.Business.list()}" optionKey="id" value="${vendorInstance?.business?.id}" optionValue="businessName" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
