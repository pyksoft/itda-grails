<div class="logo">
<auth:ifLoggedIn><br/><br/><br/><br/>
		<table width="1017px"><tr>
			<td>
				<span style='float:right'>&nbsp;&nbsp;&nbsp;&nbsp;<a href='/helper/logout' class="normal">Logout</a></span>
			    <span style='float:right'>&nbsp;&nbsp;&nbsp;&nbsp;<a href="http://www.inthedooradvertising.com/contact-us/${(promoCode != null) ? promoCode : '' }" class="normal">Contact Us</a></span>
			    <span style='float:right'>&nbsp;&nbsp;&nbsp;&nbsp;<a href='/accountSetup/myAccount' class="normal">My Account</a></span>
		    </td></tr></table>
</auth:ifLoggedIn>    
</div> 
<div>
<auth:ifLoggedIn>
 	<ul id="itda-menu2">
		<li><a id="greybar2"  class="greyBar2"></a></li>
	    <li><a id="home2" href="/store" class="home2 ${params.controller == 'store' ? 'itda-nav-active' : '' }">Home</a></li>
	    <li><a id="archive2" href="/archive" class="archive2 ${params.controller == 'archive' ? 'itda-nav-active' : '' }">Archive</a></li>
	    <li><a id="planner2" href="/myPlanner" class="planner2 ${params.controller == 'myPlanner' || params.controller == 'myReport' ? 'itda-nav-active' : '' }">Planner</a></li>
	    <li><a id="tracker2" href="/myTracker" class="tracker2 ${params.controller == 'myTracker' ? 'itda-nav-active' : '' }">Tracker</a></li>
	    <li><a id="blog2" href="http://www.inthedooradvertising.com/blog-2/" class="blog2">Inspiration</a></li>
	</ul>
</auth:ifLoggedIn>    
<auth:ifNotLoggedIn>
 	<ul id="itda-menu">
		<li><a id="home" href="http://www.inthedooradvertising.com/?login=false" class="home">Home</a></li>
	    <li><a id="aboutus" href="http://www.inthedooradvertising.com/about-us-2/?login=false" class="about">About Us</a></li>
	    <li><a id="tour" href="http://www.inthedooradvertising.com/tour/?login=false" class="tour">Tour</a></li>
	    <li><a id="pricing" href="http://www.inthedooradvertising.com/pricing-2/?login=false" class="pricing">Pricing</a></li>
	    <li><a id="signup" href="/registration/${(promoCode != null) ? "newRegistration?promocode="+promoCode : '' }" class="signup">Sign Up</a></li>
	    <li><a id="blog" href="http://www.inthedooradvertising.com/blog-2/?login=false" class="blog">Blog</a></li>
	</ul>
</auth:ifNotLoggedIn>    
</div>		