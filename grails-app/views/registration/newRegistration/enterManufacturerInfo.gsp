<%@ page import="com.itda.*" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Manufacturers Information</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
        </div>
        <div class="body">
            <h1>Manufacturers Information</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${manufacturerInstance}">
            <div class="errors">
                <g:renderErrors bean="${manufacturerInstance}" as="list" />
            </div>
            </g:hasErrors>
            <%-- form --%>
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
                                    <label for="manufacturerName">* Manufacturer Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'manufacturerName','errors')}">
                                    <input type="text" maxlength="128" id="manufacturerName" name="manufacturerName" value="${fieldValue(bean:manufacturerInstance,field:'manufacturerName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="salesRepName">* Sales Rep Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'salesRepName','errors')}">
                                    <input type="text" maxlength="128" id="salesRepName" name="salesRepName" value="${fieldValue(bean:manufacturerInstance,field:'salesRepName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">* Email:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'email','errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean:manufacturerInstance,field:'email')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="phone">* Phone:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'phone','errors')}">
                                    <input type="text" id="phone" name="phone" value="${fieldValue(bean:manufacturerInstance,field:'phone')}"/>
                                    <br/>xxx-xxx-xxxx
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine1">* Address Line 1:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'addressLine1','errors')}">
                                    <input type="text" maxlength="128" id="addressLine1" name="addressLine1" value="${fieldValue(bean:manufacturerInstance,field:'addressLine1')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine2">Address Line 2:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'addressLine2','errors')}">
                                    <input type="text" maxlength="128" id="addressLine2" name="addressLine2" value="${fieldValue(bean:manufacturerInstance,field:'addressLine2')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city">* City:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'city','errors')}">
                                    <input type="text" maxlength="128" id="city" name="city" value="${fieldValue(bean:manufacturerInstance,field:'city')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state">* State:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'state','errors')}">
                                    <g:select id="state" name="state" from="${(new Manufacturer()).constraints.state.inList}" value="${fieldValue(bean:manufacturerInstance,field:'state')}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zipcode">* ZIP Code:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'zipcode','errors')}">
                                    <input type="text" maxlength="5" id="zipcode" name="zipcode" value="${fieldValue(bean:manufacturerInstance,field:'zipcode')}"/>
                                    <br/>xxxxx
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="name">
                <div class="buttons">
                    <span class="button"><g:submitButton name="addManufacturer" value="Add Manufacturer" class="save"/></span>
                </div>
                                </td>
                            </tr> 

                        </tbody>
                    </table>
                </div>
	                <div class="buttons">
	                    <span class="button">
				                       <g:submitButton name="back" value="Back" class="back"/>
				                       <g:submitButton name="next" value="Next" class="next"/>

	                    </span>
	                </div>
               </g:form>
        <%-- list --%>
            <g:if test="${manufacturerInstanceList}">
            <div class="list">
					                <h1>Manufacturer List</h1>
                <table>
                    <thead>
                        <tr>
                   	        <th>Manufacturer Name</th>
                   	        <th>Contact Information</th>
                   	        <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${manufacturerInstanceList}" status="i" var="manufacturerInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean:manufacturerInstance, field:'manufacturerName')}</td>
                        
                            <td>${fieldValue(bean:manufacturerInstance, field:'salesRepName')}<br/>
                        
                                ${fieldValue(bean:manufacturerInstance, field:'email')}<br/>
                        
                                ${fieldValue(bean:manufacturerInstance, field:'phone')}<br/>
                        
                            	${fieldValue(bean:manufacturerInstance, field:'addressLine1')}
                            	${fieldValue(bean:manufacturerInstance, field:'addressLine2')}
                            	<br/>${fieldValue(bean:manufacturerInstance, field:'city')}, 
                            	${fieldValue(bean:manufacturerInstance, field:'state')} 
                            	${fieldValue(bean:manufacturerInstance, field:'zipcode')}
					        </td>
					        <td>
				            <g:form action="newRegistration" method="post" >
				            		<input type="hidden" name="index" value="${i}" />
							                       <g:submitButton name="removeManufacturer" value="Remove Manufacturer" class="delete"/>
					                </g:form>
					                            
					       </td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            </g:if>

        </div>
    </body>
</html>
