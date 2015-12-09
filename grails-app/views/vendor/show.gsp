
<%@ page import="com.itda.Vendor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'vendor.label', default: 'Vendor')}" />
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
                            <td valign="top" class="name"><g:message code="vendor.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.vendorName.label" default="Vendor Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "vendorName")}</td>
                            
                        </tr>
                                        
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.contactName.label" default="Contact Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "contactName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.contactPhone.label" default="Contact Phone" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "contactPhone")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.alternateEmail.label" default="Alternate Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "alternateEmail")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.address.label" default="Address" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "address")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.city.label" default="City" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "city")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.state.label" default="State" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "state")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.zipcode.label" default="Zipcode" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: vendorInstance, field: "zipcode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="vendor.business.label" default="Business" /></td>
                            
                            <td valign="top" class="value"><g:link controller="business" action="show" id="${vendorInstance?.business?.id}">${vendorInstance?.business?.businessName}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${vendorInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
