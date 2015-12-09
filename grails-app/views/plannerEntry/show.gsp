
<%@ page import="com.itda.PlannerEntry" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'plannerEntry.label', default: 'PlannerEntry')}" />
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
                            <td valign="top" class="name"><g:message code="plannerEntry.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.start.label" default="Start" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${plannerEntryInstance?.start}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.end.label" default="End" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${plannerEntryInstance?.end}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.className.label" default="Class Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "className")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.title.label" default="Title" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "title")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.size.label" default="Size" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "size")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.color.label" default="Color" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "color")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.deadline.label" default="Deadline" /></td>
                            
                            <td valign="top" class="value"><g:formatDate date="${plannerEntryInstance?.deadline}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.selectAdFrom.label" default="Select Ad From" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "selectAdFrom")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.selectedAdUrl.label" default="Selected Ad Url" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "selectedAdUrl")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.selfNotes.label" default="Self Notes" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "selfNotes")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.vendorNotes.label" default="Vendor Notes" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "vendorNotes")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.todos.label" default="Todos" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${plannerEntryInstance.todos}" var="t">
                                    <li><g:link controller="plannerTodo" action="show" id="${t.id}">${t?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.repeatDates.label" default="Repeat Dates" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: plannerEntryInstance, field: "repeatDates")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.business.label" default="Business" /></td>
                            
                            <td valign="top" class="value"><g:link controller="business" action="show" id="${plannerEntryInstance?.business?.id}">${plannerEntryInstance?.business?.encodeAsHTML()}</g:link></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.includeVendorNotes.label" default="Include Vendor Notes" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${plannerEntryInstance?.includeVendorNotes}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.includeImage.label" default="Include Image" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${plannerEntryInstance?.includeImage}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.includeLink.label" default="Include Link" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${plannerEntryInstance?.includeLink}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.offices.label" default="Offices" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${plannerEntryInstance.offices}" var="o">
                                    <li><g:link controller="office" action="show" id="${o.id}">${o?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="plannerEntry.vendors.label" default="Vendors" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${plannerEntryInstance.vendors}" var="v">
                                    <li><g:link controller="vendor" action="show" id="${v.id}">${v?.encodeAsHTML()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${plannerEntryInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
