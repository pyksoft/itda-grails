<%@ page import="org.codehaus.groovy.grails.web.json.JSONObject"%>
{"id":"${comp?.id}","businessName":${JSONObject.quote(comp.businessName)},
"ownerName": ${JSONObject.quote(comp?.ownerName)},
"address":${JSONObject.quote(comp.address)},"city":${JSONObject.quote(comp?.city)},
"state":"${comp?.state}","zipcode":"${comp?.zipcode}","respText":"Request completed."}