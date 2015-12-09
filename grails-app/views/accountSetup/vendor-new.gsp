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
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:vendorInstance,field:'vendorName','errors')}">
                                    <label for="vendorName"><span class='require'>*</span> Vendor Name:</label>
                                    <input type="text" maxlength="128" size="35" id="vendorName" name="vendorName" value="${fieldValue(bean:vendorInstance,field:'vendorName')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:vendorInstance,field:'contactName','errors')}">
                                    <label for="contactName"><span class='require'>*</span> Contact Name:</label><br/>
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
                                    <label for="email"><span class='require'>*</span> Email:</label><br/>
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
                        </tbody>
                    </table>
                </div>

               </form>
        </div>
