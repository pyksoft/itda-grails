<%@ page import="com.itda.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Registration - Business & Contact Information</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
            <span class="menuButton"><g:link class="list">Registration</g:link></span>
        </div>
        <div class="body">
            <h1>Business & Contact Information</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${businessInstance}">
            <div class="errors">
                <g:renderErrors bean="${businessInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form action="newRegistration" method="post" >
                <div class="dialog">
                    <table>
                        <tbody>
                            <tr class="prop">
                                <td valign="top" class="field">
                                    <label for="field">&nbsp</label>
                                </td>
                                <td valign="top" class="value">
                                     (*) indicates required field
                                </td>
                            </tr>                             
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="name">* Business Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'businessName','errors')}">
                                    <input type="text" maxlength="128" id="businessName" name="businessName" value="${fieldValue(bean:businessInstance,field:'businessName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ownerName">* Owner Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'representativeName','errors')}">
                                    <input type="text" maxlength="128" id="representativeName" name="representativeName" value="${fieldValue(bean:businessInstance,field:'representativeName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">* Email Address:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'email','errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean:businessInstance,field:'email')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="phone">* Phone Number:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:businessInstance,field:'phone','errors')}">
                                    <input type="text" maxlength="13" id="phone" name="phone" value="${fieldValue(bean:businessInstance,field:'phone')}"/> xxx-xxx-xxxx
                                </td>
                            </tr>                         
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:submitButton name="next" value="Next" class="next"/></span>
                        
                    
                </div>
            </g:form>
        </div>
    </body>
</html>
