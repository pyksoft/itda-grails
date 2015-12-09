
<%@ page import="com.itda.admin.ManufacturerPromoCode" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'manufacturerPromoCode.label', default: 'ManufacturerPromoCode')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${manufacturerPromoCodeInstance}">
            <div class="errors">
                <g:renderErrors bean="${manufacturerPromoCodeInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="promoCode"><g:message code="manufacturerPromoCode.promoCode.label" default="Promo Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerPromoCodeInstance, field: 'promoCode', 'errors')}">
                                    <g:textField name="promoCode" value="${manufacturerPromoCodeInstance?.promoCode}" />
                                </td>
                            </tr>
                                                
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="manufacturer"><g:message code="manufacturerPromoCode.manufacturer.label" default="Manufacturer" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: manufacturerPromoCodeInstance, field: 'manufacturer', 'errors')}">
                                    <g:textField name="manufacturer" value="${manufacturerPromoCodeInstance?.manufacturer}" />
                                </td>
                            </tr>
                        
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
