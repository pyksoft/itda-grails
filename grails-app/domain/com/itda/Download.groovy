package com.itda

import java.util.Date;

class Download {
	Business business;
	PortfolioEntry portfolioEntry; 
	Date dateCreated;
    static constraints = {
		business(nullable:false)
		portfolioEntry(nullable:false)
    }

}
