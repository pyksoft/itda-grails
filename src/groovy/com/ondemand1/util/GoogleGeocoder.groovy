package com.ondemand1.util;
import java.net.URLEncoder;
//import javax.servlet.http.HttpServletResponse;
class GoogleGeocoder {

	public static final String G_GEO_SUCCESS 				= 200;
	public static final String G_GEO_SERVER_ERROR 			= 500;
	public static final String G_GEO_MISSING_QUERY 			= 601;
	public static final String G_GEO_UNKNOWN_ADDRESS 		= 602;
	public static final String G_GEO_UNAVAILABLE_ADDRESS 	= 603;
	public static final String G_GEO_BAD_KEY 				= 610;
	public static final String G_GEO_TOO_MANY_QUERIES		= 620;

	public static final int G_ACCURACY_LEVEL_POSTAL_CODE		= 5;

	/**
	  Returned in the csv format consists of four numbers, separated by commas:
	  HTTP status code
	  accuracy (See Geocoding Accuracy below)
	  latitude
	  longitude
	**/
    public String[] geocode(String address, String key) {
    	//boolean a = true;
    	//if (a)
    	//	return ["200", "5", "89.000", "87.000" ];
        def base = "http://maps.google.com/maps/geo?output=csv&oe=utf8&sensor=false&gl=US&q="
        base += URLEncoder.encode(address) 
        if (key != null)
            base += "&key=" + URLEncoder.encode(key);
        def url = new URL(base)
        def connection = url.openConnection()

        if(connection.responseCode !=  200){
          return [Integer.toString(1000 + connection.responseCode), "", "", ""]
      }
        def csv = connection.content.text
        return csv.split(',')
    }

	public String getErrorMessageProp(errorCode){
       switch(errorCode){
       		case G_GEO_UNKNOWN_ADDRESS:
  	   			return "google.geocode.unknown.address"
  	   			
		   case G_GEO_UNAVAILABLE_ADDRESS:
		  	   return "google.geocode.unavailable.address"
		  	   
		   case G_GEO_BAD_KEY:
			  return  "google.geocode.bad.key"
			  
		   case G_GEO_TOO_MANY_QUERIES:
			   return "google.geocode.too.many.query"
			   
		   case G_GEO_SERVER_ERROR:
			   return "google.geocode.server.error"
			   
		   case G_GEO_MISSING_QUERY:
			   return "google.geocode.missing.query"
			   
		   default: // > 1000 (1000 + http error code)
			   return "google.geocode.unknown.error"	
       }
	}
}

/******************************************************************************
Error code reference

200	G_GEO_SUCCESS	 No errors occurred; the address was successfully parsed and its geocode was returned.

500	G_GEO_SERVER_ERROR	 A geocoding or directions request could not be successfully processed, yet the exact reason for the failure is unknown.

601	G_GEO_MISSING_QUERY	 An empty address was specified in the HTTP q parameter.

602	G_GEO_UNKNOWN_ADDRESS	 No corresponding geographic location could be found for the specified address, possibly because the address is relatively new, or because it may be incorrect.

603	G_GEO_UNAVAILABLE_ADDRESS	 The geocode for the given address or the route for the given directions query cannot be returned due to legal or contractual reasons.

610	G_GEO_BAD_KEY	 The given key is either invalid or does not match the domain for which it was given.

620	G_GEO_TOO_MANY_QUERIES	 The given key has gone over the requests limit in the 24 hour period or has submitted too many requests in too short a period of time. If you're sending multiple requests in parallel or in a tight loop, use a timer or pause in your code to make sure you don't send the requests too quickly.	
	

Accuracy Value	Description
0	Unknown accuracy.
1	Country level accuracy.
2	Region (state, province, prefecture, etc.) level accuracy.
3	Sub-region (county, municipality, etc.) level accuracy.
4	Town (city, village) level accuracy.
5	Post code (zip code) level accuracy.
6	Street level accuracy.
7	Intersection level accuracy.
8	Address level accuracy.
9	Premise (building name, property name, shopping center, etc.) level accuracy.
*******************************************************************************/
