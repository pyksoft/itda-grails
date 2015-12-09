package com.itda

import java.io.Serializable;

class Zipcode implements Serializable {

	Double latitude
	Double longitude
	String city
	String state
	String county
	String zipcode
    static constraints = {
    }

	static mapping = {
		table 'zipcode'
		latitude column: 'latitude'
		longitude column: 'longitude'
		city column: 'city'
		state column: 'state'
		county column: 'county'
		//category column: 'category'
		//id column : 'zipcode'
		id name: 'zipcode', generator: 'assigned' 
		version false
	}
}
