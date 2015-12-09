<%@ page import="com.itda.Competitor" %>           
                <g:if test="${competitorInstanceList}">
               <div class="list" style="border-bottom-style: none; border-width: 0px;">
                <table class="table" style="width:100%;">
                    <thead>
                        <tr>
                        
					                   	        <th class='name'>Name</th>
					                   	        <th>Owner Name</th>
					                        	<th>Address/Phone</th>
					                        	<th>Action</th>                         
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${competitorInstanceList}" var="competitorInstance">
                        <tr>
                            <td width="25%" class='name bottom-separator'>
                            	${fieldValue(bean: competitorInstance, field: "businessName")}
                            </td>                        
                            <td width="29%" class='bottom-separator'>
                            	${fieldValue(bean: competitorInstance, field: "ownerName")}&nbsp;
							</td>
                            <td width="30%" class='bottom-separator'>
								<g:if test="${competitorInstance.address}">
	                            	${fieldValue(bean: competitorInstance, field: "address")}<br/>
								</g:if>
								${fieldValue(bean: competitorInstance, field: "city")}<g:if test="${competitorInstance.state}">, ${fieldValue(bean: competitorInstance, field: "state")}</g:if>
								<g:if test="${competitorInstance.state}"><br/>${fieldValue(bean: competitorInstance, field: "zipcode")}</g:if>
							</td>							
                             <td width="16%" class='bottom-separator'>
                             	<g:link controller="accountSetup" action="deleteCompetitor" id="${competitorInstance.id}"
                             	     onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Do you want to proceed with delete?')}');">Remove</g:link> 
                             	<br/><g:link controller="accountSetup" action="editCompetitor" id="${competitorInstance.id}">Edit</g:link>
                            </td>                        
                        </tr>
                    </g:each>
                   
                    </tbody>
                </table>
                </div>
			<br/>
       </g:if>
       <g:elseif test="${actionName == 'listCompetitor'}"><br/><br/><%-- e h o --%>
<h2 style="text-align:center;"><br/><br/>Please use the form to list<br/> your competitors.</h2>       
       </g:elseif>
       <g:else>
       	<br/><br/><br/>
       </g:else>
          