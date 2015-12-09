<%@ page import="com.itda.Publication" %>           
               <g:if test="${publicationInstanceList}">
               <div class="list" style="border-bottom-style: none; border-width: 0px;">
                <table class="table" style="width:100%;">
                    <thead>
                        <tr>
					                   	        <th class='name'>Name</th>
					                   	        <th>Contact</th>
					                        	<th>Address/Phone</th>
					                        	<th>Action</th>                         
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${publicationInstanceList}" var="publicationInstance">
                        <tr id='row${publicationInstance.id}'>
                            <td width="25%" class='name bottom-separator'>
                            	${fieldValue(bean: publicationInstance, field: "newspaperOrPublicationName")}
                            </td>                        
                            <td width="29%" class='bottom-separator'>
                            	${fieldValue(bean: publicationInstance, field: "contactName")}
								<br/>${fieldValue(bean: publicationInstance, field: "contactPhone")}
								<br/><br/>${fieldValue(bean: publicationInstance, field: "email")}
								<g:if test="${publicationInstance.alternateEmail}">
								<br/>${fieldValue(bean: publicationInstance, field: "alternateEmail")}
								</g:if>
							</td>
                            <td width="30%" class='bottom-separator'>
                            	${fieldValue(bean: publicationInstance, field: "addressLine1")}
								<g:if test="${publicationInstance.city || publicationInstance.state}">								
								<br/>${fieldValue(bean: publicationInstance, field: "city")}
								</g:if>
								<g:if test="${publicationInstance.state && publicationInstance.city}">								
								, 
								</g:if>
								${fieldValue(bean: publicationInstance, field: "state")}
								<g:if test="${publicationInstance.zipcode}">
								<br/>${fieldValue(bean: publicationInstance, field: "zipcode")}
								</g:if>
								<g:if test="${publicationInstance.publicationPhone}">
								<br/><br/>${fieldValue(bean: publicationInstance, field: "publicationPhone")}
								</g:if>
								<g:else>&nbsp;</g:else>
							</td>							
                             <td width="16%" class='bottom-separator'>
                             <%--  	<g:link controller="accountSetup" action="deletePublication" id="${publicationInstance.id}" params="[token:actionName]" 
                             	     onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Do you want to proceed with delete?')}');">Remove</g:link>
                             	     --%>
                             	     <a onclick="openDelAcctInfoDialog(${publicationInstance.id}, 'tr#row${publicationInstance.id}', '/accountSetup/deletePublication' );" href="javascript:void(0)">Delete</a>
                             	<br/><a onclick="myAcctDialog(${publicationInstance.id}, 'editPublication' ); return false" href="javascript:void(0)">Edit</a>
                            </td>                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
                </div>
			<br/>


       </g:if>
       <g:elseif test="${actionName == 'listPublication'}"><br/><br/>
         <h2 style="text-align:center;"><br/><br/>Please use the form to list<br/>the newspaper vendors you work with.</h2>
       </g:elseif>
 