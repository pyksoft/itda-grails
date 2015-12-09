<%@page sitemeshPreprocess="false"%>
<%@ page import="com.itda.Vendor" %>           
                <g:if test="${vendorInstanceList}">
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
                    <g:each in="${vendorInstanceList}" var="vendorInstance">
                        <tr id='row${vendorInstance.id}'>
                            <td width="25%" class='name bottom-separator'>
                            	${fieldValue(bean: vendorInstance, field: "vendorName")}
                            </td>                        
                            <td width="29%" class='bottom-separator'>
                            	${fieldValue(bean: vendorInstance, field: "contactName")}
								<br/>${fieldValue(bean: vendorInstance, field: "contactPhone")}
								<br/><br/>${fieldValue(bean: vendorInstance, field: "email")}
								<g:if test="${vendorInstance.alternateEmail}">
								<br/>${fieldValue(bean: vendorInstance, field: "alternateEmail")}
								</g:if>
							</td>
                            <td width="30%" class='bottom-separator'>
                            	${fieldValue(bean: vendorInstance, field: "address")}
								<g:if test="${vendorInstance.city || vendorInstance.state}">								
								<br/>${fieldValue(bean: vendorInstance, field: "city")}
								</g:if>
								<g:if test="${vendorInstance.state && vendorInstance.city}">								
								, 
								</g:if>
								${fieldValue(bean: vendorInstance, field: "state")}
								<g:if test="${vendorInstance.zipcode}">
								<br/>${fieldValue(bean: vendorInstance, field: "zipcode")}
								</g:if>
							</td>							
                             <td width="16%" class='bottom-separator'>
                             	<%-- g:link controller="accountSetup" action="deleteVendor" id="${vendorInstance.id}" params="[token:actionName]"
                             	     onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Do you want to proceed with delete?')}');">Remove</g:link>
                             	<br/><g:link controller="accountSetup" action="editVendor" id="${vendorInstance.id}" params="[token:actionName]">Edit</g:link>--%>
                             	     <a onclick="openDelAcctInfoDialog(${vendorInstance.id}, 'tr#row${vendorInstance.id}', '/accountSetup/deleteVendor' );" href="javascript:void(0)">Delete</a>
                             	<br/><a onclick="myAcctDialog(${vendorInstance.id}, 'editVendor' ); return false" href="javascript:void(0)">Edit</a>
                            </td>                        
                        </tr>
                    </g:each>
                   
                    </tbody>
                </table>
                </div>
			<br/>
       </g:if>
       <g:elseif test="${actionName == 'listVendor'}"><br/><br/><%-- e h o --%>
       <h2 style="text-align:center;"><br/><br/>Please use the form to list the<br/>direct mail and print vendors you work with.</h2>
       </g:elseif>
          