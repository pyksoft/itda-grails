
<%@ page import="com.itda.Office" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'office.label', default: 'Office')}" />
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
                            <g:sortableColumn property="name" title="${message(code: 'office.name.label', default: 'Office Name')}" />
                            <th>Business Name</th>
                            <g:sortableColumn property="monthlySubscriptionPrice" title="Subscription Price" />
                            <g:sortableColumn property="availability" title="Availability" />
                            <g:sortableColumn property="city" title="${message(code: 'office.city.label', default: 'City')}" />
                            <g:sortableColumn property="state" title="${message(code: 'office.state.label', default: 'State')}" />
                            <g:sortableColumn property="zipcode" title="${message(code: 'office.zipcode.label', default: 'Zip Code')}" />
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${officeInstanceList}" status="i" var="officeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${officeInstance.id}">${fieldValue(bean: officeInstance, field: "name")}</g:link></td>
                            <td>${officeInstance?.business?.businessName}</td>
                            <td>${fieldValue(bean: officeInstance, field: "monthlySubscriptionPrice")}</td>
                            <td>${fieldValue(bean: officeInstance, field: "availability")}</td>
                            <td>${fieldValue(bean: officeInstance, field: "city")}</td>                        
                            <td>${fieldValue(bean: officeInstance, field: "state")}</td>
                            <td>${fieldValue(bean: officeInstance, field: "zipcode")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${officeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
