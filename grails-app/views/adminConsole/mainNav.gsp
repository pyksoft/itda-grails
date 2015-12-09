<g:if test='${auth.user() == "itdaweb.admin"}'>
        <div class="nav">
            <span class="menuButton"><g:link controller='business' action="list">Businesses</g:link></span> |
            <span class="menuButton"><g:link controller='office' action="list">Offices</g:link></span> |
            <span class="menuButton"><g:link controller='payment' action="list">Payments</g:link></span> |
            <span class="menuButton"><g:link controller='publication' action="list">Newspapers/Publications</g:link></span> |
            <span class="menuButton"><g:link controller='vendor' action="list">Vendors</g:link></span> |            
            <span class="menuButton"><g:link controller='manufacturer' action="list">Manufacturers</g:link></span> |
            <span class="menuButton"><g:link controller='competitor' action="list">Competitors</g:link></span> |
            <span class="menuButton"><g:link controller='portfolio' action="list">Portfolios</g:link></span> |
            <span class="menuButton"><g:link controller='storeAdmin' action="list">Ad Collections</g:link></span> 
        </div>
</g:if>
<g:elseif test='${auth.user() == "eportfolio.admin"}'>
        <div class="nav">
            <span class="menuButton"><g:link controller='portfolio' action="list">Portfolios</g:link></span> 
            <span class="menuButton"><g:link controller='storeAdmin' action="list">Ads</g:link></span> 
        </div>
</g:elseif>