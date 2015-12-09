<%@ page import="org.json.simple.JSONObject" %>
{
"respText":"${JSONObject.escape(respText)}",
"total":"${total}",
"results":[
<g:each in="${results}" var="it" status="i">
	${i != 0 ? "," : ""}
	{
        "id":"${it.id}",
        "start":"${it.start}",
        "className":"${it.className}",
        "size":"${JSONObject.escape(it.size)}",
        "otherSize":"${JSONObject.escape(it.otherSize)}",
        "color":"${it.color}",
<%--         "vendor.id":"${it.vendor?.id}",
        "publication.id":"${it.publication?.id}",
--%>
        "competitor.id":"${it.competitor?.id}",
        "imageFile":"${JSONObject.escape(it.imageFile)}"
	}
</g:each>
]}