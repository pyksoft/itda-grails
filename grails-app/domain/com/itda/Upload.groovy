package com.itda

class Upload {

	String uuid;
	Business business;
	String pdfFile;
	String imageFile;
	Date dateCreated;
	Date lastUpdated;
	
    static constraints = {
		uuid(unique:true)
		business(nullable:false)
		pdfFile(nullable:true)
		imageFile(nullable:true)
    }
}
