<html>
    <head>
        <title>In the Door Advertising</title>
        <link rel="stylesheet" href="/css/main.css" />
        <link rel="shortcut icon" href="/images/favicon.ico" type="image/x-icon" />
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
     </head>
    <body style="border: 0px;">
       <div class="body" style="margin:0 auto">
       <%
   	response.setHeader("Pragma", "")
	//response.setHeader("Cache-Control", "private")
	Calendar cal = Calendar.getInstance()
	cal.add(Calendar.DAY_OF_YEAR,2)
	response.setDateHeader("Expires", cal.getTimeInMillis())       
       %>
          
          <map name="map1">
          	<area shape="rect" title="login" coords="795,165,832,179" href="login.gsp" />
          	<area shape="rect" title="login" coords="707,186,867,240" href="registration" />
		   </map>
          <img src="/wordpress/home.jpg" usemap="#map1" style="border: 0px;"></img>
          
        </div>
    </body>	
</html>
