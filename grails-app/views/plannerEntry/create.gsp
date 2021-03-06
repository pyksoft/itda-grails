
<%@ page import="com.itda.PlannerEntry" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'plannerEntry.label', default: 'PlannerEntry')}" />
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
            <g:hasErrors bean="${plannerEntryInstance}">
            <div class="errors">
                <g:renderErrors bean="${plannerEntryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="start"><g:message code="plannerEntry.start.label" default="Start" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'start', 'errors')}">
                                    <g:datePicker name="start" precision="day" value="${plannerEntryInstance?.start}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="end"><g:message code="plannerEntry.end.label" default="End" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'end', 'errors')}">
                                    <g:datePicker name="end" precision="day" value="${plannerEntryInstance?.end}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="className"><g:message code="plannerEntry.className.label" default="Class Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'className', 'errors')}">
                                    <g:textField name="className" value="${plannerEntryInstance?.className}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="title"><g:message code="plannerEntry.title.label" default="Title" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'title', 'errors')}">
                                    <g:textField name="title" value="${plannerEntryInstance?.title}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="size"><g:message code="plannerEntry.size.label" default="Size" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'size', 'errors')}">
                                    <g:textField name="size" value="${plannerEntryInstance?.size}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="color"><g:message code="plannerEntry.color.label" default="Color" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'color', 'errors')}">
                                    <g:textField name="color" value="${plannerEntryInstance?.color}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="deadline"><g:message code="plannerEntry.deadline.label" default="Deadline" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'deadline', 'errors')}">
                                    <g:datePicker name="deadline" precision="day" value="${plannerEntryInstance?.deadline}" noSelection="['': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="selectAdFrom"><g:message code="plannerEntry.selectAdFrom.label" default="Select Ad From" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'selectAdFrom', 'errors')}">
                                    <g:textField name="selectAdFrom" value="${plannerEntryInstance?.selectAdFrom}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="selectedAdUrl"><g:message code="plannerEntry.selectedAdUrl.label" default="Selected Ad Url" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'selectedAdUrl', 'errors')}">
                                    <g:textField name="selectedAdUrl" value="${plannerEntryInstance?.selectedAdUrl}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="selfNotes"><g:message code="plannerEntry.selfNotes.label" default="Self Notes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'selfNotes', 'errors')}">
                                    <g:textField name="selfNotes" value="${plannerEntryInstance?.selfNotes}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="vendorNotes"><g:message code="plannerEntry.vendorNotes.label" default="Vendor Notes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'vendorNotes', 'errors')}">
                                    <g:textField name="vendorNotes" value="${plannerEntryInstance?.vendorNotes}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="business"><g:message code="plannerEntry.business.label" default="Business" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'business', 'errors')}">
                                    <g:select name="business.id" from="${com.itda.Business.list()}" optionKey="id" value="${plannerEntryInstance?.business?.id}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="includeVendorNotes"><g:message code="plannerEntry.includeVendorNotes.label" default="Include Vendor Notes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'includeVendorNotes', 'errors')}">
                                    <g:checkBox name="includeVendorNotes" value="${plannerEntryInstance?.includeVendorNotes}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="includeImage"><g:message code="plannerEntry.includeImage.label" default="Include Image" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'includeImage', 'errors')}">
                                    <g:checkBox name="includeImage" value="${plannerEntryInstance?.includeImage}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="includeLink"><g:message code="plannerEntry.includeLink.label" default="Include Link" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: plannerEntryInstance, field: 'includeLink', 'errors')}">
                                    <g:checkBox name="includeLink" value="${plannerEntryInstance?.includeLink}" />
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
