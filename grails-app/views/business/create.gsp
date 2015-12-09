
<%@ page import="com.itda.Business" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'business.label', default: 'Business')}" />
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
            <g:hasErrors bean="${businessInstance}">
            <div class="errors">
                <g:renderErrors bean="${businessInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="businessName"><g:message code="business.businessName.label" default="Business Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'businessName', 'errors')}">
                                    <g:textField name="businessName" maxlength="128" value="${businessInstance?.businessName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="representativeName"><g:message code="business.representativeName.label" default="Representative Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'representativeName', 'errors')}">
                                    <g:textField name="representativeName" maxlength="128" value="${businessInstance?.representativeName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="business.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${businessInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="phone"><g:message code="business.phone.label" default="Phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'phone', 'errors')}">
                                    <g:textField name="phone" value="${businessInstance?.phone}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="notes">Notes</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'notes', 'errors')}">
                                    <g:textArea name="notes" cols="40" rows="5" value="${businessInstance?.notes}" />
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
