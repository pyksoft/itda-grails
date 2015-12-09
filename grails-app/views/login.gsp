<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
    def authenticationService = grailsApplication.mainContext.getBean("authenticationService");
	if (authenticationService.isLoggedIn(request)) {
		response.sendRedirect("/myPlanner")
	}
%>
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
	            	<h2 style="margin-left:25px">Welcome!</h2>
            	<div class="transition-bg-short" style="border:solid #cccccc 2px;width:390px; margin:10px" >
	            	<p style="color: #475659; font-size: 14;line-height:110%">
	            	<br/>Type the promo code below and find out how easy<br/>
	            	planning and tracking your marketing can be!<br/></p> 
					<form name="regform" action="/registration/newRegistration" method="post">
						<table><tr>
						<td style="padding: 5px 0px"><input name="promocode" value='${flash.promocode}' type='text'/></td>
					    <td><img onclick="regform.submit();" src="/images/Transparent.gif" class="itda-archive-icon right-arrow-btn" style="margin-top:4px"></td>
						</tr></table>
					    Promo Code<br/> 
					</form>
            	</div>
            	<br/><br/>
            	<div style="padding: 0 0 0 25;">
            	<h2>Already a Member?</h2>
            	<p style="color: #475659; font-size: 14;line-height:110%">
            	Welcome back!<br/><br/></p> 
				<form action="/helper/login" method="post">
				    <input name="login" value='${flash.login}' type='text'/><br/>
				    Username <br/>
				    <input type="password" name="password"/><br/>
				    Password <br/><br/>
				    
				    <input type="image" src="/images/itd/signin_button.jpg" name="submit" 
				    style="padding: 0px; border:0px;">
				</form>
				<br/><br/> 
            	<p style="color: #475659; font-size: 13;line-height:110%">
				<strong>Help.</strong> I forgot my <a href="/registration/resetPassword" style="color:#0076A3;text-decoration:underline">username or password.</a>
				</p>
				</div>           
            </td>
            </tr>
        </table>
        </div>
 <br/><br/><br/><img src="/images/itd/bottom_bar.jpg"/>           
        
    </body>	
</html>
