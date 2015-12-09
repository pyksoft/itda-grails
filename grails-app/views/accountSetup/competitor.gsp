<%@page sitemeshPreprocess="false"%>
<%@ page import="com.itda.*" %>
        <div>
           <g:if test='${actionName == "listCompetitor"}'><%-- eho --%>
            <g:if test='${edit}'>
            <h2 class="left-element">Edit Competitors</h2>
            </g:if>
            <g:else>
            <h2 class="left-element">Who are your Competitors?</h2>
            </g:else>
           </g:if>
            <%-- form --%>
            <g:form controller="accountSetup" action='${edit ? "updateCompetitor" : "saveCompetitor"}' method="post" style='text-align:left'>
            <g:if test='${edit}'>
	            <input type="hidden" name="token" value="${actionName}"/><%-- eho --%>
	            <input type="hidden" name="id" value="${competitorInstance.id}"/>
            </g:if>
            <g:elseif test='${add}'>
	            <input type="hidden" name="token" value="${actionName == 'listCompetitor' ?'listCompetitor' : 'competition'}"/><%-- eho --%>           
            </g:elseif>
                <div >
		           <g:if test='${actionName == "listCompetitor"}'><br/></g:if>
                    <table>
                        <tbody>
						            <tr>
						                <td colspan="2" valign="top" class="red">
						                     (*) indicates required field
						                </td>
						            </tr>                             
                        
                            <tr>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:competitorInstance,field:'businessName','errors')}">
                                    <label for="businessName">* Business Name:</label><br/>
                                    <input type="text" maxlength="128" size="35" id="businessName" name="businessName" value="${fieldValue(bean:competitorInstance,field:'businessName')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:competitorInstance,field:'ownerName','errors')}">
                                    <label for="ownerName">&nbsp; Owner Name:</label><br/>
                                    <input size="35" type="text" maxlength="128" id="ownerName" name="ownerName" value="${fieldValue(bean:competitorInstance,field:'ownerName')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:competitorInstance,field:'address','errors')}">
                                    <label for="address">&nbsp; Address:</label></br>
                                    <input size="35" type="text" maxlength="128" id="address" name="address" value="${fieldValue(bean:competitorInstance,field:'address')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:competitorInstance,field:'city','errors')}">
                                    <label for="city">* City:</label></br>
                                    <input size="35" type="text" maxlength="128" id="city" name="city" value="${fieldValue(bean:competitorInstance,field:'city')}"/>
                                </td>
                            </tr> 
                         
                            <tr class="prop">
                                <td valign="top" class="value ${hasErrors(bean:competitorInstance,field:'state','errors')}">
                                    <label for="state">&nbsp; State:</label></br>
                                    <g:select id="state" name="state" from="${(new Competitor()).constraints.state.inList}" value="${fieldValue(bean:competitorInstance,field:'state')}" noSelection="['':'']"></g:select>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:competitorInstance,field:'zipcode','errors')}">
                                    <label for="zipcode">ZIP Code</label> xxxxx</br>
                                    <input type="text" maxlength="5" id="zipcode" name="zipcode" value="${fieldValue(bean:competitorInstance,field:'zipcode')}"/>
                                </td>
                            </tr> 
 
 						            <tr class="prop">
						                <td colspan="2" valign="top" >
						                		<div>
									            <g:if test='${edit}'>
							                       <g:submitButton name="done" value="" class="done"/>
									            </g:if>
									            <g:else>            
							                       <g:submitButton name="addCompetitor" value="" class="add_Competitor" /><br/>
							                       <a href="/"><img src='/images/itd/nav2/buttons_done.jpg'/></a>
									            </g:else>
							                     </div>
							             </td>
						
						            </tr>                        
                        </tbody>
                    </table>
                </div>

               </g:form>
        </div>
