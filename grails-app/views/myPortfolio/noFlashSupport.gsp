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
      	<g:include view="common/header.gsp"  />
       	  <img style="padding:0px;" src="/images/Transparent.gif" class="center"/>
       </div>
        <div class="body">
            <g:if test="${flash.message}">
            <br/><br/><div class="message">${flash.message}</div>
            </g:if>
			<h2>This page requires Flash and your device does not support Flash.</h2>
			<p style="text-align: left;">
			<br/><a onclick="history.go(-1);" class="acct-link-active">Click here to go back to previous page</a>
			</p>
		</div>            
	</body>
</html>