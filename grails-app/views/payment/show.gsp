<%@ page import="com.itda.Payment" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'payment.label', default: 'Payment')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <g:include view="adminConsole/mainNav.gsp"/>
        <div class="nav">
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
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
                            <td valign="top" class="name"><g:message code="payment.id.label" default="Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "id")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.firstName.label" default="First Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "firstName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.lastName.label" default="Last Name" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "lastName")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.cardNumber.label" default="Card Number" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "cardNumber")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.expireMonth.label" default="Expire Month" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "expireMonth")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.expireYear.label" default="Expire Year" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "expireYear")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.cardSecurityCode.label" default="Card Security Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "cardSecurityCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.billingAddress.label" default="Billing Address" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "billingAddress")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.city.label" default="City" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "city")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.state.label" default="State" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "state")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.zipcode.label" default="Zipcode" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "zipcode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.response.label" default="Response" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "response")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.amount.label" default="Amount" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "amount")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.approvalCode.label" default="Approval Code" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "approvalCode")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.transactionId.label" default="Transaction Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "transactionId")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.subscriptionId.label" default="Subscription Id" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "subscriptionId")}</td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.description.label" default="Description" /></td>
                            
                            <td valign="top" class="value">${fieldValue(bean: paymentInstance, field: "description")}</td>
                            
                        </tr>
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.notes.label" default="Notes" /></td>
                            
                            <td valign="top" class="value"><pre>${fieldValue(bean: paymentInstance, field: "notes")}<pre></td>
                            
                        </tr>
                    
                        <tr class="prop">
                            <td valign="top" class="name"><g:message code="payment.business.label" default="Business" /></td>
                            
                            <td valign="top" class="value"><g:link controller="business" action="show" id="${paymentInstance?.business?.id}">${paymentInstance?.business?.businessName}</g:link></td>
                            
                        </tr>
                    
                    </tbody>
                </table>
            </div>
            <div class="buttons">
                <g:form>
                    <g:hiddenField name="id" value="${paymentInstance?.id}" />
                    <span class="button"><g:actionSubmit class="edit" action="edit" value="${message(code: 'default.button.edit.label', default: 'Edit')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </g:form>
            </div>
        </div>
    </body>
</html>
