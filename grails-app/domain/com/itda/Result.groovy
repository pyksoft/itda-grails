package com.itda

import java.sql.Date;

class Result implements Serializable{

	boolean publishTestsSet = true;
	boolean publishTestsSold = true;
	boolean publishHearingAidsSold = true;
	boolean publishTestedNotSold = true;
	boolean publishCalls = true;
	Integer calls;
	Integer testsSet ;
	Integer testsSold;
	Integer hearingAidsSold ;
	Integer testedNotSold ;
	
	Double grossSales;
	Double returnOnInvest;
	Double costPerLead;
	Double costPerSale;
	boolean publishGrossSales = true;
	boolean publishReturnOnInvest = true;
	boolean publishCostPerLead = true;
	boolean publishCostPerSale = true;
	
	String placement;
	Double totalExpense;
	Integer numberCompetitiveAd = 0;
	Double rating = 0;
	String title;
	String review;
	Date dateCreated;
	Date lastUpdated	;
	PlannerEntry plannerEntry;
	Business business;
	String author = 'author';
	String location;
	Integer helpfulCount = 0;
	Integer notHelpfulCount = 0;
	Boolean published = false;
	Date runDate;
	
	
	PortfolioEntry portfolioEntry;
	
	static hasMany = [helpfulUsers:Username, notHelpfulUsers:Username];
	//static belongsTo = [plannerEntry:PlannerEntry ]
	
	static constraints = {
		
		calls(nullable:true)
		testsSet(nullable:true)
		testsSold(nullable:true)
		hearingAidsSold(nullable:true)
		testedNotSold(nullable:true)
		grossSales(nullable:true)
		returnOnInvest(nullable:true)
		costPerLead(nullable:true)
		costPerSale(nullable:true)
		totalExpense(nullable:true)
		
		publishTestsSet(nullable:false)
		publishTestsSold(nullable:false)
		publishHearingAidsSold(nullable:false)
		publishTestedNotSold(nullable:false)
		publishGrossSales(nullable:false)
		publishReturnOnInvest(nullable:false)
		publishCostPerLead(nullable:false)
		publishCostPerSale(nullable:false)
		
		placement(nullable:true, inList:['Great', 'Good','OK', 'Poor'])
		numberCompetitiveAd(nullable:false, range:0..9999)
		rating(nullable:false, range:0..5.0)
		title(nullable:true, size:1..256)
		review(nullable:true, size:1..16384)
		author(size:1..256, nullable:false)
		business(nullable:false)
		portfolioEntry(nullable:true)
		plannerEntry(nullable:true)
		
		helpfulCount(nullable:true)
		notHelpfulCount(nullable:true)
		location(nullable:true)
/**/	}	
	
}
