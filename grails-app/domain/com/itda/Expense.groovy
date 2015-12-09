package com.itda

class Expense implements java.io.Serializable{
	String description;
	Double amount;
	Business business
	static belongsTo = [plannerEntry:PlannerEntry ]
    static constraints = {
		description(size:1..256, nullable:true)
		amount(nullable:true)
		business(nullable:false)
    }
}
