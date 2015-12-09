
<%@ page import="com.itda.admin.ItdaAttribute" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'itdaAttribute.label', default: 'ItdaAttribute')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'itdaAttribute.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'itdaAttribute.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="value" title="${message(code: 'itdaAttribute.value.label', default: 'Value')}" />
                        
                            <g:sortableColumn property="displayOrder" title="${message(code: 'itdaAttribute.displayOrder.label', default: 'Display Order')}" />
                        
                            <g:sortableColumn property="enabled" title="${message(code: 'itdaAttribute.enabled.label', default: 'Enabled')}" />
                        
                            <g:sortableColumn property="shortLabel" title="${message(code: 'itdaAttribute.shortLabel.label', default: 'Short Label')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${itdaAttributeInstanceList}" status="i" var="itdaAttributeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${itdaAttributeInstance.id}">${fieldValue(bean: itdaAttributeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: itdaAttributeInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: itdaAttributeInstance, field: "value")}</td>
                        
                            <td>${fieldValue(bean: itdaAttributeInstance, field: "displayOrder")}</td>
                        
                            <td><g:formatBoolean boolean="${itdaAttributeInstance.enabled}" /></td>
                        
                            <td>${fieldValue(bean: itdaAttributeInstance, field: "shortLabel")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${itdaAttributeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
