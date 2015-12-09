
<%@ page import="com.itda.Portfolio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'portfolio.label', default: 'Portfolio')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${portfolioInstance}">
            <div class="errors">
                <g:renderErrors bean="${portfolioInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${portfolioInstance?.id}" />
                <g:hiddenField name="version" value="${portfolioInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        <tr class="prop">
                            <td valign="top" class="name">Date</td>
                            <td valign="top" class="value"><g:formatDate format="MMM yyyy" date="${portfolioInstance.portfolioDate}"/></td>
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Description</td>
                            <td valign="top" class="value"><input type='text' name='description' value='${portfolioInstance.description}' maxlength='30' length='100'/></td>
                        </tr>
                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label>Manufacturer Promo Code</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'promoCode', 'errors')}">
                                    <g:select name="promoCode"  noSelection="${['':'Select One...']}" from="${promoCodes}" value="${portfolioInstance?.promoCode}" optionKey="value" optionValue="value"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Status
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${portfolioInstance.constraints.status.inList}" value="${portfolioInstance?.status}" valueMessagePrefix="portfolio.status"  />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Processing State
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'status', 'errors')}">
                                    <g:select name="state" from="${[portfolioInstance?.state]}" value="${portfolioInstance?.state}" valueMessagePrefix="portfolio.state"  readonly="true"/>
                                </td>
                            </tr>                       
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Cover Page Image
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'coverPageImage', 'errors')}">
                                    <g:textArea name="coverPageImage" cols="40" rows="5" value="${portfolioInstance?.coverPageImage}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Spine Image"
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'spineImage', 'errors')}">
                                    <g:textArea name="spineImage" cols="40" rows="5" value="${portfolioInstance?.spineImage}" />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Back Page Image"
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'backPageImage', 'errors')}">
                                    <g:textArea name="backPageImage" cols="40" rows="5" value="${portfolioInstance?.backPageImage}" />
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  Upload Zip Name
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'uploadZipName', 'errors')}">
                                    <g:textField name="uploadZipName" value="${portfolioInstance?.uploadZipName}" readonly="true"/>
                                </td>
                            </tr>                      
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
