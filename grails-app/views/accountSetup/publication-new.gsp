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
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:publicationInstance,field:'newspaperOrPublicationName','errors')}">
                                    <label for="newspaperOrPublicationName"><span class='require'>*</span> Newspaper  Name:</label><br/>
                                    <input type="text" maxlength="128" size="35" id="newspaperOrPublicationName" name="newspaperOrPublicationName" value="${fieldValue(bean:publicationInstance,field:'newspaperOrPublicationName')}"/>
                                </td>
                            </tr> 
                            <tr class="prop">
                                <td colspan="2" valign="top" class="value ${hasErrors(bean:publicationInstance,field:'contactName','errors')}">
                                    <label for="contactName"><span class='require'>*</span> Contact Name:</label><br/>
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
                                    <label for="email"><span class='require'>*</span> Email:</label><br/>
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
                                <td valign="top" class="value">
                                    <label for="state">&nbsp;  State:</label></br>
                                    <g:select id="state" name="state" from="${(new Publication()).constraints.state.inList}" value="${fieldValue(bean:publicationInstance,field:'state')}" noSelection="['':'']"></g:select>
                                </td>
                                <td valign="top" class="value">
                                    <label for="zipcode">&nbsp;  ZIP Code</label> xxxxx</br>
                                    <input type="text" maxlength="5" id="zipcode" name="zipcode" value="${fieldValue(bean:publicationInstance,field:'zipcode')}"/>
                                </td>
                            </tr> 
                        </tbody>
                    </table>
                </div>

               </form>
        </div>
