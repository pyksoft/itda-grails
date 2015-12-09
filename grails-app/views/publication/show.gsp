
<%@ page import="com.itda.Publication" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'publication.label', default: 'Publication')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
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
                            <td valign="top" class="name"><g:message code="publication.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.newspaperOrPublicationName.label" default="Newspaper Or Publication Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "newspaperOrPublicationName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.publicationPhone.label" default="Publication Phone" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "publicationPhone")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.contactName.label" default="Contact Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "contactName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.contactPhone.label" default="Contact Phone" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "contactPhone")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.alternateEmail.label" default="Alternate Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "alternateEmail")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.addressLine1.label" default="Address Line1" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "addressLine1")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.city.label" default="City" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "city")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.state.label" default="State" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "state")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.zipcode.label" default="Zipcode" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: publicationInstance, field: "zipcode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="publication.business.label" default="Business" /></td>
                            
                            <td valign="top" class="value"><g:link controller="business" action="show" id="${publicationInstance?.business?.id}">${publicationInstance?.business?.businessName}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${publicationInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
