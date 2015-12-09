
<%@ page import="com.itda.admin.ItdaAttribute" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'itdaAttribute.label', default: 'ItdaAttribute')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${itdaAttributeInstance}">
            <div class="errors">
                <g:renderErrors bean="${itdaAttributeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name"><g:message code="itdaAttribute.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itdaAttributeInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${itdaAttributeInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="value"><g:message code="itdaAttribute.value.label" default="Value" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itdaAttributeInstance, field: 'value', 'errors')}">
                                    <g:textField name="value" value="${itdaAttributeInstance?.value}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="displayOrder"><g:message code="itdaAttribute.displayOrder.label" default="Display Order" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itdaAttributeInstance, field: 'displayOrder', 'errors')}">
                                    <g:textField name="displayOrder" value="${fieldValue(bean: itdaAttributeInstance, field: 'displayOrder')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="enabled"><g:message code="itdaAttribute.enabled.label" default="Enabled" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itdaAttributeInstance, field: 'enabled', 'errors')}">
                                    <g:checkBox name="enabled" value="${itdaAttributeInstance?.enabled}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="shortLabel"><g:message code="itdaAttribute.shortLabel.label" default="Short Label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itdaAttributeInstance, field: 'shortLabel', 'errors')}">
                                    <g:textField name="shortLabel" value="${itdaAttributeInstance?.shortLabel}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="longLabel"><g:message code="itdaAttribute.longLabel.label" default="Long Label" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: itdaAttributeInstance, field: 'longLabel', 'errors')}">
                                    <g:textField name="longLabel" value="${itdaAttributeInstance?.longLabel}" />
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
