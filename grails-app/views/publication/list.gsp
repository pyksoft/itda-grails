
<%@ page import="com.itda.Publication" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'publication.label', default: 'Publication')}" />
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
                <table width='100%'>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'publication.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="newspaperOrPublicationName" title="${message(code: 'publication.newspaperOrPublicationName.label', default: 'Newspaper Or Publication Name')}" />
                        
                            <g:sortableColumn property="publicationPhone" title="${message(code: 'publication.publicationPhone.label', default: 'Publication Phone')}" />
                        
                            <g:sortableColumn property="contactName" title="${message(code: 'publication.contactName.label', default: 'Contact Name')}" />
                        
                            <g:sortableColumn property="contactPhone" title="${message(code: 'publication.contactPhone.label', default: 'Contact Phone')}" />
                        
                            <g:sortableColumn property="email" title="${message(code: 'publication.email.label', default: 'Email')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${publicationInstanceList}" status="i" var="publicationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${publicationInstance.id}">${fieldValue(bean: publicationInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: publicationInstance, field: "newspaperOrPublicationName")}</td>
                        
                            <td>${fieldValue(bean: publicationInstance, field: "publicationPhone")}</td>
                        
                            <td>${fieldValue(bean: publicationInstance, field: "contactName")}</td>
                        
                            <td>${fieldValue(bean: publicationInstance, field: "contactPhone")}</td>
                        
                            <td>${fieldValue(bean: publicationInstance, field: "email")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${publicationInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
