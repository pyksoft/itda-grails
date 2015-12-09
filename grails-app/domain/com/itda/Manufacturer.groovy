package com.itda

import java.io.Serializable;

class Manufacturer implements Serializable {

	//REQUIRED
	String manufacturerName
	String phone
	String contactName
	String contactPhone
	String email
	String alternateEmail
	String address
	String city
	String state
	String zipcode
	Boolean deleted

	static belongsTo = [business:Business]
    
    static constraints = {

		manufacturerName(size:1..128, blank:false)
        phone(matches:"[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", blank:true)        
        contactName(size:1..128, blank:true)
		contactPhone(matches:"[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", blank:true)
        email(email:true, blank:true)
        alternateEmail(email:true, blank:true, nullable:true)
        address(size:1..128, blank:true, nullable:true)
        city(size:1..128, blank:true, nullable:true)
        state(inList:["", "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI",
                      "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", 
                      "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", 
                      "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", 
                      "WV", "WI", "WY"], blank:true, nullable:true)        
        zipcode(matches:"[0-9][0-9][0-9][0-9][0-9]", size:1..5, blank:true, nullable:true)
		deleted(nullable:true)		
    }
	
	static listManufacturers = { businessId -> 
		def listManufacturers  = Manufacturer.findAll("from Manufacturer as p where p.business.id=:bizId", [bizId: businessId])
		return listManufacturers;
	}
	
	public static Manufacturer editManufacturer (long businessId, long id) {
		return Manufacturer.find("from Manufacturer as p where p.id=:id and p.business.id=:bizId", 
		[id:id, bizId: businessId]
		)
	}
		
}
