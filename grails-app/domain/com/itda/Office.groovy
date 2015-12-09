package com.itda

class Office implements Serializable {
    //Integer id
    String name
    //String phone
    String addressLine1
    //String addressLine2
    String city
    String state
    String zipcode
    Double lat
    Double lon
    Double upperLeftLat 
    Double upperLeftLon
    Double lowerRightLat
    Double lowerRightLon
    Integer accuracyLevel
    static belongsTo = [business:Business]    
    static hasMany = [advertisingZipcodes:AdvertisingZipcode,territoryZipcodes:String]  
    Double monthlySubscriptionPrice = 100
	String availability = ""
	Boolean deleted;

    static constraints = {
    	
        accuracyLevel(nullable:true, range:1..9)
        monthlySubscriptionPrice(nullable:true, range:0..10000)
        availability(nullable:true)
        lat(nullable:true, range:-90..90, scale:3)
        lon(nullable:true, range:-180..180, scale:3)
        upperLeftLat(nullable:true, range:-90..90, scale:3)
        upperLeftLon(nullable:true, range:-180..180, scale:3)
        lowerRightLat(nullable:true, range:-90..90, scale:3)
        lowerRightLon(nullable:true, range:-180..180, scale:3)
        deleted(nullable:true)
		
        name(size:1..128, blank:false)
        //phone(matches:"[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", blank:false)        
        addressLine1(size:1..128, blank:false)
       // addressLine2(size:1..128, nullable:true)
        city(size:1..128, blank:false)
        state(inList:["", "AL", "AK", "AR", "AZ", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI",
                      "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", 
                      "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", 
                      "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", 
                      "WV", "WI", "WY"], blank:false)        
        zipcode(matches:"[0-9][0-9][0-9][0-9][0-9]", size:1..5, blank:false)

    }

    static query = { office ->
       	def listOfZipcodes = Zipcode.executeQuery("select z.id from Zipcode z where " +
      	       "z.latitude > ? and z.latitude < ? and " +
 					"z.longitude > ? and z.longitude < ?", 
 					[office.lowerRightLat, office.upperLeftLat,office.upperLeftLon , office.lowerRightLon])
    	//listOfZipcodes.each{
       	//	log.error(it.getClass())
       	//}
 					
    	return listOfZipcodes ? listOfZipcodes as ArrayList<Zipcode>: new ArrayList<Zipcode>()
    }
    
    String prettyPrintAddress() {
    	return  addressLine1 + " " +
		 		//addressLine2 + "," +
			 	city + "," +
			 	state + " " + zipcode
    }
	/*
	static exportQuery = { ->  
		String q =     "SELECT " +
		"t.item_id, " +
		"t.item_name, " +
		"t.item_name_cn, " +
		"t.parent_item_id, " +
		"t.fullpath, " +
		"t.active, " +
		"t.metatitle, " +
		"t.metatitle_cn, " +
		"t.metadescription, " +
		"t.metadescription_cn, " +
		"t.keywords, " +
		"t.keywords_cn, " +
		"p.seller_group_id, " +
		"p.brand_id, " +
		"p.smalldescr, " +
		"p.smalldescr_cn, " +
		"p.descr, " +
		"p.descr_cn, " +
		"p.sku, " +
		"p.price " +
		"FROM Treeman as t " +
		"INNER JOIN DtProduct as p " +
		" where t.item_id=p.item_id " +
		//" and t.item_id=3452 " +
		
		"ORDER BY t.parent_item_id ";
		
		def listOfZipcodes = Office.executeQuery(q, [])
		//[office.lowerRightLat, office.upperLeftLat,office.upperLeftLon , 
		//office.lowerRightLon])
		//listOfZipcodes.each{
		//	log.error(it.getClass())
		//}
		
		return listOfZipcodes;
	}
    */	
}
