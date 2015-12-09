<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>In the Door Advertising</title>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
     </head>
    <body style="border:0px;">
        <div>
			<g:include view="common/header.gsp" params="[controller:params.controller]"/>
       	  <img style="padding:0px;" src="/images/Transparent.gif" class="center"/>
       </div>
        <div class="body">
            <g:if test="${flash.message}">
            <br/><br/><div class="message">${flash.message}</div>
            </g:if>
			<g:elseif test="${flash.passwordShort || flash.passwordsMismatch}">
	        <br/><br/>
	            <div class="errors" style="padding-top: 10px">
					${flash.passwordShort}
					${flash.passwordsMismatch}
	            </div>            
            </g:elseif>            
			<g:elseif test="${flash.generalError}">
	        <br/><br/>
	            <div class="errors" style="padding-top: 10px">
					${flash.generalError}
	            </div>            
            </g:elseif>            
        
        <table width="100%">
            <tr>
            <td width="20%">
            	<h1>&nbsp;</h1>
            </td>
            <td width="100%">
            	<h1>Change Password</h1>
            	<p style="padding: 0 0 15 25; color: #475659; font-size: 14;line-height:110%">
				 &nbsp;
				 <br/><br/>


            	<div style="padding: 0 0 0 25;">
				<g:form action="changePassword" controller="registration">
				    Password <br/> <input type="password" name="password"/><br/><br/>
				    New Password <br/> <input type="password" name="newPassword"/><br/><br/>
				    Confirm New Password <br/> <input type="password" name="confirmNewPassword"/><br/><br/>
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
