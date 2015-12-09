<%@page sitemeshPreprocess="false"%>
<%@ page import="com.itda.*" %>
        <div>
           <g:if test='${actionName == "listVendor"}'><%-- eho --%>
            <g:if test='${edit}'>
            <h2 class="left-element">Edit Vendors</h2>
            </g:if>
            <g:else>
            <h2 class="left-element">Who are your Vendors?</h2>
            </g:else>
           </g:if>
            <%-- form --%>
            <g:form controller="accountSetup" action='${edit ? "updateVendor" : "saveVendor"}' method="post" style='text-align:left'>
            <g:if test='${edit}'>
	            <input type="hidden" name="token" value="${actionName}"/><%-- eho --%>
	            <input type="hidden" name="id" value="${vendorInstance.id}"/>
            </g:if>
            <g:elseif test='${add}'>
	            <input type="hidden" name="token" value="${actionNameactionName== 'listVendor' ?'listVendor' : 'vendors'}"/><%-- eho --%>           
            </g:elseif>
            
                <div >
		           <g:if test='${actionName == "listVendor"}'><br/></g:if>
                    <table>
                        <tbody>
						            <tr>
						                <td colspan="2" valign="top" class="red">
						                     (*) indicates required field
						                </td>
						            </tr>                             
                        
                            <tr>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:vendorInstance,field:'vendorName','errors')}">
                                    <label for="vendorName">* Vendor Name:</label>
                                    <input type="text" maxlength="128" size="35" id="vendorName" name="vendorName" value="${fieldValue(bean:vendorInstance,field:'vendorName')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:vendorInstance,field:'contactName','errors')}">
                                    <label for="contactName">* Contact Name:</label><br/>
                                    <input size="35" type="text" maxlength="128" id="contactName" name="contactName" value="${fieldValue(bean:vendorInstance,field:'contactName')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td valign="top" colspan="2" class="value ${hasErrors(bean:vendorInstance,field:'contactPhone','errors')}">
                                    <label for="contactName">Contact Phone:</label> xxx-xxx-xxxx<br/>
                                    <input size="35" type="text" maxlength="12" id="contactPhone" name="contactPhone" value="${fieldValue(bean:vendorInstance,field:'contactPhone')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:vendorInstance,field:'email','errors')}">
                                    <label for="email">* Email:</label><br/>
                                    <input size="35" type="text" id="email" name="email" value="${fieldValue(bean:vendorInstance,field:'email')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:vendorInstance,field:'alternateEmail','errors')}">
                                    <label for="email">&nbsp; Alternate Email:</label><br/>
                                    <input size="35" type="text" id="alternateEmail" name="alternateEmail" value="${fieldValue(bean:vendorInstance,field:'alternateEmail')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:vendorInstance,field:'address','errors')}">
                                    <label for="address">&nbsp; Address:</label></br>
                                    <input size="35" type="text" maxlength="128" id="address" name="address" value="${fieldValue(bean:vendorInstance,field:'address')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:vendorInstance,field:'city','errors')}">
                                    <label for="city">&nbsp; City:</label></br>
                                    <input size="35" type="text" maxlength="128" id="city" name="city" value="${fieldValue(bean:vendorInstance,field:'city')}"/>
                                </td>
                            </tr> 
                         
                            <tr class="prop">
                                <td valign="top" class="value ${hasErrors(bean:vendorInstance,field:'state','errors')}">
                                    <label for="state">&nbsp; State:</label></br>
                                    <g:select id="state" name="state" from="${(new Vendor()).constraints.state.inList}" value="${fieldValue(bean:vendorInstance,field:'state')}" noSelection="['':'']"></g:select>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:vendorInstance,field:'zipcode','errors')}">
                                    <label for="zipcode">&nbsp; ZIP Code</label> xxxxx</br>
                                    <input type="text" maxlength="5" id="zipcode" name="zipcode" value="${fieldValue(bean:vendorInstance,field:'zipcode')}"/>
                                </td>
                            </tr> 
 
 						            <tr class="prop">
						                <td colspan="2" valign="top" >
						                		<div>
						                		
									            <g:if test='${edit}'>
							                       <g:submitButton name="done" value="" class="done"/>
									            </g:if>
									            <g:else>            
							                       <g:submitButton name="addVendor" value="" class="add_Vendor" /><br/>
							                       <g:link action="listManufacturer"><img src='/images/itd/nav2/buttons_done.jpg'/></g:link>
									            </g:else>
									            
							                     </div>
							             </td>
						
						            </tr>                        
                        </tbody>
                    </table>
                </div>

               </g:form>
        </div>
