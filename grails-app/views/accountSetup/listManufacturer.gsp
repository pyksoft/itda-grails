<%@ page import="com.itda.*" %>
<%@page sitemeshPreprocess="false"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    	<gui:resources components="tabView"/>
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
					<img src="/images/itd/nav2/set_up_prog3.jpg"/>
		
		</td></tr></table>
	<div class="body">
            <g:hasErrors bean="${manufacturerInstance}">
            <div class="errors">
                <g:renderErrors bean="${manufacturerInstance}" as="list" />
            </div>
            </g:hasErrors>            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
             <%  flash.message = null;%>
            </g:if>
	<div id="canvas">
	  <div class="line">            
	    <div class="item" id="item1" style="width:33%">
	       <div class="sap-content">
			     <g:include view="accountSetup/manufacturer.gsp"/>
	       </div><%-- item1 sapcontend --%>
	     </div>
	    <div class="item" id="item268">
	        <div class="sap-content">	        
    <div >
 	<ul id="itda-setup-tab-manufacturer">
	    <li><a id="news" href="/accountSetup/listPublication" class="news"></a></li>
	    <li><div id="space"  class="space"></div></li>
	    <li><a id="vendor" href="/accountSetup/listVendor"  class="vendor"></a></li>
	    <li><div id="space"  class="space"></div></li>
	    <li><div id="space-manufacturer" class="space-manufacturer">Manufacturer</div></li>
	    <li><div id="space"  class="space"></div></li>
	    <li><a id="competitor" href="/accountSetup/listCompetitor" class="competitor">Tracker</a></li>
	</ul>
	</div>
	<!--              <img src="/images/itd/manufacturer_tab.png"/> -->
	                
					<table height="600px" width='100%' style="background-image:url('/images/itd/set_up_tab_mid.jpg');
background-repeat:repeat-y;"><tr><td>
                         <br/><br/>
		          	    <g:include view='accountSetup/listManufacturerTabFrag.gsp'/>
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
        