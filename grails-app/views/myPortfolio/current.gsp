<html>
<head>
<title>In the Door Advertising</title>
<link rel="stylesheet" href="/css/itda.css" />
</head>
<body style="background: #83847c; height:670px margin: auto; text-align: center; border: 0px solid red;">
<!-- begin actual content -->
<div style="width:950px;  ;margin-left: auto ; margin-right: auto ; border: 0px solid green;">
<table>

	<tbody>
		<tr>
			<td style="height: 30px;" colspan="2"></td>
		</tr>
		<tr>
		    <td width='680px'></td>
			<td>
			<a href='/myPlanner' class='portfolio'>home&nbsp;&nbsp;&nbsp;</a>
			<a href='/helper/logout' class='portfolio'>logout&nbsp;&nbsp;&nbsp;</a>
			<%-- <a href='#' class='portfolio'>contact&nbsp;&nbsp;&nbsp;</a>
			<a href='#' class='portfolio'>help</a>
			--%>
			<br/></td>
		</tr>
		<tr>
			<td class="centered_text" colspan="2">
			<div id="flashcontent"
				style="height: 670px; color: rgb(226, 226, 226);">
				<embed
				type="application/x-shockwave-flash"
				src="/myPortfolio/ePortfolio" id="portfolio" align="center"
				<%--src="portfolio.swf" id="portfolio" align="center"--%>
				name="portfolio" bgcolor="#FFFFFF" quality="high"
				wmode="transparent" height="670" width="960"/>
			</div>
			<script type="text/javascript" src="/js/swfobject.js"></script>
			<script type="text/javascript">
				var _so = new SWFObject("/myPortfolio/ePortfolio","portfolio","960","670","0","#83847c;");
				_so.addParam("wmode","transparent");
				_so.addParam("align","middle");
	            <g:if test='${auth.user() == "itdaweb.admin" || auth.user() == "portfolio.admin"}'>
				_so.addParam("flashvars","portfolioId=${portfolioInstance.id}");
				</g:if>								
				_so.write("flashcontent");
				</script>
			</td>
		</tr>
	</tbody>
</table>
</div>
<!-- end actual content -->

</body>
</html>