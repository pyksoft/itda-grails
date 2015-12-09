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
                        <tr id='row${competitorInstance.id}'>
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
                             	     <a onclick="openDelAcctInfoDialog(${competitorInstance.id}, 'tr#row${competitorInstance.id}', '/accountSetup/deleteCompetitor' );" href="javascript:void(0)">Delete</a>
                             	<br/><a onclick="myAcctDialog(${competitorInstance.id}, 'editCompetitor' ); return false" href="javascript:void(0)">Edit</a>
                            </td>                        
                        </tr>
                    </g:each>
                   
                    </tbody>
                </table>
                </div>
			<br/>
       </g:if>
       <g:else>
       	<br/>
       </g:else>
          