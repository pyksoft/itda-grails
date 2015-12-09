<%@page sitemeshPreprocess="false"%>
<%@ page import="com.itda.*" %>
        <div>
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
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'manufacturerName','errors')}">
                                    <label for="manufacturerName"><span class='require'>*</span> Manufacturer Name:</label>
                                    <input type="text" maxlength="128" size="35" id="manufacturerName" name="manufacturerName" value="${fieldValue(bean:manufacturerInstance,field:'manufacturerName')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'phone','errors')}">
                                    <label for="phone">Manufacturer Phone:</label> xxx-xxx-xxxx<br/>
                                    <input size="35" type="text" maxlength="12" id="Phone" name="phone" value="${fieldValue(bean:manufacturerInstance,field:'phone')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'contactName','errors')}">
                                    <label for="contactName">Contact Name:</label><br/>
                                    <input size="35" type="text" maxlength="128" id="contactName" name="contactName" value="${fieldValue(bean:manufacturerInstance,field:'contactName')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td valign="top" colspan="2" class="value ${hasErrors(bean:manufacturerInstance,field:'contactPhone','errors')}">
                                    <label for="contactName">Contact Phone:</label> xxx-xxx-xxxx<br/>
                                    <input size="35" type="text" maxlength="12" id="contactPhone" name="contactPhone" value="${fieldValue(bean:manufacturerInstance,field:'contactPhone')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'email','errors')}">
                                    <label for="email">Email:</label><br/>
                                    <input size="35" type="text" id="email" name="email" value="${fieldValue(bean:manufacturerInstance,field:'email')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'alternateEmail','errors')}">
                                    <label for="email">&nbsp; Alternate Email:</label><br/>
                                    <input size="35" type="text" id="alternateEmail" name="alternateEmail" value="${fieldValue(bean:manufacturerInstance,field:'alternateEmail')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'address','errors')}">
                                    <label for="address">&nbsp; Address:</label></br>
                                    <input size="35" type="text" maxlength="128" id="address" name="address" value="${fieldValue(bean:manufacturerInstance,field:'address')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'city','errors')}">
                                    <label for="city">&nbsp; City:</label></br>
                                    <input size="35" type="text" maxlength="128" id="city" name="city" value="${fieldValue(bean:manufacturerInstance,field:'city')}"/>
                                </td>
                            </tr> 
                         
                            <tr class="prop">
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'state','errors')}">
                                    <label for="state">&nbsp; State:</label></br>
                                    <g:select id="state" name="state" from="${(new Manufacturer()).constraints.state.inList}" value="${fieldValue(bean:manufacturerInstance,field:'state')}" noSelection="['':'']"></g:select>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean:manufacturerInstance,field:'zipcode','errors')}">
                                    <label for="zipcode">&nbsp; ZIP Code</label> xxxxx</br>
                                    <input type="text" maxlength="5" id="zipcode" name="zipcode" value="${fieldValue(bean:manufacturerInstance,field:'zipcode')}"/>
                                </td>
                            </tr> 
                       
                        </tbody>
                    </table>
                </div>

               </form>
        </div>
