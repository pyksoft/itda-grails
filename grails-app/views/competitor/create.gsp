
<%@ page import="com.itda.Competitor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'competitor.label', default: 'Competitor')}" />
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
            <g:hasErrors bean="${competitorInstance}">
            <div class="errors">
                <g:renderErrors bean="${competitorInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="businessName"><g:message code="competitor.businessName.label" default="Compititor Business Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: competitorInstance, field: 'businessName', 'errors')}">
                                    <g:textField name="businessName" maxlength="128" value="${competitorInstance?.businessName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ownerName"><g:message code="competitor.ownerName.label" default="Owner Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: competitorInstance, field: 'ownerName', 'errors')}">
                                    <g:textField name="ownerName" maxlength="128" value="${competitorInstance?.ownerName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="address"><g:message code="competitor.address.label" default="Address" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: competitorInstance, field: 'address', 'errors')}">
                                    <g:textField name="address" maxlength="128" value="${competitorInstance?.address}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city"><g:message code="competitor.city.label" default="City" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: competitorInstance, field: 'city', 'errors')}">
                                    <g:textField name="city" maxlength="128" value="${competitorInstance?.city}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="competitor.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: competitorInstance, field: 'state', 'errors')}">
                                    <g:select name="state" from="${competitorInstance.constraints.state.inList}" value="${competitorInstance?.state}" valueMessagePrefix="competitor.state" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zipcode"><g:message code="competitor.zipcode.label" default="Zipcode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: competitorInstance, field: 'zipcode', 'errors')}">
                                    <g:textField name="zipcode" maxlength="5" value="${competitorInstance?.zipcode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="business"><g:message code="competitor.business.label" default="Business" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: competitorInstance, field: 'business', 'errors')}">
                                    <g:select name="business.id" from="${com.itda.Business.list()}" optionKey="id" value="${competitorInstance?.business?.id}" optionValue="businessName" />
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
