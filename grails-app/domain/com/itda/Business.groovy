package com.itda;
import java.util.Date;

import com.itda.admin.ManufacturerPromoCode;
class Business implements Serializable {
	String businessName
    String representativeName
	String phone
    String email
    String notes
	//ManufacturerPromoCode promoCode;
	String promoCode; 
	Date dateCreated;
	String acceptedTerms;
	//transient String additionalZipcodes

    static hasMany = [offices:Office, publications:Publication, 
                      manufacturers:Manufacturer, competitors:Competitor, 
                      payments:Payment,  vendors:Vendor, usernames:Username]

    static constraints = {
		businessName(size:1..128, blank:false)
        representativeName(size:1..128, blank:false)
        email(email:true, blank:false, unique:true)
        phone(matches:"[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]", blank:false)
        acceptedTerms(inList:["true", "True", "TRUE"])
        notes(nullable:true, size:1..5000)
		promoCode(nullable: false, blank:false)		
    }
	
    public static Business businessForEmail (String emailAddress) {
		return Business.find("from Business as p where p.email=:email", 
				[email:emailAddress]
		)
	}	
}
