
<%@ page import="com.itda.PortfolioEntry" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="Ad Entry" />
        <title>Ad Entry</title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list">Collection List</g:link></span>
            <span class="menuButton"><g:link class="list" action="listCollectionEntries" params='[collectionId:portfolioEntryInstance?.portfolio?.id]'>Back to Collection</g:link></span>
            <%--
            <span class="menuButton"><g:link class="create" action="create" params='[collectionId:portfolioEntryInstance?.portfolio?.id]'>New Ad Entry</g:link></span>
             --%>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${portfolioEntryInstance}">
            <div class="errors">
                <g:renderErrors bean="${portfolioEntryInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${portfolioEntryInstance?.id}" />
                <g:hiddenField name="version" value="${portfolioEntryInstance?.version}" />
                <div class="dialog">
               <div style='float:right'><img src='/archive/getJpg/${portfolioEntryInstance.id}?color=${portfolioEntryInstance.color}' style='max-width:300px;max-height:400px'></img></div>
               <div style='float:left'>
                    <table width="100%">
                        <tbody>
                        
                        <g:if test="${!portfolioEntryInstance.enable && portfolioEntryInstance.unparsableFile}">
                        <tr class="prop">
                            <td valign="top" class="name">File Path</td>
                            <td valign="top" class="value">${fieldValue(bean: portfolioEntryInstance, field: "unparsableFile")}</td>
                        </tr>
                        </g:if>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label><g:message code="portfolioEntry.enable.label" default="Enable" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'enable', 'errors')}">
                                    <g:checkBox name="enable" value="${portfolioEntryInstance?.enable}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label>Promo Code</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'promoCode', 'errors')}">
                                    <g:select name="promoCode" from="${promoCodeList}" value="${portfolioEntryInstance?.promoCode}"/>
                                </td>
                            </tr>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label><g:message code="portfolioEntry.adTypeCode.label" default="Ad Type Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'adTypeCode', 'errors')}">
                                    <g:select name="adTypeCode"  noSelection="${['':'Select One...']}" from="${adTypeCodes}" value="${portfolioEntryInstance?.adTypeCode}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label><g:message code="portfolioEntry.adSizeCode.label" default="Ad Size Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'adSizeCode', 'errors')}">
                                    <g:select name="adSizeCode"  noSelection="${['':'Select One...']}" from="${adSizeCodes}" value="${portfolioEntryInstance?.adSizeCode}" valueMessagePrefix="portfolioEntry.adSizeCode"  />
                                </td>
                            </tr>
                   			<tr class="prop">
                                <td valign="top" class="name">
                                  <label>Color</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'color', 'errors')}">
                                    <g:select name="color" noSelection="${['':'Select One...']}" from="${[1,2,4]}" value="${portfolioEntryInstance?.color}"/>
                                </td>
                            </tr>
                                 
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label><g:message code="portfolioEntry.offerCode.label" default="Offer Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'offerCode', 'errors')}">
                                    <g:select name="offerCode" noSelection="${['':'Select One...']}" from="${offerCodes}" value="${portfolioEntryInstance?.offerCode}"/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label><g:message code="portfolioEntry.adPageNumber.label" default="Ad Page Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'adPageNumber', 'errors')}">
                                    <g:textField name="adPageNumber" value="${fieldValue(bean: portfolioEntryInstance, field: 'adPageNumber')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label><g:message code="portfolioEntry.adDescription.label" default="Ad Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'adDescription', 'errors')}">
                                    <g:textArea name="adDescription" cols="40" rows="5" value="${portfolioEntryInstance?.adDescription}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label>Detail</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'details', 'errors')}">
                                    <g:textArea name="details" cols="40" rows="5" value="${portfolioEntryInstance?.details}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label>Image File</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'imageFile', 'errors')}">
                                    <g:select name="imageFile"
							          from="${jpgFiles}"
							          value="${portfolioEntryInstance.imageFile}"
							          />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label>PDF File</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: portfolioEntryInstance, field: 'pdfFile', 'errors')}">
                                    <g:select name="pdfFile"
							          from="${pdfFiles}"
							          value="${portfolioEntryInstance.pdfFile}"
							          />
                                </td>
                            </tr>
<%-- elements --%>                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label>Element</label>
                                </td>
                                <td valign="top" class="value">
                                    <g:checkBox name="anatomy" value="${portfolioEntryInstance?.anatomy}" /> Anatomy image
                                    <br/><g:checkBox name="product" value="${portfolioEntryInstance?.product}" /> Product image
                                    <br/><g:checkBox name="patient" value="${portfolioEntryInstance?.patient}" /> Patient photo
                                    <br/><g:checkBox name="dispenser" value="${portfolioEntryInstance?.dispenser}" /> Dispenser photo
                                    <br/><g:checkBox id="cal2" name="calendar" value="${portfolioEntryInstance?.map}" /> Map
                                    <br/><g:checkBox name="map" value="${portfolioEntryInstance?.calendar}" /> Calendar
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
                                  <label>Focus</label>
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
                                  <label>Time Of Year</label>
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
                </div>
                <div class="buttons" style="clear:both">
                    <span class="button">
                    <g:actionSubmit class="save" action="updateAdEntry" value="Update" /></span>
                    </span>
                </div>
            </g:form>
        </div>
    </body>
</html>
