
<%@ page import="com.itda.Portfolio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'portfolio.label', default: 'Portfolio')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Date</td>
                            <td valign="top" class="value"><g:formatDate format="MMM yyyy" date="${portfolioInstance.portfolioDate}"/></td>
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
                            <td valign="top" class="name">Description</td>
                            <td valign="top" class="value">${fieldValue(bean: portfolioInstance, field: "description")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Processing State</td>
                            <td valign="top" class="value">${fieldValue(bean: portfolioInstance, field: "state")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Cover Page Image</td>
                            <td valign="top" class="value"><g:if test="${portfolioInstance.coverPageImage}">
                                    ${portfolioInstance.coverPageImage}
                            	</g:if>
                            	<g:else>
                            	   <g:link action="uploadCoverPageImage" id="${portfolioInstance.id}">Upload Image</g:link>
                            	</g:else></td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><label>Spine Image</label></td>
                            <td valign="top" class="value">
                            <g:if test="${portfolioInstance.spineImage}">
                                    ${portfolioInstance.spineImage}
                            	</g:if>
                            	<g:else>
                            	   <g:link action="uploadSpineImage" id="${portfolioInstance.id}">Upload Image</g:link>
                            	</g:else>
                            </td>
                        </tr>

                        <tr class="prop">
                            <td valign="top" class="name">Back Page Image</td>
                            <td valign="top" class="value">
                                <g:if test="${portfolioInstance.backPageImage}">
                                    ${portfolioInstance.backPageImage}
                            	</g:if>
                            	<g:else>
                            	   <g:link action="uploadBackPageImage" id="${portfolioInstance.id}">Upload Image</g:link>
                            	</g:else>
                            </td>
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
