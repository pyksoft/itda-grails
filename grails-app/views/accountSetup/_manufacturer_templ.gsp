<%@ page import="org.codehaus.groovy.grails.web.json.JSONObject"%>
{"id":"${manu?.id}","manufacturerName":${JSONObject.quote(manu.manufacturerName)},
"phone": "${manu.phone}","contactName":${JSONObject.quote(manu?.contactName)},"contactPhone":"${manu?.contactPhone}",
"email":"${manu?.email}","alternateEmail":"${manu?.alternateEmail}","address":${JSONObject.quote(manu?.address)},
"city":${JSONObject.quote(manu?.city)},"state":"${manu?.state}",
"zipcode":"${manu?.zipcode}","respText":"Request completed."}