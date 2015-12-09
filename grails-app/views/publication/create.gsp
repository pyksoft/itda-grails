<%@ page import="com.itda.Publication" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'publication.label', default: 'Publication')}" />
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
            <g:hasErrors bean="${publicationInstance}">
            <div class="errors">
                <g:renderErrors bean="${publicationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="newspaperOrPublicationName"><g:message code="publication.newspaperOrPublicationName.label" default="Newspaper Or Publication Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'newspaperOrPublicationName', 'errors')}">
                                    <g:textField name="newspaperOrPublicationName" maxlength="128" value="${publicationInstance?.newspaperOrPublicationName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="publicationPhone"><g:message code="publication.publicationPhone.label" default="Publication Phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'publicationPhone', 'errors')}">
                                    <g:textField name="publicationPhone" value="${publicationInstance?.publicationPhone}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contactName"><g:message code="publication.contactName.label" default="Contact Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'contactName', 'errors')}">
                                    <g:textField name="contactName" maxlength="128" value="${publicationInstance?.contactName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contactPhone"><g:message code="publication.contactPhone.label" default="Contact Phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'contactPhone', 'errors')}">
                                    <g:textField name="contactPhone" value="${publicationInstance?.contactPhone}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email"><g:message code="publication.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${publicationInstance?.email}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="alternateEmail"><g:message code="publication.alternateEmail.label" default="Alternate Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'alternateEmail', 'errors')}">
                                    <g:textField name="alternateEmail" value="${publicationInstance?.alternateEmail}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine1"><g:message code="publication.addressLine1.label" default="Address Line1" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'addressLine1', 'errors')}">
                                    <g:textField name="addressLine1" maxlength="128" value="${publicationInstance?.addressLine1}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city"><g:message code="publication.city.label" default="City" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'city', 'errors')}">
                                    <g:textField name="city" maxlength="128" value="${publicationInstance?.city}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="publication.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'state', 'errors')}">
                                    <g:select name="state" from="${publicationInstance.constraints.state.inList}" value="${publicationInstance?.state}" valueMessagePrefix="publication.state"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zipcode"><g:message code="publication.zipcode.label" default="Zipcode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'zipcode', 'errors')}">
                                    <g:textField name="zipcode" maxlength="5" value="${publicationInstance?.zipcode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="business"><g:message code="publication.business.label" default="Business" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: publicationInstance, field: 'business', 'errors')}">
                                    <g:select name="business.id" from="${com.itda.Business.list()}" optionKey="id" value="${publicationInstance?.business?.id}" optionValue="businessName" />
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
