package com.itda;;
import java.util.Date;
import java.util.Calendar;

class PortfolioService {

    static transactional = true

    def markPortfolioAsDelete(Portfolio port) {
		port.deleted = true;
		if(port.category == Portfolio.PORTFOLIO_CATEGORY){
		   Calendar cal = Calendar.getInstance();
		   cal.setTimeInMillis(port.portfolioDate.getTime() + 1000);
		   while(Portfolio.findWhere(portfolioDate : cal.getTime())) {
			   cal.add(cal.SECOND, 1);
		   } 
		   port.portfolioDate  = cal.getTime(); //portfolioDate is unique
		}
		def entries = PortfolioEntry.findAllWhere('portfolio.id': port.id)
		for(PortfolioEntry entry in entries){
			entry.deleted = true;
			entry.portfolioDate = port.portfolioDate;
		}
		return true;
    }
}
