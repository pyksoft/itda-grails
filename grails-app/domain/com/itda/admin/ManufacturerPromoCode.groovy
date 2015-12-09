package com.itda.admin

import java.io.Serializable;

class ManufacturerPromoCode  implements Serializable {

	String promoCode;
	String manufacturer;
	static mapping = {
		id name: 'promoCode', generator: 'assigned'
	}

    static constraints = {
    }

	public static ArrayList<String> findAllPromoCodes() {
		def promoCodeResults = 
		ManufacturerPromoCode.executeQuery("select p.promoCode from ManufacturerPromoCode p");
		ArrayList promoCodes = new ArrayList<String>();
		if(promoCodeResults)
			for(code in promoCodeResults)
				promoCodes.add code;
				
		return promoCodes;
	}
}
