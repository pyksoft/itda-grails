
<%@ page import="com.itda.PlannerEntry" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'plannerEntry.label', default: 'PlannerEntry')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'plannerEntry.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="start" title="${message(code: 'plannerEntry.start.label', default: 'Start')}" />
                        
                            <g:sortableColumn property="end" title="${message(code: 'plannerEntry.end.label', default: 'End')}" />
                        
                            <g:sortableColumn property="className" title="${message(code: 'plannerEntry.className.label', default: 'Class Name')}" />
                        
                            <g:sortableColumn property="title" title="${message(code: 'plannerEntry.title.label', default: 'Title')}" />
                        
                            <g:sortableColumn property="size" title="${message(code: 'plannerEntry.size.label', default: 'Size')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${plannerEntryInstanceList}" status="i" var="plannerEntryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${plannerEntryInstance.id}">${fieldValue(bean: plannerEntryInstance, field: "id")}</g:link></td>
                        
                            <td><g:formatDate date="${plannerEntryInstance.start}" /></td>
                        
                            <td><g:formatDate date="${plannerEntryInstance.end}" /></td>
                        
                            <td>${fieldValue(bean: plannerEntryInstance, field: "className")}</td>
                        
                            <td>${fieldValue(bean: plannerEntryInstance, field: "title")}</td>
                        
                            <td>${fieldValue(bean: plannerEntryInstance, field: "size")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${plannerEntryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
