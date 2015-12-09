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

<table width="100%"><tr><td>

<div>
You must agree to the following terms to download this file.
<br/><br/> 
<g:if test="${entry.plannerEntry.portfolioEntry}">
The file you are about to download has been produced by In-the-Door Advertising LLC. 
Every element you see, hear or read, is protected by copyright, trademark and intellectual 
property rights laws. Our customer, ${biz?.businessName} is granted exclusive rights to use 
this file within their marketing area. This means you may not copy, reproduce or modify this
file for anyone other than Heritage Hearing Centers.
<br/><br/> 
</g:if>
The instructions for changing the file are included in this email. Any questions you have 
should go through a ${biz?.businessName} representative, as should the final proof.
<br/><br/> 
Please note: Any product photos contained in this file are the intellectual property of 
the manufacturer who supplied them and are provided for the sole purpose of promoting their 
products. If another manufacturer’s product is to be substituted, please replace the photos 
with images of the selected product. If you do not have the new images, you may contact 
${biz?.businessName} for the correct ones.
</div>

<br/><br/>
<form method="post">
<input type="checkbox" name="termsUuid" value="${entry.termsUuid}"/> I ACCEPT.
<%--
<input type="hidden" name="uuid" value="${entry.uuid}"/>
<input type="hidden" name="fileType" value="pdf"/>
 --%>
<br/><br/>
<input type="submit" name="Download" value="Download"/> 
</form>
<br/><br/>Copyright 2013 In the Door Advertising.  All rights reserved  
</td></tr></table>

<br/><br/><br/><img src="/images/itd/bottom_bar.jpg"/>           
        
    </body>	
</html>
