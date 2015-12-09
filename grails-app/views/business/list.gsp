
<%@ page import="com.itda.Business" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'business.label', default: 'Business')}" />
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
                            <g:sortableColumn property="businessName" title="${message(code: 'business.businessName.label', default: 'Business Name')}" />
                            <g:sortableColumn property="representativeName" title="${message(code: 'business.representativeName.label', default: 'Representative Name')}" />
                            <g:sortableColumn property="email" title="${message(code: 'business.email.label', default: 'Email')}" />
                            <g:sortableColumn property="phone" title="${message(code: 'business.phone.label', default: 'Phone')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${businessInstanceList}" status="i" var="businessInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                            <td><g:link action="show" id="${businessInstance.id}">${fieldValue(bean: businessInstance, field: "businessName")}</g:link></td>
                            <td>${fieldValue(bean: businessInstance, field: "representativeName")}</td>
                            <td>${fieldValue(bean: businessInstance, field: "email")}</td>
                            <td>${fieldValue(bean: businessInstance, field: "phone")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${businessInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
