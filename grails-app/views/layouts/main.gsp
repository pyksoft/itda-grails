<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <title><g:layoutTitle default="In the Door Advertising" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="stylesheet" href="${resource(dir:'css',file:'itda.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
    </head>
    <body onload="${pageProperty(name:'body.onload')}" onunload="${pageProperty(name:'body.onunload')} style="${pageProperty(name:'body.style')}">
        <div id="spinner" class="spinner" style="display:none;">
            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="Spinner" />
        </div>	
        <div class="logo">
		<g:if test='${auth.user() == "itdaweb.admin" || auth.user() == "eportfolio.admin"}'><br/><br/><br/><br/>
				<table width="100%"><tr><td witdth="70%">&nbsp;</td>
					<td width="30%">
					    <a href='/registration/changePassword' class="normal">Change&nbsp;Password</a>&nbsp;&nbsp;&nbsp;&nbsp;
						<a href='/helper/logout' class="normal">Logout</a>
				    </td></tr></table>
		</g:if>  
        </div> 
        <g:layoutBody />		
    </body>	
</html>