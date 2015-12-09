package com.itda
import java.io.Serializable;

class Publication implements Serializable {

	//REQUIRED
	String newspaperOrPublicationName
	String contactName
	String contactPhone
	String email
	//String fullRun 
	//String zoneName

	String addressLine1
	//String addressLine2
	String city
	String state
	String zipcode
	//OPTIONAL	
	String publicationPhone
	String alternateEmail
	Boolean deleted
		
	static belongsTo = [business:Business]
    
    static constraints = {

		newspaperOrPublicationName(size:1..128, blank:false)
		publicationPhone(matches:"[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", blank:true, nullable:true)
        contactName(size:1..128, blank:false)
		contactPhone(matches:"[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", blank:true, nullable:true)
		email(email:true, blank:false)
		alternateEmail(email:true, blank:true, nullable:true)
        //fullRun(inList:["", "Yes", "No"], blank:false)
        //zoneName(size:1..128, blank:false)
        addressLine1(size:1..128, blank:true, nullable:true)
        //addressLine2(size:1..128, blank:true, nullable:true)
        city(size:1..128, blank:true, nullable:true)
        state(inList:["", "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI",
                      "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", 
                      "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", 
                      "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", 
                      "WV", "WI", "WY"], blank:true, nullable:true)        
        zipcode(matches:"[0-9][0-9][0-9][0-9][0-9]", size:1..5, blank:true, nullable:true)	
		deleted(nullable:true)	
    }
	
	static listPub = { businessId -> 
		def listOfPublications  = Publication.findAll("from Publication as p where p.business.id=:bizId", [bizId: businessId])
		return listOfPublications;
	}
	
    public static Publication editPub (long businessId, long id) {
		return Publication.find("from Publication as p where p.id=:id and p.business.id=:bizId", 
				[id:id, bizId: businessId]
		)
	}
}
