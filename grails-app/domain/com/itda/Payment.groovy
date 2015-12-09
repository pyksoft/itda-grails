package com.itda
import java.io.Serializable;


class Payment implements Serializable {

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
	String description = ""
	Double amount = 0 as Double 	//for registration, value will be set by controller
	String response = ""
	String approvalCode =""
	String transactionId = ""
	String subscriptionId = ""
	String notes = ""
	String cardType = ""
	Date dateCreated
	Date lastUpdated	
	static belongsTo = [business:Business] 
	static hasMany = [/*ads:PortfolioEntry,*/ orderItems:OrderItem]
    static constraints = {
		firstName(nullable:false, blank:false,  size:1..50)
		lastName(nullable:false, blank:false, size:1..50)
		cardNumber(nullable:false, blank:false, size:1..16)
		expireMonth(inList:["", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", ],  blank:false)
		expireYear(size:2..2, blank:false)
        cardSecurityCode(size:1..4, blank:false)
		billingAddress(blank:false, size:1..60)
		city(blank:false, size:1..40)
        state(inList:["", "AL", "AK", "AR", "AZ", "CA", "CO", "CT", "DE", "DC", "FL", "GA", "HI",
                      "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", 
                      "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", 
                      "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", 
                      "WV", "WI", "WY"], blank:false)        
        zipcode(matches:"[0-9][0-9][0-9][0-9][0-9]", size:1..5, blank:false)
        response(Size:1..1024, nullable:false, blank:true)
        amount(nullable:false,  scale:2)
        approvalCode(nullable:false,  size:1..6, blank:true)
        transactionId(nullable:false,  size:1..128, blank:true)
        subscriptionId(nullable:false,  size:1..64, blank:true)
        description(nullable:false,  size:1..128, blank:true)
        notes(nullable:false,  size:1..2048, blank:true)
        cardType(nullable:true,  blank:true)
    }

	public void replaceCreditCardInfo() {
		cardSecurityCode = cardSecurityCode.replaceAll (/./, "*");
	       cardNumber = cardNumberAsLast4String();
	}
	
    public StringBuffer authorizeCaptureHttpParamsAsStringBuffer() {
		StringBuffer buf = paymentInfoAsHttpParams()
		buf.append("&x_type=AUTH_CAPTURE&x_duplicate_window=10");
		return buf		
	}
	
	public StringBuffer priorAuthorizeCaptureHttpParamsAsStringBuffer() {
		StringBuffer buf = paymentInfoAsHttpParams()
		buf.append("&x_type=PRIOR_AUTH_CAPTURE&x_trans_id=").append(URLEncoder.encode(transactionId, "UTF-8"));
		return buf
	}

	public StringBuffer authorizeOnlyttpParamsAsStringBuffer() {
		StringBuffer buf = paymentInfoAsHttpParams()
		buf.append("&x_type=AUTH_ONLY")
		return buf
	}
	
	public StringBuffer refundHttpParamsAsStringBuffer() {
		StringBuffer buf = paymentInfoAsHttpParams()
		buf.append("&x_type=CREDIT&x_trans_id=").append(URLEncoder.encode(transactionId, "UTF-8"));
		return buf
	}

	public StringBuffer voidHttpParamsAsStringBuffer() {
		StringBuffer buf = paymentInfoAsHttpParams()
		buf.append("&x_type=VOID&x_trans_id=").append(URLEncoder.encode(transactionId, "UTF-8"));
		return buf
	}

	public static String priceAsString(double price) {
		StringBuilder sb = new StringBuilder();
		Formatter formatter = new Formatter(sb, Locale.US);
		return formatter.format("%.2f", price)
	}

	public String cardNumberAsLast4String() {
		return "************" + cardNumber.substring(cardNumber.length()-4)
	}

	public String totalPriceAsString() {
		return Payment.priceAsString(amount)
	}

	
	public String updateTotalPrice(int numOfOffices, double price1stOffice, double pricePerOffice) {
		amount = price1stOffice + (numOfOffices-1) * pricePerOffice;
		return Payment.priceAsString(amount)
	}

	
	private StringBuffer paymentInfoAsHttpParams() {
		
		StringBuffer buf = new StringBuffer()
		buf.append("x_card_num=").append(URLEncoder.encode(cardNumber, "UTF-8"));
		buf.append("&x_exp_date=").append(URLEncoder.encode(expireMonth, "UTF-8"))
								.append(URLEncoder.encode(expireYear, "UTF-8"));
		buf.append("&x_amount=").append(URLEncoder.encode(totalPriceAsString(), "UTF-8"));
		buf.append("&x_description=").append(URLEncoder.encode(description, "UTF-8"));
		buf.append("&x_first_name=").append(URLEncoder.encode(firstName, "UTF-8"));
		buf.append("&x_last_name=").append(URLEncoder.encode(lastName, "UTF-8"));
		buf.append("&x_address=").append(URLEncoder.encode(billingAddress, "UTF-8"));
		buf.append("&x_city=").append(URLEncoder.encode(city, "UTF-8"));
		buf.append("&x_state=").append(URLEncoder.encode(state, "UTF-8"));
		buf.append("&x_zip=").append(URLEncoder.encode(zipcode, "UTF-8"));
		buf.append("&x_card_code=").append(URLEncoder.encode(cardSecurityCode,"UTF-8"));
		return buf
	}
	
}
