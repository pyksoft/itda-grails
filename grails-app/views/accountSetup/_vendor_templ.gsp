<%@ page import="org.codehaus.groovy.grails.web.json.JSONObject"%>
{"id":"${vendor?.id}","vendorName":${JSONObject.quote(vendor.vendorName)},
"contactName":${JSONObject.quote(vendor?.contactName)},"contactPhone":${JSONObject.quote(vendor?.contactPhone)},
"email":"${vendor?.email}","address":${JSONObject.quote(vendor?.address)},"city":${JSONObject.quote(vendor?.city)},
"state":"${vendor?.state}","zipcode":"${vendor?.zipcode}",
"alternateEmail":"${vendor?.alternateEmail}","respText":"Request completed."}