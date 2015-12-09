<%@ page import="com.itda.Manufacturer" %>           
                <g:if test="${manufacturerInstanceList}">
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
                    <g:each in="${manufacturerInstanceList}" var="manufacturerInstance">
                        <tr id='row${manufacturerInstance.id}'>
                            <td width="25%" class='name bottom-separator'>
                            	${fieldValue(bean: manufacturerInstance, field: "manufacturerName")}
                            </td>                        
                            <td width="29%" class='bottom-separator'>
                            	${fieldValue(bean: manufacturerInstance, field: "contactName")}
								<br/>${fieldValue(bean: manufacturerInstance, field: "contactPhone")}
								<br/><br/>${fieldValue(bean: manufacturerInstance, field: "email")}
								<g:if test="${manufacturerInstance.alternateEmail}">
								<br/>${fieldValue(bean: manufacturerInstance, field: "alternateEmail")}
								</g:if>
							</td>
                            <td width="30%" class='bottom-separator'>
                             	${fieldValue(bean: manufacturerInstance, field: "address")}
								<g:if test="${manufacturerInstance.city || manufacturerInstance.state}">								
								<br/>${fieldValue(bean: manufacturerInstance, field: "city")}
								</g:if>
								<g:if test="${manufacturerInstance.state && manufacturerInstance.city}">								
								, 
								</g:if>
								${fieldValue(bean: manufacturerInstance, field: "state")}
								<g:if test="${manufacturerInstance.zipcode}">
								<br/>${fieldValue(bean: manufacturerInstance, field: "zipcode")}
								</g:if>
								<g:if test="${manufacturerInstance.phone}">
								<br/><br/>${fieldValue(bean: manufacturerInstance, field: "phone")}
								</g:if>
								<g:else>&nbsp;</g:else>
							</td>							
                             <td width="16%" class='bottom-separator'>
                             	     <a onclick="openDelAcctInfoDialog(${manufacturerInstance.id}, 'tr#row${manufacturerInstance.id}', '/accountSetup/deleteManufacturer' );" href="javascript:void(0)">Delete</a>
                             	<br/><a onclick="myAcctDialog(${manufacturerInstance.id}, 'editManufacturer' ); return false" href="javascript:void(0)">Edit</a>
                            </td>                        
                        </tr>
                    </g:each>
                   
                    </tbody>
                </table>
                </div>
			<br/>
       </g:if>
          