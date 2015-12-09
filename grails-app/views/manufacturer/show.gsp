
<%@ page import="com.itda.Manufacturer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'manufacturer.label', default: 'Manufacturer')}" />
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
                            <td valign="top" class="name"><g:message code="manufacturer.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.manufacturerName.label" default="Manufacturer Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "manufacturerName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.phone.label" default="Phone" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "phone")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.contactName.label" default="Contact Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "contactName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.contactPhone.label" default="Contact Phone" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "contactPhone")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.alternateEmail.label" default="Alternate Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "alternateEmail")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.address.label" default="Address" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "address")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.city.label" default="City" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "city")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.state.label" default="State" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "state")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.zipcode.label" default="Zipcode" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: manufacturerInstance, field: "zipcode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="manufacturer.business.label" default="Business" /></td>
                            
                            <td valign="top" class="value"><g:link controller="business" action="show" id="${manufacturerInstance?.business?.id}">${manufacturerInstance?.business?.businessName}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${manufacturerInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
