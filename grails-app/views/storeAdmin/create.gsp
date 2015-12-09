
<%@ page import="com.itda.Portfolio" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <g:set var="entityName" value="${message(code: 'portfolio.label', default: 'Portfolio')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
        <meta name="layout" content="main" />
    </head>
    <body>    
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1>Create Ad Collection</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${portfolioInstance}">
            <div class="errors">
                <g:renderErrors bean="${portfolioInstance}" as="list" />
            </div>
            </g:hasErrors>
    <div id="content">
       	<form id="form1" action="/storeAdmin/save" method="post" enctype="multipart/form-data">
                <div class="dialog">
                    <table>
                        <tbody>
                        
<%--                             <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="portfolioDate"><g:message code="portfolio.portfolioDate.label" default="Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'portfolioDate', 'errors')}">
                                	<% def date =  new GregorianCalendar()%>
                                    <g:datePicker name="portfolioDate" value="${portfolioInstance.portfolioDate ? portfolioInstance.portfolioDate: date}" precision="month" years="${[date.get(Calendar.YEAR),date.get(Calendar.YEAR)+1]}"/>
                                </td>
                            </tr>
--%>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label>Collection Name</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'description', 'errors')}">
                                    <input type='text' name='description' value='${portfolioInstance.description}' maxlength='256' length='100'/>
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label>Manufacturer Promo Code</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'promoCode', 'errors')}">
                                    <g:select name="promoCode"  noSelection="${['':'Select One...']}" from="${manufacturerCodes}" value="${portfolioInstance?.promoCode}" 
                                    		 optionKey="value" optionValue="value" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label>Status</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${portfolioInstance.constraints.status.inList}" value="${portfolioInstance?.status}" valueMessagePrefix="portfolio.status"  />
                                </td>
                            </tr>
                            
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button">
                    <input type="submit" class="save" name="create" value="Create" id="btnSubmit" />
                    </span>
                </div>
            </form>
	</div>
        </div>
    </body>
</html>
