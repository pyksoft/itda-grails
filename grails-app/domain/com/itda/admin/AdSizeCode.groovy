package com.itda.admin
import java.util.ArrayList;

import com.itda.Business;

class AdSizeCode {

	String adSizeCode;
	AdTypeCode adTypeCode;
	Boolean active; 
	String description;
	String long_description;
	Business business;
	
	static mapping = {
		id name: 'adSizeCode', generator: 'assigned'
	}

    static constraints = {
		adTypeCode(nullable:false)
		business(nullable:true)
		active(nullable:false)
		description(nullable:false)
		long_description(nullable:false)
    }
	
	public static ArrayList<String> findAllAdSizeCodes() {
		def codeResults = 
		AdSizeCode.executeQuery("select p.adSizeCode from AdSizeCode p where p.business is null and active = ?)", [true]);
		ArrayList codes = new ArrayList<String>();
		if(codeResults)
			for(code in codeResults)
				codes.add code;
		return codes;
	}
	
}
