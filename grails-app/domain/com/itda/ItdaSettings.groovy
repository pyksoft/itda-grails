package com.itda

class ItdaSettings {

	Boolean reportPopup;
	Boolean trackerExpensePopup;
	Boolean trackerSalePopup;
	Boolean trackerResultPopup;
	Boolean trackerCompetitionPopup;
	Boolean trackerDetailPopup;
	Boolean plannerDetailPopup;
	Boolean plannerPopup;	
	Boolean accountVendorPopup;
	Boolean accountManufacturerPopup;	
	Boolean accountPublicationPopup;	
	Boolean accountCompetitorPopup;	
	Username username; 
    static constraints = {
    	trackerExpensePopup(nullable:true)
    	trackerSalePopup(nullable:true)
    	trackerResultPopup(nullable:true)
    	trackerCompetitionPopup(nullable:true)
    	trackerDetailPopup(nullable:true)
    	plannerDetailPopup(nullable:true)
    	plannerPopup(nullable:true)
    	accountVendorPopup(nullable:true)
    	accountManufacturerPopup(nullable:true)
    	accountPublicationPopup(nullable:true)
    	accountCompetitorPopup(nullable:true)
		reportPopup(nullable:true)
    	username(nullable:false)
    }
}
