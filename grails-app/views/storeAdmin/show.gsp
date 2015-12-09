
<%@ page import="com.itda.Portfolio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Show Ad Collection</title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list">List Ad Collections</g:link></span>
            <span class="menuButton"><g:link class="create" action="create">New Ad Collection</g:link></span>
        </div>
        <div class="body">
            <h1>Show Ad Collection</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Collection Name</td>
                            <td valign="top" class="value">${fieldValue(bean: portfolioInstance, field: "description")}</td>
                        </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    Manufacturer Promo Code
                                </td>
                                <td valign="top" class="value">
                                    ${portfolioInstance?.promoCode}
                                </td>
                            </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="portfolio.status.label" default="Status" /></td>
                            <td valign="top" class="value">${fieldValue(bean: portfolioInstance, field: "status")}</td>
                        </tr>
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name">Processing State</td>
                            <td valign="top" class="value">${fieldValue(bean: portfolioInstance, field: "state")}</td>
                        </tr>
                    
                    
                    
                        <tr class="prop">
                            <td valign="top" class="name">Upload Zip Name</td>
                            <td valign="top" class="value">
                                <g:if test="${portfolioInstance.uploadZipName}">
                                    ${portfolioInstance.uploadZipName}
                            	</g:if>
                            	<g:else>
                            	   <g:link action="uploadZipContent" id="${portfolioInstance.id}">Upload Zip</g:link>
                            	</g:else>
                            
                            </td>
                        </tr>
                    
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${portfolioInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
