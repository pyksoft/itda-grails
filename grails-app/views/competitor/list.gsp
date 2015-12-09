
<%@ page import="com.itda.Competitor" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'competitor.label', default: 'Competitor')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'competitor.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="businessName" title="${message(code: 'competitor.businessName.label', default: 'Competitor Business Name')}" />
                        
                            <g:sortableColumn property="ownerName" title="${message(code: 'competitor.ownerName.label', default: 'Owner Name')}" />
                        
                            <g:sortableColumn property="address" title="${message(code: 'competitor.address.label', default: 'Address')}" />
                        
                            <g:sortableColumn property="city" title="${message(code: 'competitor.city.label', default: 'City')}" />
                        
                            <g:sortableColumn property="state" title="${message(code: 'competitor.state.label', default: 'State')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${competitorInstanceList}" status="i" var="competitorInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${competitorInstance.id}">${fieldValue(bean: competitorInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: competitorInstance, field: "businessName")}</td>
                        
                            <td>${fieldValue(bean: competitorInstance, field: "ownerName")}</td>
                        
                            <td>${fieldValue(bean: competitorInstance, field: "address")}</td>
                        
                            <td>${fieldValue(bean: competitorInstance, field: "city")}</td>
                        
                            <td>${fieldValue(bean: competitorInstance, field: "state")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${competitorInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
