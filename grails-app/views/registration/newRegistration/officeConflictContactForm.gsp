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
             <img style="padding-top: 30px 0px;"  src="/images/itd/reg/register_progress1.png" class="center"/>
        </div>

        <div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${commentCommand}">
            <div class="errors">
                <g:renderErrors bean="${commentCommand}" as="list" />
            </div>
            </g:hasErrors>
            
            <%-- begin --%>
            <g:form action="newRegistration" method="post" >
                <div >
                    <table>
                        <tbody>
							<tr>
								<td width="100%">
									<table>   <%-- nest table --%>                     
						            <tr class="prop">
						                <td valign="top" class="value">
						                    <h2>
						                        Territory Conflicts Contact
						                    </h2><br/>
						                    <p style="padding-top: 7px; font-weight: bold">Please tell us your contact information.</p> 
						                </td>
						            </tr>                             
						            <tr class="prop">
						                <td valign="top" class="value">
						                     <label>(*) indicates required field</label>
						                </td>
						            </tr>                             
		                        
		                        
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:commentCommand,field:'name','errors')}">
		                                    <label for="name">* Your Name:</label><br/>
		                                    <input type="text" maxlength="128" size="40" name='name'
		                                    value="${fieldValue(bean:commentCommand,field:'name')}"/>
		                                </td>
		                            </tr> 
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:commentCommand,field:'phone','errors')}">
		                                    <label for="comment">* Your Phone Number:</label><br/>
		                                    <input type="text" maxlength="12" size="40" name='phone' value="${fieldValue(bean:commentCommand,field:'phone')}"/>
		                                </td>
		                            </tr> 
		                            <tr class="prop">
		                                <td valign="top" class="value ${hasErrors(bean:commentCommand,field:'comment','errors')}">
		                                    <label for="comment">* Your Comment:</label><br/>
		                                    <textarea rows='20' cols='80'  name='comment'>${fieldValue(bean:commentCommand,field:'comment')}</textarea>
		                                </td>
		                            </tr> 
		                        
						            <tr class="prop">
						                <td valign="top" >
							                       <g:submitButton name="done" value="" class="done"/>
							             </td>
						            </tr> 
	                               </table>
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
