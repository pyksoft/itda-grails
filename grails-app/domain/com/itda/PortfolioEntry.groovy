package com.itda
import java.io.Serializable;

import com.itda.admin.ItdaAttribute;
import com.itda.admin.ManufacturerPromoCode;
import com.itda.admin.AdTypeCode;
import com.itda.admin.AdSizeCode;
import com.itda.Portfolio;

class PortfolioEntry  implements Serializable {
	String category = Portfolio.PORTFOLIO_CATEGORY;
	
	Boolean enable
	Date portfolioDate;
	String adTypeCode, adSizeCode, offerCode;
	Integer adPageNumber;
	Integer adTabNumber;
	String adDescription
	String details
	String promoCode;

	String adKey;  //1,2, and 4 color ads will share same key
	String 	unparsableFile ="";
	String 	pdfFile = "";
	String 	imageFile = "";	
	//TIME OF YEAR
	Boolean winter =false;
	Boolean fall =false;
	Boolean summer =false;
	Boolean spring =false;
	Boolean newYear =false;
	Boolean christmas =false;
	Boolean thanksgiving =false;
	Boolean valentine =false;
	Boolean president =false;
	Boolean july4 =false;
	String otherTimeOfYear;
	
	//FOCUS
	Boolean testimonial=false;  
	Boolean sale=false;
	Boolean trial=false;
	Boolean event=false;
	Boolean seminar=false;
	Boolean advertorial=false;
	Boolean features=false;
	Boolean benefits=false;
	Boolean upgrade=false;
	Boolean tinnitus=false;
	Boolean notice=false;
	Boolean opening=false;
	Boolean hearingTest=false;
	Boolean consultDemo=false;
	Boolean endorsement=false;
	Boolean technology=false;
	String otherFocus;
	//OFFER
/*	
	Boolean offPerc50 =false;
	Boolean offPerc40=false;
	Boolean offDol500 =false;
	Boolean dol995 =false;
	Boolean dol1495=false;
	Boolean buy1get1=false;
	Boolean tryBforBuy=false;
	Boolean lowAsPerMonth=false;
	String otherOffer;
*/	
//	TODO: remove from database
	Boolean anatomy=false;
	Boolean product=false;
	Boolean patient=false;
	Boolean dispenser=false;
	Boolean map=false;
	Boolean calendar=false;
	Boolean testing=false;
	Boolean coupons=false;
	Boolean policies=false;
	Boolean company=false;
	Boolean address=false;
	Boolean phone=false;

	String otherSize;
	String otherOffer;
		
	Integer color;
	Integer download =0;
	Double rating = 0;
	Integer numReview=0;
	Integer numRating=0;
	Boolean deleted=false;
	Business business;
	
	static UNKNOWN = 'UNKNOWN';
	static OTHER = 'OTHER';
	static belongsTo = [portfolio:Portfolio]
							                    
	static constraints = {
		otherSize(nullable:true)
		otherOffer(nullable:true)
		otherFocus(nullable:true)
		otherTimeOfYear(nullable:true)
		business(nullable:true)
		adKey(nullable:true, size:1..64)
		enable(nullable:false)
		deleted(nullable:false)
		color(nullable:true, inList:[1,2,4])
		offerCode(nullable:false, validator: {val, PortfolioEntry entry ->
					   if(entry.category == Portfolio.MY_UPLOADS_CATEGORY)
					   		return true;
					   if(UNKNOWN == val)
						   return true;
			           return ItdaAttribute.findAllValues( 'offerCode').contains(val);
					})
	    adTypeCode (nullable:false, validator: {val, PortfolioEntry entry ->
					   if(UNKNOWN == val)
						   return true;
			           return ItdaAttribute.findAllValues( 'adTypeCode').contains(val);
					})
	    adSizeCode (nullable:false, validator: {val, PortfolioEntry entry ->
					   if(entry.category == Portfolio.MY_UPLOADS_CATEGORY)
					   		return true;
					   if(UNKNOWN == val)
						   return true;
						return ItdaAttribute.findAllValues( 'adSizeCode').contains(val);
					})
		 
		adPageNumber(value:1..99, nullable:false)
		adTabNumber(value:1..3, nullable:false)
		adDescription(size:1..256, blank:false, nullable:false)
		details(size:1..256, blank:false, nullable:false)

		unparsableFile(size:1..256, blank:true, nullable: true )  
		pdfFile(size:1..256, blank:false, nullable: false )
		imageFile(size:1..256, blank:false, nullable: false ) 	
		category(inList:[ Portfolio.PORTFOLIO_CATEGORY, Portfolio.AD_STORE_CATEGORY, Portfolio.MY_UPLOADS_CATEGORY], blank:false, nullable:false)
	}
	
