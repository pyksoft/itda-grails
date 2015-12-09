<%@ page import="org.codehaus.groovy.grails.web.json.JSONObject"%>
{"id":"${office?.id}","name":${JSONObject.quote(office?.name)},
"addressLine1": ${JSONObject.quote(office?.addressLine1)},
"city":${JSONObject.quote(office?.city)},"state":"${office?.state}",
"zipcode":"${office?.zipcode}","respText":"Request completed."}