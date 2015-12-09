package com.itda.admin

import java.util.ArrayList;

class AdTypeCode {

	String adTypeCode;
	String description;
	Boolean active; 
	
	static mapping = {
		id name: 'adTypeCode', generator: 'assigned'
	}
	
    static constraints = {
		active(nullable:false)
		description(nullable:false)
    }
	
	public static ArrayList<String> findAllAdTypeCodes() {
		def codeResults = 
		AdTypeCode.executeQuery("select adTypeCode from AdTypeCode p where active = ?)", [true]);
		ArrayList codes = new ArrayList<String>();
		if(codeResults)
			for(code in codeResults)
				codes.add code;
		return codes;
	}
	
}
