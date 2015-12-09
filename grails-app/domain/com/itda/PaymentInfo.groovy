package com.itda;


class PaymentInfo{

	String firstName
	String lastName
	String cardNumber
	String expireYear 
	String expireMonth
	String billingAddress
	String city
	String state
	String zipcode
	String cardSecurityCode
	String cardType = ""
	Date dateCreated
	Date lastUpdated	
	Business business;
	 
    static constraints = {
		business(nullable:false)
		firstName(nullable:false, blank:false,  size:1..50)
		lastName(nullable:false, blank:false, size:1..50)
		cardNumber(nullable:false, blank:false, size:1..16)
		expireMonth(inList:["", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", ],  blank:false)
		expireYear(inList:["", "12", "13", "14", "15", "16", "17", "18", "19", "20", ],  blank:false)
        cardSecurityCode(size:1..4, blank:false)
		billingAddress(blank:false, size:1..60)
		city(blank:false, size:1..40)
        state(inList:["", "AL", "AK", "AR", "AZ", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI",
                      "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", 
                      "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", 
                      "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", 
                      "WV", "WI", "WY"], blank:false)        
        zipcode(matches:"[0-9][0-9][0-9][0-9][0-9]", size:1..5, blank:false)
        cardType(nullable:true,  blank:true)
    }
	
	static transients = ['cardSecurityCode', 'billingAddress', 'city', 'zipcode', 'state']

	def beforeInsert = {
		cardSecurityCode = cardSecurityCode.replaceAll (/./, "*");
	       cardNumber = cardNumberAsLast4String();
	}
	
	def beforeUpdate = {
		cardSecurityCode = cardSecurityCode.replaceAll (/./, "*");
		cardNumber = cardNumberAsLast4String();
	}
	
	public String cardNumberAsLast4String() {
		return "************" + cardNumber.substring(cardNumber.length()-4)
	}
	
}
