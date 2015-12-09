<%@page sitemeshPreprocess="false"%>
<%@ page import="com.itda.*" %>
        <div>
           <g:if test='${actionName == "listPublication"}'><%-- eho --%>
            <g:if test='${edit}'>
            <h2 class="left-element">Edit Newspapers</h2>
            </g:if>
            <g:else>
            <h2 class="left-element">Who are your Newspapers?</h2>
            </g:else>
           </g:if>
            <%-- form --%>
            <g:form controller="accountSetup" action='${edit ? "updatePublication" : "savePublication"}' method="post" style='text-align:left'>
            <g:if test='${edit}'>
	            <input type="hidden" name="id" value="${publicationInstance.id}"/>
	            <input type="hidden" name="token" value="${actionName}"/><%-- eho --%>
            </g:if>
            <g:elseif test='${add}'>
	            <input type="hidden" name="token" value="${actionName== 'listPublication' ?'listPublication' : 'newspapers'}"/><%-- eho --%>           
            </g:elseif>
            
                <div >
		           <g:if test='${actionName == "listPublication"}'><br/></g:if>
                    <table>
                        <tbody>
						            <tr>
						                <td colspan="2" valign="top" class="red">
						                     (*) indicates required field
						                </td>
						            </tr>                             
                        
                            <tr>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:publicationInstance,field:'newspaperOrPublicationName','errors')}">
                                    <label for="newspaperOrPublicationName">* Newspaper  Name:</label><br/>
                                    <input type="text" maxlength="128" size="35" id="newspaperOrPublicationName" name="newspaperOrPublicationName" value="${fieldValue(bean:publicationInstance,field:'newspaperOrPublicationName')}"/>
                                </td>
                            </tr> 
                            <%--
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:publicationInstance,field:'publicationPhone','errors')}">
                                    <label for="contactName">&nbsp; Publication Phone:</label> xxx-xxx-xxxx<br/>
                                    <input size="35" type="text" maxlength="12" id="publicationPhone" name="publicationPhone" value="${fieldValue(bean:publicationInstance,field:'publicationPhone')}"/>
                                </td>
                            </tr> --%>
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:publicationInstance,field:'contactName','errors')}">
                                    <label for="contactName">* Contact Name:</label><br/>
                                    <input size="35" type="text" maxlength="128" id="contactName" name="contactName" value="${fieldValue(bean:publicationInstance,field:'contactName')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td valign="top" colspan="2" class="value ${hasErrors(bean:publicationInstance,field:'contactPhone','errors')}">
                                    <label for="contactName">Contact Phone:</label> xxx-xxx-xxxx<br/>
                                    <input size="35" type="text" maxlength="12" id="contactPhone" name="contactPhone" value="${fieldValue(bean:publicationInstance,field:'contactPhone')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:publicationInstance,field:'email','errors')}">
                                    <label for="email">* Email:</label><br/>
                                    <input size="35" type="text" id="email" name="email" value="${fieldValue(bean:publicationInstance,field:'email')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:publicationInstance,field:'alternateEmail','errors')}">
                                    <label for="email">&nbsp; Alternate Email:</label><br/>
                                    <input size="35" type="text" id="alternateEmail" name="alternateEmail" value="${fieldValue(bean:publicationInstance,field:'alternateEmail')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:publicationInstance,field:'addressLine1','errors')}">
                                    <label for="addressLine1">&nbsp;  Address:</label></br>
                                    <input size="35" type="text" maxlength="128" id="addressLine1" name="addressLine1" value="${fieldValue(bean:publicationInstance,field:'addressLine1')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:publicationInstance,field:'city','errors')}">
                                    <label for="city">&nbsp;  City:</label></br>
                                    <input size="35" type="text" maxlength="128" id="city" name="city" value="${fieldValue(bean:publicationInstance,field:'city')}"/>
                                </td>
                            </tr> 
                         
                            <tr class="prop">
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'state','errors')}">
                                    <label for="state">&nbsp;  State:</label></br>
                                    <g:select id="state" name="state" from="${(new Publication()).constraints.state.inList}" value="${fieldValue(bean:publicationInstance,field:'state')}" noSelection="['':'']"></g:select>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:publicationInstance,field:'zipcode','errors')}">
                                    <label for="zipcode">&nbsp;  ZIP Code</label> xxxxx</br>
                                    <input type="text" maxlength="5" id="zipcode" name="zipcode" value="${fieldValue(bean:publicationInstance,field:'zipcode')}"/>
                                </td>
                            </tr> 
 
 						            <tr class="prop">
						                <td colspan="2" valign="top" >
						                		<div>
						                		<%-- g:if test='${actionName == "listPublication"}'>--%>
										            <g:if test='${edit}'>
								                       <g:submitButton name="done" value="" class="done"/>
										            </g:if>
										            <g:else>            
								                       <g:submitButton name="addPublication" value="" class="add_publication" /><br/>
								                       <g:link action="listVendor"><img src='/images/itd/nav2/buttons_done.jpg'/></g:link>
										            </g:else>
										         <%-- /g:if>--%>
							                     </div>
							             </td>
						
						            </tr>                        
                        </tbody>
                    </table>
                </div>

               </g:form>
        </div>
