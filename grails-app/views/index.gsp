          <auth:ifNotLoggedIn>
            <% response.sendRedirect("http://www.inthedooradvertising.com/?login=false"); %>
          </auth:ifNotLoggedIn>
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
			<g:include view="common/header.gsp" params="[controller:'accountSetup']"/>
          <%--
          <div style="float:left"></div>
       		--%>
       	  <img style="padding:0px;" src="/images/Transparent.gif" class="center"/>
       </div>
        <div class="body">
            <g:if test="${flash.message}">
            <br/><br/><div class="message">${flash.message}</div>
            </g:if>
			<g:if test="${flash.authenticationFailure}">
	        <br/><br/>
	            <div class="errors" style="padding-top: 10px">
					Login failed: ${message(code:"authentication.failure."+flash.authenticationFailure.result).encodeAsHTML()}
	            </div>            
            </g:if>            
        
        <table width="100%">
            <tr>
            <auth:ifNotLoggedIn>
            <td>
            	<h1>&nbsp;</h1>
				<g:form action="login" controller="helper">
				    Username: <g:textField name="login" value='${flash.login}'/><br/>
				    Password: <input type="password" name="password"/><br/>
				    <input type="submit" value="Log In"/>
				</g:form>            
            </td>
            </auth:ifNotLoggedIn>
            <g:if test='${auth.user() != "itdaweb.admin" && auth.user() != "eportfolio.admin"}'>
            <td width="100%">
            	<h1>Marketing Portfolios</h1>
	            <div class="list">
	                <table width="100%">
	                    <thead>
	                        <tr>
	                   	        <th  >Title</th>
	                   	        <th  >Link</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                        <tr >
	                            <td>Current Portfolio</td>
	                            <td><a href="/myPortfolio/current" class="normal">View Current Portfolio</a></td>
	                        </tr>
	                    <tbody>
	                </table>
	            </div>
            </td>
            </g:if>
            <g:else>
               <auth:ifLoggedIn>
            	<% response.sendRedirect("/portfolio/list"); %>
               </auth:ifLoggedIn>
            <%-- 
		        <div class="left-element dialog" style="margin-left:20px;width:60%;">
		        
		            <h1>Administration Console</h1>
		            <ul>
		              <g:each var="c" in="${grailsApplication.controllerClasses}">
		                   <!-- a
		                   <g:if test='${c.fullName.contains(".itda.") 
		                   	&& c.logicalPropertyName != "accountSetup" 
		                   	&& c.logicalPropertyName != "helper"  
		                   	&& c.logicalPropertyName != "registration"  
		                   	&& c.logicalPropertyName != "zipcode"}'>
		                   	-->
		                    <li style='text-align:left'><g:link controller="${c.logicalPropertyName}">${c.fullName}</g:link></li>
		                   <!--
		                   </g:if>
		                   -->
		              </g:each>
		            </ul>
		        </div>
            --%>
            </g:else>
            </tr>
        </table>
        </div>
    </body>	
</html>
