package com.itda

import java.util.Date;

class CompetitorAd {

	//PlannerEntry myAd; 	
	Competitor competitor;
	//Publication publisher;
	Vendor vendor;
	Publication publication;
	static belongsTo = [business:Business]
	                    
	String className;
	String title; 
	java.sql.Date start;
	String size;
	String otherSize;	
	String color;
	String notes;
	//String adFile;  //is this a image or pdf
	String imageFile;

    static constraints = {
		start(nullable:false)
		className(nullable:false)
		title(nullable:false)
		size(nullable:true)
		otherSize(nullable:true)		
		color(nullable:true)
		notes(nullable:true, size:1..2048)
		imageFile(nullable:true)
		competitor(nullable:true)
		//publisher(nullable:true)
		vendor(nullable:true)
		publication(nullable:true)
	}
	
/*	
	//functionality: new competitor, select ad, new marketing
*/	
	static listEntriesByBusinessByDateRange = { params ->
	    Date start = Date.parse('yyyy-MM-dd', params['start-min'][0..9])
	    Date end = Date.parse('yyyy-MM-dd', params['start-max'][0..9])
		def entryList  = CompetitorAd.findAll("from CompetitorAd as p where p.business.id=:bizId " +
				 				"and start >= :start and start < :end", 
				[bizId: params.businessId, start:start, end:end])
		return entryList;
    }
    
	def getTitle(String classname, long bizId, Date start) {
		def count = CompetitorAd.executeQuery('select count(e) from CompetitorAd e where e.className = ? and e.business.id = ? and start = ?',
				classname, bizId, start);
		return PlannerEntry.getTitlePrefix(classname)  +  (count[0]+1);
	}

	static findAd = { id, bizId -> 
		return CompetitorAd.findWhere([id:id, 'business.id':bizId])
	}
}

