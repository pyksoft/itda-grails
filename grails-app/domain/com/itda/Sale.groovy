package com.itda

class Sale implements java.io.Serializable{
	String description;
	Double amount;
	Business business
	java.sql.Date saleDate
	
	static belongsTo = [plannerEntry:PlannerEntry ]
    static constraints = {
		description(size:1..256, nullable:true)
		amount(nullable:true)
		saleDate(nullable:true)
		business(nullable:false)
    }
}
