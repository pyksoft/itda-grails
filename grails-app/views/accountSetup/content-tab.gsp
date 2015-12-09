<div id="tabs">
    <ul>
        <li>
        	<%-- URI for fragment of active tab and URI for page of inactive tab --%>
        	<a href="${actionName.endsWith('Publication') ? '/accountSetup/listPublicationTabFrag' : '/accountSetup/listPublication'}">
        	<span>Newspapers/Publications</span></a>
        </li>
        <li>
        	<a href="${actionName.endsWith('Vendor') ? '/accountSetup/listVendorTabFrag' : '/accountSetup/listVendor'}">
        	<span>Vendors</span></a>
        </li>
        <li>
        	<a href="${actionName.endsWith('Manufacturer') ? '/accountSetup/listManufacturerTabFrag' : '/accountSetup/listManufacturer'}">
        	<span>Manufacturers</span></a>
        </li>
        <li>
        	<a href="${actionName.endsWith('Competitor') ? '/accountSetup/listCompetitorTabFrag' : '/accountSetup/listCompetitor'}">
        	<span>Competitors</span></a>
        </li>
    </ul>
	
	<%-- g:if test="${actionName.endsWith('Publication')}">
	    <div id="newspapers">
		          <table height="600px" width='100%'><tr><td>
		          	    <g:include view='accountSetup/listPublicationTabFrag.gsp'/>
		          </td></tr></table>
	    </div>
	</g:if>   
	<g:else>
	    <div id="newspapers">
	    </div>
	</g:else>

	<g:if test="${actionName.endsWith('Vendor')}">
	    <div id="vendor">
		          <table height="600px" width='100%'><tr><td>
		          	    <g:include view='accountSetup/listVendorTabFrag.gsp'/>
		          </td></tr></table>
	    </div>
	</g:if>   
	<g:else>
	    <div id="vendor">
	    </div>
	</g:else>

	<g:if test="${actionName.endsWith('Manufacturer')}">
	    <div id="Manufacturer">
		          <table height="600px" width='100%'><tr><td>
		          	    <g:include view='accountSetup/listManufacturerTabFrag.gsp'/>
		          </td></tr></table>
	    </div>
	</g:if>   
	<g:else>
	    <div id="Manufacturer">
	    </div>
	</g:else>

	<g:if test="${actionName.endsWith('Competitor')}">
	    <div id="Competitor">
		          <table height="600px" width='100%'><tr><td>
		          	    <g:include view='accountSetup/listCompetitorTabFrag.gsp'/>
		          </td></tr></table>
	    </div>
	</g:if>   
	<g:else>
	    <div id="Competitor">
	    </div>
	</g:else--%>
</div>
		   