	static listPortfolioEntries = { portfolioId -> 
		def listOfEntries  = PortfolioEntry.findAll("from PortfolioEntry as p where p.portfolio.id=:portId " +
				"and (category = :cat or category is null) and deleted = false " + 
				"order by p.adTabNumber asc, p.adPageNumber asc, p.color asc", 
				[portId: portfolioId, cat: Portfolio.PORTFOLIO_CATEGORY]);
		return listOfEntries;
	}

	static listCollectionEntries = { portfolioId -> 
		def listOfEntries  = PortfolioEntry.findAll("from PortfolioEntry as p where p.portfolio.id=:portId " +
				"and (category = :cat) and deleted = false " + 
				"order by p.adPageNumber asc, p.color asc", 
				[portId: portfolioId, cat: Portfolio.AD_STORE_CATEGORY]);
		return listOfEntries;
	}
		
	static listActivePortfolioEntries = { date ->
		def listPortfolioEntries
		if( date != null)
			listPortfolioEntries = PortfolioEntry.executeQuery(
			"select new map(ad.id as id, ad.details as dimensionInfo, " +
			"ad.adTypeCode as adType, ad.adSizeCode as adSize, ad.adDescription as adDescription, " +
			"ad.imageFile as fourColorFileName, ad.imageFile as twoColorFileName, ad.color as color, " +
			"ad.imageFile as oneColorFileName, ad.portfolioDate as portfolioDate, ad.adPageNumber as page, ad.adTabNumber as tab) " +
			"from PortfolioEntry ad, Portfolio port " +
			"where port.id = ad.portfolio.id  and ad.enable = true " +
			"and ad.portfolioDate = ? " +
			"order by ad.adTabNumber asc, ad.adPageNumber asc", [date]
			) 
		else 
			listPortfolioEntries = PortfolioEntry.executeQuery(
			"select new map(ad.id as id, ad.details as dimensionInfo, " +
			"ad.adTypeCode as adType, ad.adSizeCode as adSize, ad.adDescription as adDescription, " +
			"ad.imageFile as fourColorFileName, ad.imageFile as twoColorFileName, ad.color as color, " +
			"ad.imageFile as oneColorFileName, ad.portfolioDate as portfolioDate, ad.adPageNumber as page, ad.adTabNumber as tab) " +
			"from PortfolioEntry ad, Portfolio port " +
			"where port.id = ad.portfolio.id and port.status = 'Active' and ad.enable = true " +
			"order by ad.adTabNumber asc, ad.adPageNumber asc" 	
			)
		return listPortfolioEntries ? listPortfolioEntries as ArrayList<String>: new ArrayList<String>()
	}
	
	static def getMyPortfolioEntry (id, color) {
		def entry = PortfolioEntry.get(id);
		if(!entry )
			return null;
		else if(!color || entry.color == color as int) 
			return entry;

		entry = PortfolioEntry.findWhere(portfolioDate:entry.portfolioDate,
								adPageNumber:entry.adPageNumber,
								adTabNumber:entry.adTabNumber,
								adTypeCode:entry.adTypeCode,
								color:color as int); //TODO create index
		return entry;
	}	
		
}
