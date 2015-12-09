<%@ page import="com.itda.*" %>
<%@page sitemeshPreprocess="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    	<%-- gui:resources components="tabView"/--%>
        <title>In the Door Advertising</title>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="stylesheet" href="/css/itda.css" />
        <link rel="stylesheet" href="/css/sap-twocol.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/> 
     </head>
    <body>
		<g:include view="common/header.gsp" params="[controller:params.controller]"/>
		<table class="center"><tr><td>
				<img src="/images/itd/nav2/set_up_prog1.jpg"/>
		
		</td></tr></table>
	<div class="body">
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
	<div id="canvas">
	  <div class="line">            
	    <div class="item" id="item1" style="width:33%">
	       <div class="sap-content">
			   <g:include view="accountSetup/welcome.gsp"/>
	       </div><%-- item1 sapcontend --%>
	     </div>
	    <div class="item" id="item268">
	        <div class="sap-content">	        
	                <img src="/images/itd/publication_tab.jpg"/>
					<table height="600px" width='100%' style="background-image:url('/images/itd/set_up_tab_mid.jpg');
background-repeat:repeat-y;"><tr><td>
		          	    <g:include view='accountSetup/listPublicationTabFrag.gsp'/>
		          </td></tr></table>        	    					   
	                <img src="/images/itd/set_up_tab_bot.jpg"/>
	       </div><%-- item2 sapcontend --%>
		</div><%-- item2  --%>
	  </div><%-- line --%>
	  </div><%-- canvas --%>
    </div>
<br/><br/><br/><img src="/images/itd/bottom_bar.jpg"/>           
    </body>
</html>
        