<%@page sitemeshPreprocess="false"%>
<%@ page import="com.itda.*" %>
        <div>
            <form id='acctInfoForm' action='#'>
            	<input type="hidden" name="id" value=""/>
				<input type="hidden" value='true' name='create'/>
                <div>
						<table>
							<tbody>
								<tr>
									<td width="33%" style="padding: 0px;">
									<table>
										<tr class="prop">
											<td colspan="2" valign="top" class="value"><label>(*)
											indicates required field</label></td>
										</tr>
			
										<tr class="prop">
											<td colspan="2 valign="
												top" class="value ${hasErrors(bean:officeInstance,field:'name','errors')}">
											<br />
											<br />
											<input type="text" maxlength="128" size="40" name="name"  class='office'
												value="${fieldValue(bean:officeInstance,field:'name')}" />
											<label>*</label> Office Location Name											
											</td>
										</tr>
			
										<tr class="prop">
											<td colspan="2 valign="
												top" class="value ${hasErrors(bean:officeInstance,field:'addressLine1','errors')}">
											<input type="text" maxlength="128" size="40" name="addressLine1"  class='office'
												value="${fieldValue(bean:officeInstance,field:'addressLine1')}" />
											<label>*</label>Office Address
											
											</td>
										</tr>
			
										<tr class="prop">
											<td colspan="2 valign="
												top" class="value ${hasErrors(bean:officeInstance,field:'city','errors')}">
											<input type="text" maxlength="64" size="40" name="city" class='office'
												value="${fieldValue(bean:officeInstance,field:'city')}" />
											<label>*</label> Office City:
											</td>
										</tr>
			
										<tr class="prop">
											<td valign="top"
												class="value ${hasErrors(bean:officeInstance,field:'state','errors')}">
											<br/><label>*</label>  State<br/>
											<g:select id="state" name="state"
												from="${(new Office()).constraints.state.inList}"
												value="${fieldValue(bean:officeInstance,field:'state')}"></g:select>
											</td>
											<td valign="top" style="text-align: left;"
												class="value ${hasErrors(bean:officeInstance,field:'zipcode','errors')}">
											<br/><label>*</label>  ZIP Code<br/>
											<input type="text" maxlength="5" size="30" name="zipcode"
												value="${fieldValue(bean:officeInstance,field:'zipcode')}" /></td>
										</tr>
									</table>
									</td>
			
								</tr>
							</tbody>
						</table>
                </div>

               </form>
        </div>
