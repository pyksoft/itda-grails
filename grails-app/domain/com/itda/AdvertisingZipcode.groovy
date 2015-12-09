package com.itda

import java.io.Serializable;

class AdvertisingZipcode  implements Serializable {
	
	String zipcode 
	Date dateCreated
	Date lastUpdated	
	//debug
	Double lat, lon
	String city
	static belongsTo = [office:Office]
	
    static constraints = {
		zipcode(matches:"[0-9][0-9][0-9][0-9][0-9]", size:1..5, blank:false) //unique:true for itda only
    }

	static mapping = {
		//id column : 'zipcode' 
		version false
		zipcode column:'zipcode', index:'zipcode_idx'
	}
	
	static availabilityQuery = { zipcodes ->  
		for(it in zipcodes) {
			def thezipcode = AdvertisingZipcode.find("from AdvertisingZipcode as p where p.zipcode=:zipcode", [zipcode:it])
			if (thezipcode) {
				return false;
			}
		}
		return true;
	}	

	static ArrayList conflictingZipcodesQuery (zipcodes) { 
		ArrayList<AdvertisingZipcode> list = new ArrayList<AdvertisingZipcode>();
		if(zipcodes)
			for(it in zipcodes) {
				def thezipcode = AdvertisingZipcode.find("from AdvertisingZipcode as p where p.zipcode=:zipcode", [zipcode:it])
				if (thezipcode) {
					list.add(thezipcode);
				}
			}
		return list;
	}	
	
	
	public boolean equals(Object other) {
		if (null == other) return false;
		if( other instanceof String && other == this.zipcode)
			return true
		if( other instanceof AdvertisingZipcode && other.zipcode == this.zipcode)
			return true
		return false;		
	}
	public int hashCode() {
		return this.zipcode.hashCode();		
	}
	
}
