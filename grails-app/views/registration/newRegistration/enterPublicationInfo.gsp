<%@ page import="com.itda.*" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="layout" content="main" />
        <title>Newspapers/Publications Information</title>         
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${resource(dir:'')}">Home</a></span>
        </div>
        <div class="body">
            <h1>Newspapers/Publications Information</h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <%-- form --%>
            <g:form action="newRegistration" method="post" >
            <g:hasErrors bean="${publicationInstance}">
            <div class="errors">
                <g:renderErrors bean="${publicationInstance}" as="list" />
            </div>
            </g:hasErrors>
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
                                    <label for="newspaperOrPublicationName">* Newspaper/Publication Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'newspaperOrPublicationName','errors')}">
                                    <input type="text" maxlength="128" id="newspaperOrPublicationName" name="newspaperOrPublicationName" value="${fieldValue(bean:publicationInstance,field:'newspaperOrPublicationName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="contactName">* Contact Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'contactName','errors')}">
                                    <input type="text" maxlength="128" id="contactName" name="contactName" value="${fieldValue(bean:publicationInstance,field:'contactName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="email">* Email:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'email','errors')}">
                                    <input type="text" id="email" name="email" value="${fieldValue(bean:publicationInstance,field:'email')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="fullRun">* Full Run:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'fullRun','errors')}">
                                    <g:select id="fullRun" name="fullRun" from="${(new Publication()).constraints.fullRun.inList}" value="${fieldValue(bean:publicationInstance,field:'fullRun')}" ></g:select>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zoneName">* Zone Name:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'zoneName','errors')}">
                                    <input type="text" maxlength="128" id="zoneName" name="zoneName" value="${fieldValue(bean:publicationInstance,field:'zoneName')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine1">Address Line 1:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'addressLine1','errors')}">
                                    <input type="text" maxlength="128" id="addressLine1" name="addressLine1" value="${fieldValue(bean:publicationInstance,field:'addressLine1')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="addressLine2">Address Line 2:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'addressLine2','errors')}">
                                    <input type="text" maxlength="128" id="addressLine2" name="addressLine2" value="${fieldValue(bean:publicationInstance,field:'addressLine2')}"/>
                                </td>
                            </tr> 
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="city">City:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'city','errors')}">
                                    <input type="text" maxlength="128" id="city" name="city" value="${fieldValue(bean:publicationInstance,field:'city')}"/>
                                </td>
                            </tr> 
                         
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="state">State:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'state','errors')}">
                                    <g:select id="state" name="state" from="${(new Publication()).constraints.state.inList}" value="${fieldValue(bean:publicationInstance,field:'state')}" noSelection="['':'']"></g:select>
                                </td>
                            </tr> 
                       
                            <tr class="prop">
                                <td valign="top" class="name">
                                    <label for="zipcode">ZIP Code:</label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'zipcode','errors')}">
                                    <input type="text" maxlength="5" id="zipcode" name="zipcode" value="${fieldValue(bean:publicationInstance,field:'zipcode')}"/>
                                    <br/>xxxxx
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="name">
                <div class="buttons">
                    <span class="button"><g:submitButton name="addPublication" value="Add Publication" class="save"/></span>
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
            <g:if test="${publicationInstanceList}">
            <div class="list">
					                <h1>Newspaper/Publication List</h1>
            
                <table>
                    <thead>
                        <tr>
                        
                   	        <th>Newspaper/Publication Name</th>
                        
                   	        <th>Contact Information</th>
                                               
                   	        <th>Full Run</th>
                        
                   	        <th>Zone Name</th>
                   	        <th>Action</th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${publicationInstanceList}" status="i" var="publicationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td>${fieldValue(bean:publicationInstance, field:'newspaperOrPublicationName')}</td>
                        
                            <td>${fieldValue(bean:publicationInstance, field:'contactName')} <br/>
                                ${fieldValue(bean:publicationInstance, field:'email')}
                               	<br/>${fieldValue(bean:publicationInstance, field:'addressLine1')}  
                            	${fieldValue(bean:publicationInstance, field:'addressLine2')}
                            	<br/>${fieldValue(bean:publicationInstance, field:'city')}, ${fieldValue(bean:publicationInstance, field:'state')} ${fieldValue(bean:publicationInstance, field:'zipcode')}
                                
                                </td>
                        
                            <td>${fieldValue(bean:publicationInstance, field:'fullRun')}</td>
                        
                            <td>${fieldValue(bean:publicationInstance, field:'zoneName')}</td>
					                            <td>
				            <g:form action="newRegistration" method="post" >
				            		<input type="hidden" name="index" value="${i}" />
							                       <g:submitButton name="removePublication" value="Remove Publication" class="delete"/>
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
