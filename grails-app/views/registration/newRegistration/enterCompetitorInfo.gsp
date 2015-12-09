<%@ page import="com.itda.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Competitors Information</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'/')}">Home</a></span>
        </div>
        <div class="body">
            <h1>Competitors Information</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${competitorInstance}">
            <div class="errors">
                <g:renderErrors bean="${competitorInstance}" as="list" />
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
                                    <label for="businessName">* Business Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:competitorInstance,field:'businessName','errors')}">
                                    <input type="text" maxlength="128" id="businessName" name="businessName" value="${fieldValue(bean:competitorInstance,field:'businessName')}"/>
                                </td>
                            </tr> 

                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="ownerName">Owner Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:competitorInstance,field:'ownerName','errors')}">
                                    <input type="text" maxlength="128" id="ownerName" name="ownerName" value="${fieldValue(bean:competitorInstance,field:'ownerName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine1">Address Line1:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:competitorInstance,field:'addressLine1','errors')}">
                                    <input type="text" maxlength="128" id="addressLine1" name="addressLine1" value="${fieldValue(bean:competitorInstance,field:'addressLine1')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine2">Address Line2:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:competitorInstance,field:'addressLine2','errors')}">
                                    <input type="text" maxlength="128" id="addressLine2" name="addressLine2" value="${fieldValue(bean:competitorInstance,field:'addressLine2')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city">* City:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:competitorInstance,field:'city','errors')}">
                                    <input type="text" maxlength="128" id="city" name="city" value="${fieldValue(bean:competitorInstance,field:'city')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state">State:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:competitorInstance,field:'state','errors')}">
                                    <g:select id="state" name="state" from="${(new Competitor()).constraints.state.inList}" value="${fieldValue(bean:competitorInstance,field:'state')}" ></g:select>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zipcode">Zipcode:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:competitorInstance,field:'zipcode','errors')}">
                                    <input type="text" maxlength="5" id="zipcode" name="zipcode" value="${fieldValue(bean:competitorInstance,field:'zipcode')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="name">
                <div class="buttons">
                    <span class="button"><g:submitButton name="addCompetitor" value="Add Competitor" class="save"/></span>
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
            <g:if test="${competitorInstanceList}">
            <div class="list">
            <h1>Competitor List</h1>

                <table>
                    <thead>
                        <tr>
                        	<th>Business Name</th>
                        	<th>Owner Name</th>
                        	<th>Address</th>
                        	<th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${competitorInstanceList}" status="i" var="competitorInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean:competitorInstance, field:'businessName')}</td>
                        
                            <td>${fieldValue(bean:competitorInstance, field:'ownerName')}</td>
                        
                            <td>
                            ${fieldValue(bean:competitorInstance, field:'addressLine1')} ${fieldValue(bean:competitorInstance, field:'addressLine2')}
                        
                            ${fieldValue(bean:competitorInstance, field:'city')} ${fieldValue(bean:competitorInstance, field:'state')}
                            ${fieldValue(bean:competitorInstance, field:'zipcode')}
                            </td>  
                            <td>
				            	<g:form action="newRegistration" method="post" >
				            		<input type="hidden" name="index" value="${i}" />
							         <g:submitButton name="removeCompetitor" value="Remove Competitor" class="delete"/>
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
