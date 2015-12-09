<%@ page import="com.itda.PortfolioEntry" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="/css/main.css" />
<link rel="stylesheet" href="/css/itda.css" />
        <g:set var="entityName" value="${message(code: 'portfolioEntry.label', default: 'PortfolioEntry')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
	<body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton">
<%--             
            <g:link class="create" action="create" params='[portfolioId:params.portfolioId]'><g:message code="default.new.label" args="[entityName]" /></g:link>
            | <g:link class="create" action="uploadPdf" params='[portfolioId:params.portfolioId]'>Upload PDF File</g:link> 
            | <g:link class="create" action="uploadJpg" params='[portfolioId:params.portfolioId]'>Upload JPG File</g:link>
--%>            </span>
        </div>
        
        <div >
            <h1>Collection Entries</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list" style='/*position:absolute;left:0px*/'>
                <table width="100%" >
                    <thead>
                        <tr>
                         	<th>ID</th>
                         	<%-- <th>Portfolio Date</th> --%>
                         	<th>Enable&nbsp;</th>
                         	<th>&nbsp;Type&nbsp;&nbsp;
                         		<br/>&nbsp;Size&nbsp;&nbsp;
                         		<br/>&nbsp;Color&nbsp;&nbsp;</th>
                         	<th>Offer&nbsp;&nbsp;</th>
                         	<th>Description&nbsp;</th>
                         	<th>Details&nbsp;&nbsp;</th>
                         	<th>Image&nbsp;file
                         	<br/>PDF&nbsp;file</th>
                         	   
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${portfolioEntryInstanceList}" status="i" var="portfolioEntryInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="showAdEntry" id="${portfolioEntryInstance.id}">${fieldValue(bean: portfolioEntryInstance, field: "id")}</g:link></td>
                        
                           <%-- <td><g:formatDate date="${portfolioEntryInstance.portfolioDate}" format="MMM yyyy" /></td>--%>
                        
                            <td><g:formatBoolean boolean="${portfolioEntryInstance.enable}" /></td>
                        
                            <td>${fieldValue(bean: portfolioEntryInstance, field: "adTypeCode")}
                            <br/><img style="padding-top: 5px;" src="/images/Transparent.gif"/>
                            <br/>${fieldValue(bean: portfolioEntryInstance, field: "adSizeCode")}
                            <br/><img style="padding-top: 5px;" src="/images/Transparent.gif"/>
                            <br/>${fieldValue(bean: portfolioEntryInstance, field: "color")}</td>
                            <td>${fieldValue(bean: portfolioEntryInstance, field: "offerCode")}</td>
                            <td>${fieldValue(bean: portfolioEntryInstance, field: "adDescription")}</td>
                            <td>${fieldValue(bean: portfolioEntryInstance, field: "details")}</td>
                            
                            <td>${fieldValue(bean: portfolioEntryInstance, field: "imageFile")}
                            <br/><img style="padding: 5px 0px" src="/images/Transparent.gif"/>
                            <br/>${fieldValue(bean: portfolioEntryInstance, field: "pdfFile")}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
