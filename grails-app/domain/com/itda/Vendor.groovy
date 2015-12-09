package com.itda

import java.io.Serializable;

class Vendor implements Serializable {

	//REQUIRED
	String vendorName
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

		vendorName(size:1..128, blank:false)
        phone(matches:"[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", blank:true, nullable:true)        
        contactName(size:1..128, blank:false)
		contactPhone(matches:"[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", blank:true, nullable:true)
        email(email:true, blank:false)
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
	
	static listVendors = { businessId -> 
		def listVendors  = Vendor.findAll("from Vendor as p where p.business.id=:bizId", [bizId: businessId])
		return listVendors;
	}
	
	public static Vendor editVendor (long businessId, long id) {
		return Vendor.find("from Vendor as p where p.id=:id and p.business.id=:bizId", 
		[id:id, bizId: businessId]
		)
	}
		
}
