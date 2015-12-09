<%@ page import="org.codehaus.groovy.grails.web.json.JSONObject"%>
{"payment":
	{
		"ads":[
		<g:each in="${payment?.orderItems}" var="it" status="i">
		${i != 0 ? "," : ""}
		{
			"id":${it.item.id}
		}
		</g:each>]	
	}
}