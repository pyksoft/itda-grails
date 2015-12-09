<%@ page import="org.codehaus.groovy.grails.web.json.JSONObject"%>
{"id":"${pub?.id}","newspaperOrPublicationName":${JSONObject.quote(pub?.newspaperOrPublicationName)},
"contactName": ${JSONObject.quote(pub?.contactName)},"contactPhone": ${JSONObject.quote(pub?.contactPhone)},
"email": "${pub?.email}","publicationPhone": "${pub?.publicationPhone}",
"alternateEmail": "${pub?.alternateEmail}",
"addressLine1":${JSONObject.quote(pub?.addressLine1)},"city":${JSONObject.quote(pub?.city)},
"state":"${pub?.state}","zipcode":"${pub?.zipcode}","respText":"Request completed."}