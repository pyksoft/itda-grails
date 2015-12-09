<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title>In the Door Advertising</title>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
     </head>
    <body style="border:0px;">
        <div>
        <img src="/images/itd/nav/mkt_second_top_clean.jpg"/>
		<img src="/images/itd/bottom_bar.jpg"/> <br/>          
       </div>
        <div class="body">
            <g:if test="${flash.message}">
            <br/><br/><div class="message">${flash.message}</div>
            </g:if>
			<g:if test="${flash.authenticationFailure}">
	        <br/><br/>
	            <div class="errors" style="padding-top: 10px">
					The user name or password you entered is incorrect.
	            </div>            
            </g:if>            
        
        <table width="100%">
            <tr>
            <td width="20%">
            	<h1>&nbsp;</h1>
            </td>
            <td width="100%">
            	<h1>Reset Password</h1>
            	<p style="padding: 0 0 15 25; color: #475659; font-size: 14;line-height:110%">
To reset your password, enter your email address.<br/> 
A confirmation email will be sent to your account<br/> 
with your temporary password.
            	<br/><br/>
            	<div style="padding: 0 0 0 25;">
				<g:form action="resetPassword" controller="registration">
				    Email <br/> <g:textField name="email" value='${flash.email}'/><br/>			    
				    <g:submitButton name="done" value="" class="done"/>
				</g:form>
				</div>           
            </td>
            </tr>
        </table>
        </div>
 <br/><br/><br/><img src="/images/itd/bottom_bar.jpg"/>           
        
    </body>	
</html>
