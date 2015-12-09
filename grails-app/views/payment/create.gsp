
<%@ page import="com.itda.Payment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'payment.label', default: 'Payment')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.create.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${paymentInstance}">
            <div class="errors">
                <g:renderErrors bean="${paymentInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="save" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="firstName"><g:message code="payment.firstName.label" default="First Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'firstName', 'errors')}">
                                    <g:textField name="firstName" maxlength="50" value="${paymentInstance?.firstName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="lastName"><g:message code="payment.lastName.label" default="Last Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'lastName', 'errors')}">
                                    <g:textField name="lastName" maxlength="50" value="${paymentInstance?.lastName}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cardNumber"><g:message code="payment.cardNumber.label" default="Card Number" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'cardNumber', 'errors')}">
                                    <g:textField name="cardNumber" maxlength="16" value="${paymentInstance?.cardNumber}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="expireMonth"><g:message code="payment.expireMonth.label" default="Expire Month" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'expireMonth', 'errors')}">
                                    <g:select name="expireMonth" from="${paymentInstance.constraints.expireMonth.inList}" value="${paymentInstance?.expireMonth}" valueMessagePrefix="payment.expireMonth"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="expireYear"><g:message code="payment.expireYear.label" default="Expire Year" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'expireYear', 'errors')}">
                                    <g:select name="expireYear" from="${paymentInstance.constraints.expireYear.inList}" value="${paymentInstance?.expireYear}" valueMessagePrefix="payment.expireYear"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="cardSecurityCode"><g:message code="payment.cardSecurityCode.label" default="Card Security Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'cardSecurityCode', 'errors')}">
                                    <g:textField name="cardSecurityCode" maxlength="4" value="${paymentInstance?.cardSecurityCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="billingAddress"><g:message code="payment.billingAddress.label" default="Billing Address" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'billingAddress', 'errors')}">
                                    <g:textField name="billingAddress" maxlength="60" value="${paymentInstance?.billingAddress}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city"><g:message code="payment.city.label" default="City" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'city', 'errors')}">
                                    <g:textField name="city" maxlength="40" value="${paymentInstance?.city}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state"><g:message code="payment.state.label" default="State" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'state', 'errors')}">
                                    <g:select name="state" from="${paymentInstance.constraints.state.inList}" value="${paymentInstance?.state}" valueMessagePrefix="payment.state"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zipcode"><g:message code="payment.zipcode.label" default="Zipcode" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'zipcode', 'errors')}">
                                    <g:textField name="zipcode" maxlength="5" value="${paymentInstance?.zipcode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="response"><g:message code="payment.response.label" default="Response" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'response', 'errors')}">
                                    <g:textArea name="response" cols="40" rows="5" value="${paymentInstance?.response}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="amount"><g:message code="payment.amount.label" default="Amount" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'amount', 'errors')}">
                                    <g:textField name="amount" value="${fieldValue(bean: paymentInstance, field: 'amount')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="approvalCode"><g:message code="payment.approvalCode.label" default="Approval Code" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'approvalCode', 'errors')}">
                                    <g:textField name="approvalCode" maxlength="6" value="${paymentInstance?.approvalCode}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="transactionId"><g:message code="payment.transactionId.label" default="Transaction Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'transactionId', 'errors')}">
                                    <g:textField name="transactionId" maxlength="128" value="${paymentInstance?.transactionId}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="subscriptionId"><g:message code="payment.subscriptionId.label" default="Subscription Id" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'subscriptionId', 'errors')}">
                                    <g:textField name="subscriptionId" maxlength="64" value="${paymentInstance?.subscriptionId}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="description"><g:message code="payment.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" maxlength="128" value="${paymentInstance?.description}" />
                                </td>
                            </tr>

                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="notes"><g:message code="payment.notes.label" default="Notes" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'notes', 'errors')}">
                                    <g:textArea name="notes" cols="40" rows="5" value="${paymentInstance?.notes}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="business"><g:message code="payment.business.label" default="Business" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: paymentInstance, field: 'business', 'errors')}">
                                    <g:select name="business.id" from="${com.itda.Business.list()}" optionKey="id" value="${officeInstance?.business?.id}" optionValue="businessName" />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
