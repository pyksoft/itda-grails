<%@ page import="org.codehaus.groovy.grails.web.json.JSONObject"%>[
<g:each in="${reviews}" var="it" status="i">${i != 0 ? "," : ""}
{
"id":"${it.id}",
"lastUpdated":"${it.lastUpdated}",
"runDate":"${it.runDate}",
"notHelpfulCount":"${it.notHelpfulCount}",
"helpfulCount":"${it.helpfulCount}",
"review":${JSONObject.quote(it.review)},
"rating":"${it.rating}",
"numberCompetitiveAd":"${it.numberCompetitiveAd}",
"title":"${it.title}",
"placement":"${it.placement}"
<g:if test='${it.publishTestsSet}'>
,"testsSet":"${it.testsSet}"
</g:if>
<g:if test='${it.publishTestsSold}'>
,"testsSold":"${it.testsSold}"
</g:if>
<g:if test='${it.publishHearingAidsSold}'>
,"hearingAidsSold":"${it.hearingAidsSold}"
</g:if>
<g:if test='${it.publishCalls}'>
,"calls":"${it.calls}"
</g:if>
<g:if test='${it.publishTestedNotSold}'>
,"testedNotSold":"${it.testedNotSold}"
</g:if>
<g:if test='${it.publishGrossSales}'>
,"grossSales":"${it.grossSales}"
</g:if>
<g:if test='${it.publishReturnOnInvest}'>
,"returnOnInvest":"${it.returnOnInvest}"
</g:if>
<g:if test='${it.publishCostPerLead}'>
,"costPerLead":"${it.costPerLead}"   
</g:if>
<g:if test='${it.publishCostPerSale}'>
,"costPerSale":"${it.costPerSale}"   
</g:if>
<g:if test='${it.business.id == bizId}'>
,"myReview":"1"   
</g:if>
}</g:each>]