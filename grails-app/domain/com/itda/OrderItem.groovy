package com.itda

class OrderItem {

	Date dateCreated;
	Date lastUpdated;
	Business business;
	PortfolioEntry item;
	String name;
	String approvalCode;
	static belongsTo = [order:Payment] 
    static constraints = {
        name(nullable:true)
        approvalCode(nullable:true, blank:false)	
    }
}
