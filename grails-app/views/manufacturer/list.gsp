
<%@ page import="com.itda.Manufacturer" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'manufacturer.label', default: 'Manufacturer')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table width="100%">
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'manufacturer.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="manufacturerName" title="${message(code: 'manufacturer.manufacturerName.label', default: 'Manufacturer Name')}" />
                        
                            <g:sortableColumn property="phone" title="${message(code: 'manufacturer.phone.label', default: 'Phone')}" />
                        
                            <g:sortableColumn property="contactName" title="${message(code: 'manufacturer.contactName.label', default: 'Contact Name')}" />
                        
                            <g:sortableColumn property="contactPhone" title="${message(code: 'manufacturer.contactPhone.label', default: 'Contact Phone')}" />
                        
                            <g:sortableColumn property="email" title="${message(code: 'manufacturer.email.label', default: 'Email')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${manufacturerInstanceList}" status="i" var="manufacturerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${manufacturerInstance.id}">${fieldValue(bean: manufacturerInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: manufacturerInstance, field: "manufacturerName")}</td>
                        
                            <td>${fieldValue(bean: manufacturerInstance, field: "phone")}</td>
                        
                            <td>${fieldValue(bean: manufacturerInstance, field: "contactName")}</td>
                        
                            <td>${fieldValue(bean: manufacturerInstance, field: "contactPhone")}</td>
                        
                            <td>${fieldValue(bean: manufacturerInstance, field: "email")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${manufacturerInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
