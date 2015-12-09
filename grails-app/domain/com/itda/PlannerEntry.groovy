package com.itda
import java.util.Date;
class PlannerEntry {
	
	java.sql.Date start
	Integer quantity
	String title
	String className
	String size
	String otherSize
	String color
	java.sql.Date deadline
	String selfNotes
	String vendorNotes
	String imageFile;
	String pdfFile;
	
	PortfolioEntry portfolioEntry
	Result result;
	Vendor vendor;
	Publication publication;
	Office office;
	///
	Double totalExpense;
	Double grossSales;
	Double returnOnInvest;
	Double costPerLead;
	Double costPerSale;
	String placement;
	/*other items on same date*/
	
	String toEmail, cc, subject, phone, dates, offers, logo, expireDates, address, otherChanges;
	Boolean changePhoneFlag = false, changeDatesFlag = false, changeOffersFlag = false, changeLogoFlag = false,
			changeExpireDatesFlag = false, changeAddressFlag = false, changeOtherFlag = false, sentToVendor=false;	
	
	
	static hasMany = [todos:PlannerTodo, zipcodes:String, expenses:Expense, sales:Sale]
    static belongsTo = [business:Business]    
    static constraints = {
		start(nullable:false)
		className(nullable:false)
		title(nullable:false)
		size(nullable:true)
		otherSize(nullable:true)
		color(nullable:true)
		deadline(nullable:true)
		selfNotes(nullable:true, size:1..2048)
		vendorNotes(nullable:true, size:1..2048)
		quantity(nullable:true)
		portfolioEntry(nullable:true)
		result(nullable:true)
		vendor(nullable:true)
		publication(nullable:true)
		office(nullable:true)
		imageFile(nullable:true)
		pdfFile(nullable:true)
		////////////
		toEmail(nullable:true, size:1..256)
		cc(nullable:true, size:1..256)
		subject(nullable:true, size:1..256)
		phone(nullable:true, size:1..64)
		dates(nullable:true, size:1..256)
		offers(nullable:true, size:1..256)
		logo(nullable:true, size:1..256)
		expireDates(nullable:true, size:1..256)
		address(nullable:true, size:1..256)
		otherChanges(nullable:true, size:1..2048)
		/////
		totalExpense(nullable:true)
		grossSales(nullable:true)
		returnOnInvest(nullable:true)
		costPerLead(nullable:true)
		costPerSale(nullable:true)
		placement(nullable:true)
	}
	
	static listEntriesByBusinessByDateRange = { params ->
	    Date start = Date.parse('yyyy-MM-dd', params['start-min'][0..9])
	    Date end = Date.parse('yyyy-MM-dd', params['start-max'][0..9])
		def entryList  = PlannerEntry.findAll("from PlannerEntry as p where p.business.id=:bizId " +
				 				"and start >= :start and start <= :end", 
				[bizId: params.businessId, start:start, end:end])
		return entryList;
	}
	
	def static getAdEventType(String adTypeCode) {
		if(adTypeCode == 'NP')
			return 'news-planner-event';
		if(adTypeCode == 'DM')
			return 'directmail-planner-event';
		if(adTypeCode == 'ME')
			return 'media-planner-event';
		if(adTypeCode == 'EV')
			return 'event-planner-event';
		if(adTypeCode == 'MI')
			return 'miscellaneous-planner-event';   
		return null;
	}
	
	def static getTitlePrefix(String classname) {
		return 	getAdTitle(classname) + " #";
	}
	
	def static getAdTitle(String classname) {
		if(classname == 'news-planner-event')
			return 'NEWSPAPER AD';
		if(classname == 'directmail-planner-event')
			return 'DIRECT MAIL';
		if(classname == 'media-planner-event')
			return 'MEDIA AD';
		if(classname == 'event-planner-event')
			return 'EVENT';
		if(classname == 'miscellaneous-planner-event')
			return 'MISCELLANEOUS';
	}
	
}
