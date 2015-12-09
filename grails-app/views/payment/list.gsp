
<%@ page import="com.itda.Payment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <META HTTP-EQUIV="REFRESH" CONTENT="2">
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'payment.label', default: 'Payment')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table width="100%">
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'payment.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="firstName" title="${message(code: 'payment.firstName.label', default: 'First Name')}" />
                        
                            <g:sortableColumn property="lastName" title="${message(code: 'payment.lastName.label', default: 'Last Name')}" />
                        
                            <g:sortableColumn property="cardNumber" title="${message(code: 'payment.cardNumber.label', default: 'Card Number')}" />
                        
                            <g:sortableColumn property="expireMonth" title="${message(code: 'payment.expireMonth.label', default: 'Expire Month')}" />
                        
                            <g:sortableColumn property="expireYear" title="${message(code: 'payment.expireYear.label', default: 'Expire Year')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${paymentInstanceList}" status="i" var="paymentInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${paymentInstance.id}">${fieldValue(bean: paymentInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: paymentInstance, field: "firstName")}</td>
                        
                            <td>${fieldValue(bean: paymentInstance, field: "lastName")}</td>
                        
                            <td>${fieldValue(bean: paymentInstance, field: "cardNumber")}</td>
                        
                            <td>${fieldValue(bean: paymentInstance, field: "expireMonth")}</td>
                        
                            <td>${fieldValue(bean: paymentInstance, field: "expireYear")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${paymentInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
