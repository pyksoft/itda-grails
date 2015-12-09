<%@ page contentType="text/html" %>
<body>
	<div style="background-image: url('http://www.inthedooradvertising.net/images/itd/planner/itda-planner-leather.jpg'); background-repeat: repeat; border: 10px solid transparent;border-radius:10px">
		<div>
			<div style="background-image: url('http://www.inthedooradvertising.net/images/itd/myAccount/pagebg_20_500.jpg'); background-position: 0px 0px; background-repeat: repeat; border: 8px solid transparent;">
				<div style="background:#FFFFFF; border:1px solid #B69A2F; text-align:center;">
					<img src="http://www.inthedooradvertising.net/images/itd/reg/itda_logo.jpg" style="width:261px;height:84px; border:15px solid transparent"/>
					<br/><br/>
					<div style="font:bold 28px arial,sans-serif;width:100%">You have a deadline coming up soon!</div>
					<br/><br/>
					<img src="http://www.inthedooradvertising.net/images/clock.png"/>
					<%--
					<img src="http://localhost:8080/images/clock.png"/>
					--%>
					<br/><br/>
					<div style="font:25px arial,sans-serif;width:100%;padding-top:20px">
						You have set a deadline for<br/>
						<g:formatDate format="EEEE, MMMM dd, yyyy" date="${deadline}" />
					</div>
					<br/><br/><br/>
					<a href='http://www.inthedooradvertising.net/helper/login'><img src="http://www.inthedooradvertising.net/images/login-btn.png"/></a>
					
					<%--
					<img src="http://localhost:8080/images/login-btn.png"/>
					--%>
					<br/><br/><br/>
				</div>
			</div>
			<img src="http://www.inthedooradvertising.net/images/color-bar-574-22.png" style="width:100%"/>
					<%--
			<img src="http://localhost:8080/images/color-bar-574-22.png" style="width:100%"/>
					--%>
		</div>
	</div>
</body>