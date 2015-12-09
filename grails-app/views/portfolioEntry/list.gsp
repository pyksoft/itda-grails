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
            <g:link class="create" action="create" params='[portfolioId:params.portfolioId]'><g:message code="default.new.label" args="[entityName]" /></g:link>
            | <g:link class="create" action="uploadPdf" params='[portfolioId:params.portfolioId]'>Upload PDF File</g:link> 
            | <g:link class="create" action="uploadJpg" params='[portfolioId:params.portfolioId]'>Upload JPG File</g:link>
            </span>
        </div>
        <div >
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list" style='/*position:absolute;left:0px*/'>
                <table width="100%" >
                    <thead>
                        <tr>
                        <%-- 
                            <g:sortableColumn params="${params}" property="id" title="${message(code: 'portfolioEntry.id.label', default: 'Id')}" />
                            <g:sortableColumn property="portfolioDate" title="${message(code: 'portfolioEntry.portfolioDate.label', default: 'Portfolio Date')}" />
                            <g:sortableColumn property="enable" title="${message(code: 'portfolioEntry.enable.label', default: 'Enable')}" />
                            <g:sortableColumn property="adTypeCode" title="${message(code: 'portfolioEntry.adTypeCode.label', default: 'Ad Type Code')}" />
                            <g:sortableColumn property="adSizeCode" title="${message(code: 'portfolioEntry.adSizeCode.label', default: 'Ad Size Code')}" />
                            <g:sortableColumn property="offerCode" title="${message(code: 'portfolioEntry.offerCode.label', default: 'Offer Code')}" />
                            <g:sortableColumn property="adTabNumber" title="Ad Tab Number" />
                            <g:sortableColumn property="adPageNumber" title="Ad Page Number" />
                            <g:sortableColumn property="adDescription" title="Ad Description" />
                            <g:sortableColumn property="fontInfo" title="Font Info" />
                            <g:sortableColumn property="dimensionInfo" title="Dimension Info" />
                            <g:sortableColumn property="c4ImageName" title="C4 Image Name" />
                            <g:sortableColumn property="c2ImageName" title="C2 Image Name" />
                            <g:sortableColumn property="c1ImageName" title="C1 Image Name" />
                            <g:sortableColumn property="c4PdfName" title="C4 Pdf Name" />
                            <g:sortableColumn property="c2PdfName" title="C2 Pdf Name" />
                            <g:sortableColumn property="c1PdfName" title="C1 Pdf Name" />
                            <g:sortableColumn property="unparsableFile" title="Unparsable File" />
                         --%>
                         	<th>ID</th>
                         	<%-- <th>Portfolio Date</th> --%>
                         	<th>Enable&nbsp;</th>
                         	<th>&nbsp;Type&nbsp;&nbsp;
                         		<br/>&nbsp;Size&nbsp;&nbsp;
                         		<br/>&nbsp;Color&nbsp;&nbsp;</th>
                         	<th>Tab&nbsp;&nbsp;<br/>#</th>                         		
                         	<th>Page&nbsp;&nbsp;<br/>order</th>                         		
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
                        
                            <td><g:link action="show" id="${portfolioEntryInstance.id}" params='[portfolioId:params.portfolioId]'>${fieldValue(bean: portfolioEntryInstance, field: "id")}</g:link></td>
                        
                           <%-- <td><g:formatDate date="${portfolioEntryInstance.portfolioDate}" format="MMM yyyy" /></td>--%>
                        
                            <td><g:formatBoolean boolean="${portfolioEntryInstance.enable}" /></td>
                        
                            <td>${fieldValue(bean: portfolioEntryInstance, field: "adTypeCode")}
                            <br/><img style="padding-top: 5px;" src="/images/Transparent.gif"/>
                            <br/>${fieldValue(bean: portfolioEntryInstance, field: "adSizeCode")}
                            <br/><img style="padding-top: 5px;" src="/images/Transparent.gif"/>
                            <br/>${fieldValue(bean: portfolioEntryInstance, field: "color")}</td>
                        	<td>${fieldValue(bean: portfolioEntryInstance, field: "adTabNumber")}</td>
                        	<td>${fieldValue(bean: portfolioEntryInstance, field: "adPageNumber")}</td>
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
            <div class="paginateButtons">
                <g:paginate  params='${[portfolioId:params.portfolioId]}' total="${portfolioEntryInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
