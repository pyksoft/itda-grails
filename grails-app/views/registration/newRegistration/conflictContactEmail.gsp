<%@ page contentType="text/html" %>
<body>
Please contact a potential customer about territory conflicts. Here is information 
provided: <br/><br/> 
Name: ${commentCommand.name} <br/>
Phone: ${commentCommand.phone} <br/>
Comment: ${commentCommand.comment} <br/><br/>

				            <g:if test="${officeInstanceList}">
				               <br/>
            					<h1>
									Offices and ZIP Codes
								</h1>
					            <div>
					                <table>
					                    <thead>
					                        <tr>
					                   	        <th>Office&nbsp;Name</th>
					                   	        <th>&nbsp;&nbsp;Address</th>
					                   	        <th>&nbsp;&nbsp;Availability</th>
					                   	        <th>ZIP Codes</th>
					                        </tr>
					                    </thead>
					                    <tbody>
					                    <g:each in="${officeInstanceList}" status="i" var="officeInstance">
					              
					                        <tr>
					                            <td>${fieldValue(bean:officeInstance, field:'name')}</td>
					                        
					                            <td>
					                               	${fieldValue(bean:officeInstance, field:'addressLine1')}
					                            	${fieldValue(bean:officeInstance, field:'city')}, ${fieldValue(bean:officeInstance, field:'state')} 
					                            	${fieldValue(bean:officeInstance, field:'zipcode')}
					                            </td>
					                            <td>${(officeInstance.availability == 'true') ? 'Available' : 'Unavailable'}</td>
					                            <td width="50%">
					                    		${officeInstance.territoryZipcodes}
					                            </td>
					                        
					                        </tr>
					                        
					                    </g:each>
					                    </tbody>
					                </table>
					            </div>
				            </g:if>
</body>