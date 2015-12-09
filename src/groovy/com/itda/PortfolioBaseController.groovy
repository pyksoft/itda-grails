package com.itda

import java.util.Map;
import java.util.List;
import java.io.File;
import com.itda.Portfolio;
import com.itda.PortfolioEntry;

class PortfolioBaseController {

	public boolean saveInvalidPortfolioEntry (PortfolioEntry invalidEntry, 
						List adSizeList, List adTypeList, List offerCodeList) {
		if(! invalidEntry.pdfFile || invalidEntry.pdfFile == "") 
			invalidEntry.pdfFile = invalidEntry.UNKNOWN				
		if(! invalidEntry.imageFile || invalidEntry.imageFile == "") 
			invalidEntry.imageFile = invalidEntry.UNKNOWN

		if(! invalidEntry.adDescription || invalidEntry.adDescription == "" ) 
			invalidEntry.adDescription = invalidEntry.UNKNOWN
		if(! invalidEntry.adTabNumber) 
			invalidEntry.adTabNumber = 1;				
		if(! invalidEntry.adPageNumber) 
			invalidEntry.adPageNumber = 100				
		if(! invalidEntry.details || invalidEntry.details == "") 
			invalidEntry.details = invalidEntry.UNKNOWN

		if(! adSizeList.contains(invalidEntry.adSizeCode)) 
			invalidEntry.adSizeCode = invalidEntry.UNKNOWN				
		if(! adTypeList.contains(invalidEntry.adTypeCode)) 
			invalidEntry.adTypeCode = invalidEntry.UNKNOWN
		if(! offerCodeList.contains(invalidEntry.offerCode)) 
			invalidEntry.offerCode = invalidEntry.UNKNOWN
			
		if(! invalidEntry.portfolioDate) 
			invalidEntry.portfolioDate = java.sql.Date.valueOf("2001-01-01")				
		
		if(invalidEntry.portfolio)
			invalidEntry.promoCode = invalidEntry.portfolio.promoCode;

		invalidEntry.enable = false		
		
		return invalidEntry.save(flush:true)
	}


	public PortfolioEntry createPortfolioEntry (Map portfolioEntryFields, Portfolio portfolio ) {
		PortfolioEntry invalidEntry = new PortfolioEntry();
		invalidEntry.enable = false		
		invalidEntry.setPortfolioDate(new java.sql.Date(portfolio.portfolioDate.getTime()));
		invalidEntry.portfolio = portfolio;
		invalidEntry.promoCode = portfolio.promoCode;

		if(portfolioEntryFields ) {
		invalidEntry.adTabNumber = ( (portfolioEntryFields['tab'] && portfolioEntryFields['tab'].isInteger())  
										? Integer.parseInt (portfolioEntryFields['tab']) : 1 ); 
		invalidEntry.adPageNumber = ( (portfolioEntryFields['pageNumber'] && portfolioEntryFields['pageNumber'].isInteger())  
										? Integer.parseInt (portfolioEntryFields['pageNumber']) : 100 ) ;
		invalidEntry.unparsableFile = portfolioEntryFields['fileName']; 
		invalidEntry.adSizeCode = (portfolioEntryFields['adSize'] ? portfolioEntryFields['adSize'] : invalidEntry.UNKNOWN ) 
		invalidEntry.adTypeCode = (portfolioEntryFields['adType'] ? portfolioEntryFields['adType'] : invalidEntry.UNKNOWN ) 
		invalidEntry.offerCode = (portfolioEntryFields['offerCode'] ? portfolioEntryFields['offerCode'] : invalidEntry.UNKNOWN ) 
		invalidEntry.portfolioDate = (portfolioEntryFields['date'] ? portfolioEntryFields['date'] : java.sql.Date.valueOf("2001-01-01") ) 
		}				
		
		return invalidEntry
	}
	
    public String getPortfolioBaseDir(Portfolio portfolioInstance) {
		String baseDir;
		File dir ;
		if(portfolioInstance.category == portfolioInstance.PORTFOLIO_CATEGORY) { 
			baseDir = message(code:"inthedoor.portfolio.root.dir"); 
			String date	= portfolioInstance.portfolioDate.format('yyyy-MM');
			dir = new File (  baseDir  + date);
			if(dir.exists())
				baseDir += date;
			else
				baseDir += portfolioInstance.id;
		}else{
			baseDir = message(code:"inthedoor.adStore.root.dir"); 
			baseDir	+= portfolioInstance.id;
		}
		baseDir	+= File.separator;
		return baseDir;
    }
    public String getPortfolioContentDir(Portfolio portfolioInstance) {
		return getPortfolioBaseDir(portfolioInstance) + CONTENT_DIR_NAME + File.separator;
    }

   public static final String CONTENT_DIR_NAME = "content";
}