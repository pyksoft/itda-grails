
<%@ page import="com.itda.PortfolioEntry" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'portfolioEntry.label', default: 'PortfolioEntry')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list" params='[portfolioId:portfolioEntryInstance?.portfolio?.id]'><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create" params='[portfolioId:portfolioEntryInstance?.portfolio?.id]'><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="dialog">
               <div style='float:right'><img src='/archive/getJpg/${portfolioEntryInstance.id}?color=${portfolioEntryInstance.color}' style='max-width:300px;max-height:400px'></img></div>
                <table>
                    <tbody>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Portfolio Date</td>
                            
                            <td valign="top" class="value"><g:formatDate format="MMMM yyyy" date="${portfolioEntryInstance?.portfolioDate}" /></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="portfolioEntry.enable.label" default="Enable" /></td>
                            
                            <td valign="top" class="value"><g:formatBoolean boolean="${portfolioEntryInstance?.enable}" /></td>
                            
                        </tr>
                                <td valign="top" class="name">
                                  <label>Promo Code</label>
                                </td>
                            	<td valign="top" class="value">${portfolioEntryInstance?.promoCode}</td>
                            </tr>                        
                       
                        <g:if test="${ portfolioEntryInstance.imageFile == portfolioEntryInstance.UNKNOWN|| portfolioEntryInstance.pdfFile == portfolioEntryInstance.UNKNOWN}">
                        <tr class="prop">
                            <td valign="top" class="name">File Path</td>
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "unparsableFile")}</td>
                        </tr>
                        </g:if>                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="portfolioEntry.adTypeCode.label" default="Ad Type Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "adTypeCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="portfolioEntry.adSizeCode.label" default="Ad Size Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "adSizeCode")}</td>
                            
                        </tr>
                    
                   			<tr class="prop">
                                <td valign="top" class="name">
                                  <label>Color</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'color', 'errors')}">
                                    ${portfolioEntryInstance?.color}
                                </td>
                            </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="portfolioEntry.offerCode.label" default="Offer Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "offerCode")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name">Ad Tab Number</td>
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "adTabNumber")}</td>
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="portfolioEntry.adPageNumber.label" default="Ad Page Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "adPageNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="portfolioEntry.adDescription.label" default="Ad Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "adDescription")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Detail</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "details")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">Image File</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "imageFile")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name">PDF File</td>
                            
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "pdfFile")}</td>
                            
                        </tr>
<%-- elements --%>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="anatomy">Element</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:checkBox name="anatomy" value="${portfolioEntryInstance?.anatomy}" /> Anatomy image
                                    <br/><g:checkBox name="product" value="${portfolioEntryInstance?.product}" /> Product image
                                    <br/><g:checkBox name="patient" value="${portfolioEntryInstance?.patient}" /> Patient photo
                                    <br/><g:checkBox name="dispenser" value="${portfolioEntryInstance?.dispenser}" /> Dispenser photo
                                    <br/><g:checkBox name="map" value="${portfolioEntryInstance?.map}" /> Map
                                    <br/><g:checkBox id="cal2" name="calendar" value="${portfolioEntryInstance?.calendar}" /> Calendar
                                    <br/><g:checkBox name="testing" value="${portfolioEntryInstance?.testing}" /> Testing photos
                                    <br/><g:checkBox name="coupons" value="${portfolioEntryInstance?.coupons}" /> Coupons
                                    <br/><g:checkBox name="policies" value="${portfolioEntryInstance?.policies}" /> Policies
                                    <br/><g:checkBox name="company" value="${portfolioEntryInstance?.company}" /> Company Logo
                                    <br/><g:checkBox name="address" value="${portfolioEntryInstance?.address}" /> Address 
                                    <br/><g:checkBox name="phone" value="${portfolioEntryInstance?.phone}" /> Phone Number
                                </td>
                            </tr>
                         
<%-- focus --%>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="testimonial">Focus</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:checkBox name="testimonial" value="${portfolioEntryInstance?.testimonial}" /> Testimonial
                                    <br/><g:checkBox name="sale" value="${portfolioEntryInstance?.sale}" /> Sale
                                    <br/><g:checkBox name="trial" value="${portfolioEntryInstance?.trial}" /> Trial
                                    <br/><g:checkBox name="event" value="${portfolioEntryInstance?.event}" /> Event
                                    <br/><g:checkBox name="seminar" value="${portfolioEntryInstance?.seminar}" /> Seminar
                                    <br/><g:checkBox name="advertorial" value="${portfolioEntryInstance?.advertorial}" /> Advertorial
                                    <br/><g:checkBox name="features" value="${portfolioEntryInstance?.features}" /> Product features
                                    <br/><g:checkBox name="benefits" value="${portfolioEntryInstance?.benefits}" /> Product benefits
                                    <br/><g:checkBox name="upgrade" value="${portfolioEntryInstance?.upgrade}" /> Upgrade
                                    <br/><g:checkBox name="tinnitus" value="${portfolioEntryInstance?.tinnitus}" /> Tinnitus
                                    <br/><g:checkBox name="notice" value="${portfolioEntryInstance?.notice}" /> Public notice
                                    <br/><g:checkBox name="opening" value="${portfolioEntryInstance?.opening}" /> Grand opening
                                    <br/><g:checkBox name="hearingTest" value="${portfolioEntryInstance?.hearingTest}" /> Free hearing test
                                    <br/><g:checkBox name="consultDemo" value="${portfolioEntryInstance?.consultDemo}" /> Free consultation/demonstration
                                    <br/><g:checkBox name="endorsement" value="${portfolioEntryInstance?.endorsement}" /> Endorsement
                                    <br/><g:checkBox name="technology" value="${portfolioEntryInstance?.technology}" /> Technology Study
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="thanksgiving">Time Of Year</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'thanksgiving', 'errors')}">
                                    <g:checkBox name="thanksgiving" value="${portfolioEntryInstance?.thanksgiving}" /> Thanksgiving
                                    <br/><g:checkBox name="christmas" value="${portfolioEntryInstance?.christmas}" /> Christmas
                                    <br/><g:checkBox name="newYear" value="${portfolioEntryInstance?.newYear}" /> New Year's
                                    <br/><g:checkBox name="valentine" value="${portfolioEntryInstance?.valentine}" />Valentines day
                                    <br/><g:checkBox name="president" value="${portfolioEntryInstance?.president}" />President's day
                                    <br/><g:checkBox name="july4" value="${portfolioEntryInstance?.july4}" /> 4th of July
                                    <br/><g:checkBox name="fall" value="${portfolioEntryInstance?.fall}" /> Fall
                                    <br/><g:checkBox name="spring" value="${portfolioEntryInstance?.spring}" /> Spring
                                    <br/><g:checkBox name="summer" value="${portfolioEntryInstance?.summer}" /> Summer
                                    <br/><g:checkBox name="winter" value="${portfolioEntryInstance?.winter}" /> Winter
                                </td>
                            </tr>                       
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${portfolioEntryInstance?.id}" />
                    <g:hiddenField name="portfolioId" value="${portfolioEntryInstance?.portfolio?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
