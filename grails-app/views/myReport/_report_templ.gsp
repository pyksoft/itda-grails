<%@ page import="org.json.simple.JSONObject" %>{
"respText":"${JSONObject.escape(respText)}",
"total":"${total}",
"results":[
<g:each in="${results}" var="it" status="i">
	${i != 0 ? "," : ""}
	{
        "id":"${it.id}",
        "start":"${it.start}",
        "className":"${it.className}",
        "vendor.id":"${it.vendor?.id}",
        "publication.id":"${it.publication?.id}",
        "office.id":"${it.office?.id}",
        "imageFile":"${JSONObject.escape(it.imageFile)}",
        "size":"${JSONObject.escape(it.size)}",
        "otherSize":"${JSONObject.escape(it.otherSize)}",
        "color":"${it.color}",
        "placement":"${JSONObject.escape(it.placement)}",
        "totalExpense":"${it.totalExpense}",
		"costPerLead":"${it.costPerLead}",        
		"costPerSale":"${it.costPerSale}",        
		"returnOnInvest":"${it.returnOnInvest}",        
        "grossSales":"${it.grossSales}"
        <g:if test="${it.portfolioEntry}">
        ,"portfolioEntry":{
        	"id":"${it.portfolioEntry.id}",
        	"rating":"${it.portfolioEntry.rating}",
        	"numRating":"${it.portfolioEntry.numRating}",
            "color":"${it.portfolioEntry.color}",
            "imageFile":"${JSONObject.escape(it.portfolioEntry.imageFile)}"
            }
        </g:if>
	}
</g:each>
]}