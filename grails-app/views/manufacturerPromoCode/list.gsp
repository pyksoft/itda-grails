
<%@ page import="com.itda.admin.ManufacturerPromoCode" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode')}" />
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
                            <g:sortableColumn property="promoCode" title="${message(code: 'manufacturerPromoCode.promoCode.label', default: 'Promo Code')}" />
                                                
                            <g:sortableColumn property="manufacturer" title="${message(code: 'manufacturerPromoCode.manufacturer.label', default: 'Manufacturer')}" />
                        
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${manufacturerPromoCodeInstanceList}" status="i" var="manufacturerPromoCodeInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${manufacturerPromoCodeInstance.promoCode}">${fieldValue(bean: manufacturerPromoCodeInstance, field: "promoCode")}</g:link></td>
                                    
                            <td>${fieldValue(bean: manufacturerPromoCodeInstance, field: "manufacturer")}</td>
                        
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${manufacturerPromoCodeInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
