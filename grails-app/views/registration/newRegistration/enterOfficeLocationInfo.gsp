<%@ page import="com.itda.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>In the Door Advertising</title>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>                
     </head>
    <body>
        <div >
			<g:include view="common/header.gsp"  />
             <img style="padding: 30px 0px;" src="/images/itd/reg/register_progress1.png" class="center"/>
        </div>

        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${officeInstance}">
            <div class="errors">
                <g:renderErrors bean="${officeInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            <%-- begin --%>
            <g:form name="regform" action="newRegistration" method="post" >
                <div>
                    <table>
                        <tbody>
							<tr>
								<td width="33%" style="padding: 0px;">
									<table>   <%-- nest table --%>                     
						            <tr>
						                <td colspan="2" valign="top" style="padding: 0px;" >
						                    <p style="font-size: 40; font-family: arial; line-height: 100%" >
						                    Sign Up
						                    </p><br/>
						                    <p style="padding-top: 7px; font-size: 21; font-family: arial;line-height: 105%">
						                    <g:if test='${editIndex == null}'><strong>Step 1.</strong><br/>
						                    Getting Started...</g:if>
						                    <g:else>
						                         Edit Office Information
						                         <input type="hidden" name="editIndex" value="${editIndex}" />
						                    </g:else>
						                    </p>
						                    <p style="padding-top: 4px; font-weight: bold; color: #475659; font-size: 12;">Please tell us where your offices are.</p> 
						                </td>
						            </tr>                             
						            <tr class="prop">
						                <td colspan="2" valign="top" class="value">
						                	<br/><br/>
						                     <label>(*) indicates required field</label>
						                </td>
						            </tr>                             
		                        
		                            <tr class="prop">
		                                <td colspan="2" valign="top" class="value ${hasErrors(bean:officeInstance,field:'name','errors')}">
		                                    <label for="name">* Office Location Name:</label><br/>
		                                    <input type="text" maxlength="128" size="40" id="name" name="name" value="${fieldValue(bean:officeInstance,field:'name')}"/>
		                                </td>
		                            </tr> 
		                        		                        
		                            <tr class="prop">
		                                <td colspan="2" valign="top" class="value ${hasErrors(bean:officeInstance,field:'addressLine1','errors')}">
		                                    <label for="addressLine1">* Office Address:</label><br/>
		                                    <input type="text" maxlength="128" size="40" id="addressLine1" name="addressLine1" value="${fieldValue(bean:officeInstance,field:'addressLine1')}"/>
		                                </td>
		                            </tr> 
		                        		                        
		                            <tr class="prop">
		                                <td colspan="2" valign="top" class="value ${hasErrors(bean:officeInstance,field:'city','errors')}">
		                                    <label for="city">* Office City:</label><br/>
		                                    <input type="text" maxlength="64" size="40" id="city" name="city" value="${fieldValue(bean:officeInstance,field:'city')}"/>
		                                </td>
		                            </tr> 
		                        
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:officeInstance,field:'state','errors')}">
		                                    <label for="state">* State:</label><br/>
		                                    <g:select id="state" name="state" from="${(new Office()).constraints.state.inList}" value="${fieldValue(bean:officeInstance,field:'state')}" ></g:select>
		                                </td>
		                                <td valign="top" style="text-align: left;" class="value ${hasErrors(bean:officeInstance,field:'zipcode','errors')}">
		                                    <label for="zipcode">* ZIP Code </label><span style="font-weight: bold">xxxxx</span><br/>
		                                    <input type="text" id="zipcode" maxlength="5"  size="30" name="zipcode" value="${fieldValue(bean:officeInstance,field:'zipcode')}"/>
		                                </td>
		                            </tr> 
		                        
						            <tr class="prop">
						                <td colspan="2" valign="top" >
						                		<div>
									            <g:if test='${editIndex}'>
							                       <g:submitButton name="addOffice" value="" class="done"/>
									            </g:if>
									            <g:else>            
							                       <g:submitButton name="addOffice" value="" class="add_office" /><br/>
							                       <g:if test="${officeInstanceList}">
								                       <g:submitButton name="next" value="" class="view_territory"/>
								                   </g:if>
									            </g:else>
							                     </div>
							                     
							             </td>
						
						            </tr> 
	                               </table>
								</td>
								
							<%--	<td><div id="map_canvas" style="width: 100%; height: 400px"></div></td> --%>

							<td>
				            <g:if test="${officeInstanceList}">
            					<p style="font-size: 25; font-family: arial; padding: 10px 0px;">
									Your Offices
								<p/>
					            <div class="list">
					                <table class="table">
					                    <thead>
					                        <tr>
					                   	        <th>Office Location Name</th>
					                   	        <th>Address</th>
					                   	        <th>Action</th>
					                   	        <%-- th>Availability</th --%>
					                        </tr>
					                    </thead>
					                    <tbody>
					                    <g:each in="${officeInstanceList}" status="i" var="officeInstance">
					                        <tr ${(officeInstance?.availability == 'false') ? 'style="background-color:#FFFA92"' : ''} class='last-${(i+1)==officeInstanceList.size}'>
					                        
					                            <td>${fieldValue(bean:officeInstance, field:'name')}</td>
					                        
					                            <td>
					                               	${fieldValue(bean:officeInstance, field:'addressLine1')}<br/>
					                            	${fieldValue(bean:officeInstance, field:'city')}, ${fieldValue(bean:officeInstance, field:'state')} 
					                            	<br/>${fieldValue(bean:officeInstance, field:'zipcode')}
					                            </td>
					                            <td>
					                            
				            <g:form action="newRegistration" method="post" >
				            		<input type="hidden" name="index" value="${i}" />
							                       <g:submitButton name="removeOffice" value="Remove" class="red_link_button"/>&nbsp;|&nbsp;
							                       <g:submitButton name="editOffice" value="Edit" class="red_link_button"/>
							                       
					       </g:form>

					                            </td>
					                            <%-- td>${(officeInstance.availability == 'true') ? 'Available' : 'Unavailable'}</td--%>					                        
					                        </tr>
					                    </g:each>
					                    </tbody>
					                </table>
					            </div>
					            <%-- g:if test='${hasConflict && submitConfictContactForm == null }'>
								<g:form action="newRegistration" method="post" >
									<p style="padding-top: 15px; font-size: 20; font-family: arial">
						             We're sorry one or more of your areas is currently unavailable. 
						                    </p><br/>
							                       <b>Please let us know if you wish to be 
							                       <g:submitButton name="officeConflictContactForm" value="contacted" class="red_link_button"/> 
							                       regarding my territory conflicts.</b>
							                       
					       		</g:form>					            
				                 </g:if--%>
				            </g:if>
				            <g:else>
				            	<div onclick="return false;"><img src="/images/itd/reg/step1-map.png" style="position:relative;top:25px;left:-75px;z-index:-100"></div>
				            </g:else>
						</td>




							</tr>
                        </tbody>
                    </table>
                </div>

            </g:form>
            
        </div>
 <br/><br/><br/><img src="/images/itd/bottom_bar.jpg"/>           
    </body>
</html>
