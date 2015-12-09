
<%@ page import="com.itda.Business" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'business.label', default: 'Business')}" />
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
                            <td valign="top" class="name"><g:message code="business.businessName.label" default="Business Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: businessInstance, field: "businessName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="business.representativeName.label" default="Representative Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: businessInstance, field: "representativeName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="business.email.label" default="Email" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: businessInstance, field: "email")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="business.phone.label" default="Phone" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: businessInstance, field: "phone")}</td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Notes</td>
                            
                            <td valign="top" class="value"><pre>${fieldValue(bean: businessInstance, field: "notes")}</pre></td>
                            
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="business.offices.label" default="Offices" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${businessInstance.offices}" var="o">
                                    <li><g:link controller="office" action="show" id="${o.id}">${o?.name}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="business.payments.label" default="Payments" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${businessInstance.payments}" var="p">
                                    <li><g:link controller="payment" action="show" id="${p.id}">${p?.cardNumberAsLast4String()} - $${p?.totalPriceAsString()}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="business.publications.label" default="Publications" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${businessInstance.publications}" var="p">
                                    <li><g:link controller="publication" action="show" id="${p.id}">${p?.newspaperOrPublicationName}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="business.vendors.label" default="Vendors" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${businessInstance.vendors}" var="v">
                                    <li><g:link controller="vendor" action="show" id="${v.id}">${v?.vendorName}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="business.manufacturers.label" default="Manufacturers" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${businessInstance.manufacturers}" var="m">
                                    <li><g:link controller="manufacturer" action="show" id="${m.id}">${ m?.manufacturerName}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="business.competitors.label" default="Competitors" /></td>
                            
                            <td valign="top" style="text-align: left;" class="value">
                                <ul>
                                <g:each in="${businessInstance.competitors}" var="c">
                                    <li><g:link controller="competitor" action="show" id="${c.id}">${c?.businessName}</g:link></li>
                                </g:each>
                                </ul>
                            </td>
                            
                        </tr>
                    
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${businessInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
