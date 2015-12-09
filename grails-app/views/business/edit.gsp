
<%@ page import="com.itda.Business" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'business.label', default: 'Business')}" />
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
            <g:hasErrors bean="${businessInstance}">
            <div class="errors">
                <g:renderErrors bean="${businessInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${businessInstance?.id}" />
                <g:hiddenField name="version" value="${businessInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="businessName"><g:message code="business.businessName.label" default="Business Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'businessName', 'errors')}">
                                    <g:textField name="businessName" maxlength="128" value="${businessInstance?.businessName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="representativeName"><g:message code="business.representativeName.label" default="Representative Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'representativeName', 'errors')}">
                                    <g:textField name="representativeName" maxlength="128" value="${businessInstance?.representativeName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="email"><g:message code="business.email.label" default="Email" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'email', 'errors')}">
                                    <g:textField name="email" value="${businessInstance?.email}"  readonly='true'/>
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="phone"><g:message code="business.phone.label" default="Phone" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'phone', 'errors')}">
                                    <g:textField name="phone" value="${businessInstance?.phone}" />
                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="notes">Notes</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'notes', 'errors')}">
                                    <g:textArea name="notes" cols="40" rows="5" value="${businessInstance?.notes}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="offices"><g:message code="business.offices.label" default="Offices" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'offices', 'errors')}">
                                    
<ul>
<g:each in="${businessInstance?.offices?}" var="o">
    <li><g:link controller="office" action="show" id="${o.id}">${o?.name}</g:link></li>
</g:each>
</ul>
<g:link controller="office" action="create" params="['business.id': businessInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'office.label', default: 'Office')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="payments"><g:message code="business.payments.label" default="Payments" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'payments', 'errors')}">
                                    
<ul>
<g:each in="${businessInstance?.payments?}" var="p">
    <li><g:link controller="payment" action="show" id="${p.id}">${p?.cardNumberAsLast4String()} - $${p?.totalPriceAsString()}</g:link></li>
</g:each>
</ul>
<g:link controller="payment" action="create" params="['business.id': businessInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'payment.label', default: 'Payment')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="publications"><g:message code="business.publications.label" default="Publications" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'publications', 'errors')}">
                                    
<ul>
<g:each in="${businessInstance?.publications?}" var="p">
    <li><g:link controller="publication" action="show" id="${p.id}">${p?.newspaperOrPublicationName}</g:link></li>
</g:each>
</ul>
<g:link controller="publication" action="create" params="['business.id': businessInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'publication.label', default: 'Publication')])}</g:link>

                                </td>
                            </tr>
                        
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="vendors"><g:message code="business.vendors.label" default="Vendors" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'vendors', 'errors')}">
                                    
<ul>
<g:each in="${businessInstance?.vendors?}" var="v">
    <li><g:link controller="vendor" action="show" id="${v.id}">${v?.vendorName}</g:link></li>
</g:each>
</ul>
<g:link controller="vendor" action="create" params="['business.id': businessInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'vendor.label', default: 'Vendor')])}</g:link>

                                </td>
                            </tr>
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="manufacturers"><g:message code="business.manufacturers.label" default="Manufacturers" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'manufacturers', 'errors')}">
                                    
<ul>
<g:each in="${businessInstance?.manufacturers?}" var="m">
    <li><g:link controller="manufacturer" action="show" id="${m.id}">${m?.manufacturerName}</g:link></li>
</g:each>
</ul>
<g:link controller="manufacturer" action="create" params="['business.id': businessInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'manufacturer.label', default: 'Manufacturer')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="competitors"><g:message code="business.competitors.label" default="Competitors" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: businessInstance, field: 'competitors', 'errors')}">
                                    
<ul>
<g:each in="${businessInstance?.competitors?}" var="c">
    <li><g:link controller="competitor" action="show" id="${c.id}">${c?.businessName}</g:link></li>
</g:each>
</ul>
<g:link controller="competitor" action="create" params="['business.id': businessInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'competitor.label', default: 'Competitor')])}</g:link>

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
