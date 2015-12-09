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
        <link href="/css/jquery-ui-1.8.2.custom.css" rel="stylesheet" type="text/css"/>
  		<script src="/plugins/jquery-1.4.2.5/js/jquery/jquery-1.4.2-min.js"></script>
  		<script src="/plugins/jquery-ui-1.8.2.4/jquery-ui/js/jquery-ui-1.8.2.custom.min.js"></script>
        <script>
		  $(document).ready(function() {
			<g:if test="${actionName.endsWith('Manufacturer')}">
				$( "#tabs" ).tabs({ selected: 2 });	
			</g:if>   
			<g:elseif test="${actionName.endsWith('Competitor')}">
				$( "#tabs" ).tabs({ selected: 3 });	
			</g:elseif>   
			<g:elseif test="${actionName.endsWith('Vendor')}">
				$( "#tabs" ).tabs({ selected: 1 });	
			</g:elseif>   
			
			  $('#tabs').tabs({
				    select: function(event, ui) {
				        var url = $.data(ui.tab, 'load.tabs');
				        if( url ) {
				            location.href = url;
				            return false;
				        }
				        return true;
				    }
				});
		  });
	  
  		</script>    
     </head>
    <body>
		<g:include view="common/header.gsp" params="[controller:params.controller]"/>
		<table class="center"><tr><td>

				<g:if test="${actionName.endsWith('Vendor')}">
					<img src="/images/itd/nav2/set_up_prog2.jpg"/>				
				</g:if>

				<g:elseif test="${actionName.endsWith('Manufacturer')}">
					<img src="/images/itd/nav2/set_up_prog3.jpg"/>
				</g:elseif>

				<g:elseif test="${actionName.endsWith('Competitor')}">
					<img src="/images/itd/nav2/set_up_prog4.jpg"/>
				</g:elseif>
				<g:else>
					<img src="/images/itd/nav2/set_up_prog1.jpg"/>
				</g:else>   
		
		</td></tr></table>
	<div class="body">
            <g:hasErrors bean="${publicationInstance}">
            <div class="errors">
                <g:renderErrors bean="${publicationInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            <g:hasErrors bean="${manufacturerInstance}">
            <div class="errors">
                <g:renderErrors bean="${manufacturerInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            <g:hasErrors bean="${vendorInstance}">
            <div class="errors">
                <g:renderErrors bean="${vendorInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            <g:hasErrors bean="${competitorInstance}">
            <div class="errors">
                <g:renderErrors bean="${competitorInstance}" as="list" />
            </div>
            </g:hasErrors>
            
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
	<div id="canvas">
	  <div class="line">            
	    <div class="item" id="item1" style="width:33%">
	       <div class="sap-content">
	       
			<g:if test="${actionName.endsWith('Publication')}">	
			     <g:include view="accountSetup/publication.gsp"/>
			</g:if>
			   
			<g:elseif test="${actionName.endsWith('Manufacturer')}">
				<g:include view="accountSetup/manufacturer.gsp"/>
			</g:elseif>
			
			<g:elseif test="${actionName.endsWith('Competitor')}">
				<g:include view="accountSetup/competitor.gsp"/>
			</g:elseif>
			
			<g:elseif test="${actionName.endsWith('Vendor')}">
				<g:include view="accountSetup/vendor.gsp"/>
			</g:elseif>
			
			<g:else>
			   <g:include view="accountSetup/welcome.gsp"/>
			</g:else>
			
	       </div><%-- item1 sapcontend --%>
	     </div>
	    <div class="item" id="item2">
	        <div class="sap-content">	        
	        	<%-- div class="yui-skin-sam"--%>
        	    		<g:include view="accountSetup/content-tab.gsp"/>				   
	         <%--/div--%>
	       </div><%-- item2 sapcontend --%>
		</div><%-- item2  --%>
	  </div><%-- line --%>
	  </div><%-- canvas --%>
    </div>
<br/><br/><br/><img src="/images/itd/bottom_bar.jpg"/>           
    </body>
</html>
        