package com.itda
import java.io.Serializable;

class Competitor  implements Serializable{
	//REQUIRED
	String businessName
	String ownerName
	String address
	String city
	String state
	String zipcode
	Boolean deleted

	static belongsTo = [business:Business]
    
    static constraints = {

        businessName(size:1..128, blank:false)
        ownerName(size:1..128, blank:true, nullable:true)
        address(size:1..128, blank:true, nullable:true)
        city(size:1..128, blank:false)
        state(inList:["", "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI",
                      "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", 
                      "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", 
                      "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", 
                      "WV", "WI", "WY"], blank:true, nullable:true)        
        zipcode(matches:"[0-9][0-9][0-9][0-9][0-9]", size:1..5, blank:true, nullable:true)
		deleted(nullable:true)	
    }
	
	static listCompetitors = { businessId -> 
		def listCompetitor  = Competitor.findAll("from Competitor as p where p.business.id=:bizId", [bizId: businessId])
		return listCompetitor;
	}
	
	public static Competitor editCompetitor (long businessId, long id) {
		return Competitor.find("from Competitor as p where p.id=:id and p.business.id=:bizId", 
		[id:id, bizId: businessId]
		)
	}
		
}
