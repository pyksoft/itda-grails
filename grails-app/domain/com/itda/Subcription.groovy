package com.itda

import java.util.Date;

class Subcription {
	
	String description;
	Double total;
	Portfolio portfolio;
	Date dueDate;
	Date dateCreated
	Date lastUpdated	

	static hasMany = [offices:Office]
	
	static constraints = {
		dueDate(nullable:false)
		description(size:1..256, blank:false, nullable: false)
        total(nullable:false,  scale:2)
		portfolio(nullable: false)
	}
	
}
