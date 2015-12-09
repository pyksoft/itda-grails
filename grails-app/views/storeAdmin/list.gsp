<%@ page import="com.itda.Portfolio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <title>Ad Collections</title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="create" action="create" >New Ad Collection</g:link></span>
        </div>
        <div class="body">
            <h1>Ad Collections</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table width="100%">
                    <thead>
                        <tr>
                            <g:sortableColumn property="description" title="Collection Name" />
                            <g:sortableColumn property="status" title="Status" />
                            <g:sortableColumn property="state" title="Processing State" />
                            <g:sortableColumn property="uploadZipName" title="Content File(Zip)" />
                        	<th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${portfolioInstanceList}" status="i" var="portfolioInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${portfolioInstance.id}">${portfolioInstance?.description}</g:link></td>
                            <td>${fieldValue(bean: portfolioInstance, field: "status")}</td>
                            <td>${fieldValue(bean: portfolioInstance, field: "state")}</td>
                            <td><g:if test="${portfolioInstance.uploadZipName}">
                                    ${portfolioInstance.uploadZipName}
                            	</g:if>
                            	<g:else>
                            	   <g:link action="uploadZipContent" id="${portfolioInstance.id}">Upload Zip</g:link>
                            	</g:else>
                            </td>
                            <td>
                            	<g:if test='${portfolioInstance.state != "Created"}'>
	                           		<g:link class="list" action="listCollectionEntries" params='[collectionId:portfolioInstance.id]'>View Collection Entries </g:link> |
                            	</g:if>
                            	<g:if test='${portfolioInstance.state == "Uploaded"}'>
                            		<g:link action="loadPortfolio" id="${portfolioInstance.id}">Process Uploaded File</g:link>
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
