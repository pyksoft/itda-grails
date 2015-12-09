
<%@ page import="com.itda.AdvertisingZipcode" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'advertisingZipcode.label', default: 'AdvertisingZipcode')}" />
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
                        
                            <g:sortableColumn property="id" title="${message(code: 'advertisingZipcode.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="zipcode" title="${message(code: 'advertisingZipcode.zipcode.label', default: 'Zipcode')}" />
                        
                            <th><g:message code="advertisingZipcode.office.label" default="Office" /></th>
                   	    
                            <g:sortableColumn property="lon" title="${message(code: 'advertisingZipcode.lon.label', default: 'Lon')}" />
                        
                            <g:sortableColumn property="lastUpdated" title="${message(code: 'advertisingZipcode.lastUpdated.label', default: 'Last Updated')}" />
                        
                            <g:sortableColumn property="dateCreated" title="${message(code: 'advertisingZipcode.dateCreated.label', default: 'Date Created')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${advertisingZipcodeInstanceList}" status="i" var="advertisingZipcodeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${advertisingZipcodeInstance.id}">${fieldValue(bean: advertisingZipcodeInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: advertisingZipcodeInstance, field: "zipcode")}</td>
                        
                            <td>${fieldValue(bean: advertisingZipcodeInstance, field: "office")}</td>
                        
                            <td>${fieldValue(bean: advertisingZipcodeInstance, field: "lon")}</td>
                        
                            <td><g:formatDate date="${advertisingZipcodeInstance.lastUpdated}" /></td>
                        
                            <td><g:formatDate date="${advertisingZipcodeInstance.dateCreated}" /></td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${advertisingZipcodeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
