package com.itda

import java.sql.Date;

class UserComment {

	Username user;
	Result review;
	String comment;
	Date dateCreated;
	Date lastUpdated;	
	
    static constraints = {
		comment(size:1..4096, nullable:false)
		user(nullable:false)
		review(nullable:false)		
    }
}
