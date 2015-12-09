<%@ page import="com.itda.Portfolio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'portfolio.label', default: 'Portfolio')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create" ><g:message code="default.new.label" args="[entityName]" /></g:link></span>
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
                        
                            <g:sortableColumn property="portfolioDate" title="Date" />
                            <g:sortableColumn property="status" title="Status" />
                            <g:sortableColumn property="state" title="Processing State" />
                            <g:sortableColumn property="coverPageImage" title="Cover Page Image" />
                            <g:sortableColumn property="spineImage" title="Spine Image" />
                            <g:sortableColumn property="backPageImage" title="Back Page Image" />
                            <g:sortableColumn property="uploadZipName" title="Content File(Zip)" />
                        	<th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${portfolioInstanceList}" status="i" var="portfolioInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${portfolioInstance.id}"><g:formatDate format="MMM yyyy" date="${portfolioInstance.portfolioDate}" /></g:link></td>
                            <td>${fieldValue(bean: portfolioInstance, field: "status")}</td>
                            <td>${fieldValue(bean: portfolioInstance, field: "state")}</td>
                            <td><g:if test="${portfolioInstance.coverPageImage}">
                                    ${portfolioInstance.coverPageImage}
                            	</g:if>
                            	<g:else>
                            	   <g:link action="uploadCoverPageImage" id="${portfolioInstance.id}">Upload Image</g:link>
                            	</g:else>
                            </td>
                            <td><g:if test="${portfolioInstance.spineImage}">
                                    ${portfolioInstance.spineImage}
                            	</g:if>
                            	<g:else>
                            	   <g:link action="uploadSpineImage" id="${portfolioInstance.id}">Upload Image</g:link>
                            	</g:else>
                            </td>
                            <td><g:if test="${portfolioInstance.backPageImage}">
                                    ${portfolioInstance.backPageImage}
                            	</g:if>
                            	<g:else>
                            	   <g:link action="uploadBackPageImage" id="${portfolioInstance.id}">Upload Image</g:link>
                            	</g:else>
                            </td>
                            <td><g:if test="${portfolioInstance.uploadZipName}">
                                    ${portfolioInstance.uploadZipName}
                            	</g:if>
                            	<g:else>
                            	   <g:link action="uploadZipContent" id="${portfolioInstance.id}">Upload Zip</g:link>
                            	</g:else>
                            </td>
                            <td>
                            	<g:if test='${portfolioInstance.state != "Created"}'>
	                           		<g:link controller='portfolioEntry' action="listPortfolioEntries" params='[portfolioId:portfolioInstance.id]'>View Portfolio Entries </g:link> |
                            	</g:if>
                            	<g:if test='${portfolioInstance.state == "Uploaded"}'>
                            		<g:link action="loadPortfolio" id="${portfolioInstance.id}">Process Uploaded File</g:link>
                            	</g:if>
                            	<g:if test='${portfolioInstance.state == "Ready"}'>
                            		<g:link controller='myPortfolio' action="current" id="${portfolioInstance.id}">Show Portfolio</g:link>
                            	</g:if>                            	
                            </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${portfolioInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
