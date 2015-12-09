package com.itda

import java.util.Date;

class SendToVendor {

	Vendor vendor;
	String toEmail, cc, subject, notes, phone, dates, offers, logo, expireDates, address;
	Boolean changePhoneFlag = false, changeDatesFlag = false, changeOffersFlag = false, changeLogoFlag = false,
			changeExpireDatesFlag = false, changeAddressFlag = false, sentToVendor = false;
	String uuid, termsUuid; 
	
	Business business;
	PlannerEntry plannerEntry;
	Integer views =0;
	Integer downloads =0;
	Date dateCreated;
	Date lastUpdated;
    static constraints = {
		vendor(nullable:true)
		toEmail(nullable:true)
		cc(nullable:true)
		subject(nullable:true)
		notes(nullable:true, size:1..18000)
		phone(nullable:true)
		dates(nullable:true)
		offers(nullable:true)
		logo(nullable:true)
		expireDates(nullable:true)
		address(nullable:true)
		uuid(nullable:false)
		termsUuid(nullable:false)
		business(nullable:false)
		plannerEntry(nullable:false)
    }
}
