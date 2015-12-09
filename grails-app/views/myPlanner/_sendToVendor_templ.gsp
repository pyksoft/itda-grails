<%@ page import="org.json.simple.JSONObject" %>
{"entry":{"id":"${plannerEntryId}","changeAddressFlag":"${entry?.changeAddressFlag}","changeDatesFlag": "${entry?.changeDatesFlag}",
"changeExpireDatesFlag":"${entry?.changeExpireDatesFlag}","changeLogoFlag":"${entry?.changeLogoFlag}","changeOffersFlag":"${entry?.changeOffersFlag}","changePhoneFlag":"${entry?.changePhoneFlag}",
"dates":"${entry?.dates ? JSONObject.escape(entry.dates) : ''}",
"expireDates":"${entry?.expireDates ? JSONObject.escape(entry.expireDates): ''}",
"offers":"${entry?.offers ? JSONObject.escape(entry.offers) : ''}",
"phone":"${entry?.phone ? JSONObject.escape(entry.phone) : ''}",
"subject":"${entry?.subject ? JSONObject.escape(entry.subject) : ''}",
"logo":"${entry?.logo ? JSONObject.escape(entry.logo) : ''}",
"address":"${entry?.address ? JSONObject.escape(entry.address) : ''}",
"toEmail":"${entry?.toEmail ? JSONObject.escape(entry.toEmail) : ''}",
"notes":"${entry?.notes ? JSONObject.escape(entry.notes) : ''}"}, 
"respText":"${JSONObject.escape(respText)}"}