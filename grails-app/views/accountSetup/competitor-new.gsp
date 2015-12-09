<%@page sitemeshPreprocess="false"%>
<%@ page import="com.itda.*" %>
        <div>
           	<input type="hidden" name="id" value=""/>
            <form id='acctInfoForm' action='#'>        
            	<input type="hidden" name="id" value=""/>
                <div >
                    <table>
                        <tbody>
						            <tr>
						                <td colspan="2" valign="top" class="require">
						                     (*) indicates required field<br/><br/>
						                </td>
						            </tr>                             
                        
                            <tr>
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:competitorInstance,field:'businessName','errors')}">
                                    <label for="businessName"><span class='require'>*</span> Business Name:</label><br/>
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
                                    <label for="city"><span class='require'>*</span> City:</label></br>
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
                        </tbody>
                    </table>
                </div>

               </form>
        </div>
