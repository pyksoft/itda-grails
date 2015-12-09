package com.itda
import com.itda.admin.ManufacturerPromoCode;
import java.util.Date;

class Portfolio {

	Date portfolioDate;
	String status;
	String coverPageImage;
	String backPageImage;
	String spineImage;
	String uploadZipName;
	String state;
	String description;
	Date dateCreated;
	Date lastUpdated;
	String promoCode; //ref ManufacturerPromoCode.promoCode
	String category;
	Boolean deleted=false;
	//title, timeOfYear
	
	static hasMany = [entries:PortfolioEntry]
	
	static constraints = {
		portfolioDate(nullable:false, unique:true)
		status(inList:[ ACTIVE_STATUS, ARCHIVE_STATUS, INACTIVE_STATUS], 
				blank:false, nullable:false) 
		coverPageImage(size:1..256, blank:true, nullable: true)
		backPageImage(size:1..256, blank:true, nullable: true)
		spineImage(size:1..256, blank:true, nullable: true)
		uploadZipName(size:1..256, blank:true, nullable: true) 
		state(inList:[ CREATED_STATE, UPLOADED_STATE, LOADED_STATE, READY_STATE], 
				blank:false, nullable:false)
		description(size:1..256, nullable: true)
		promoCode(nullable: false, blank:false)
		category(inList:[ PORTFOLIO_CATEGORY, AD_STORE_CATEGORY,MY_UPLOADS_CATEGORY],	blank:false, nullable:false)
		deleted(nullable: true)
	}
	
	public static final String  MY_UPLOADS_CATEGORY = "myUploads";
	public static final String AD_STORE_CATEGORY = "adStore";
	public static final String  PORTFOLIO_CATEGORY = "portfolio";
	public static final  String  CREATED_STATE = "Created";
	public static final  String  UPLOADED_STATE = "Uploaded";
	public static final  String  LOADED_STATE = "Loaded";
	public static final  String  READY_STATE = "Ready";
	public static final  String  ACTIVE_STATUS = "Active";
	public static final  String  ARCHIVE_STATUS = "Archive";
	public static final  String  INACTIVE_STATUS = "Inactive";
	
}
