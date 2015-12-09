package com.ondemand1.util
import java.net.URLEncoder
import java.net.URLConnection
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import com.itda.*
import com.anet.api.ARBAPI;
import com.anet.api.ARBCustomer;
import com.anet.api.ARBNameAndAddress;
import com.anet.api.ARBOrder;
import com.anet.api.ARBPayment;
import com.anet.api.ARBPaymentSchedule;
import com.anet.api.ARBSubscription;
import com.anet.api.CreditCard;

class PaymentProcessor {
	
	private List<String> paymentResponse
	private HashMap subscriptionResponse
	public static final String AUTHORIZE_NET_SUBSCRIPTION_SUCCESSFUL		= "I00001";
	public static final String AUTHORIZE_NET_APPROVED		= 1;
	public static final String AUTHORIZE_NET_DECLINED 		= 2;
	public static final String AUTHORIZE_NET_ERROR 			= 3;
	
	public authorize() {
		
	}
	
	public String createAuthNetCustomerProfile(String url, String login, String key, Payment paymentInfo, Business biz) {
		String request = createCustomerProfileRequestXml(login, key, biz, paymentInfo);
		URLConnection conn = getConnection(url);
		String response = null;
		// submit the post_string and close the connection
		DataOutputStream requestObject = new DataOutputStream( conn.getOutputStream() );
		println ("request is " + request);
		requestObject.write(request.getBytes());
		requestObject.flush();
		requestObject.close();
		
		if(conn.responseCode ==  HttpURLConnection.HTTP_OK) {
			// process and read the gateway response
			response = conn.content.text
		}
		return response;
	}
	
	private String createCustomerProfileRequestXml(String login, String key, Business biz, Payment payInfo) {
	   
		return "<?xml version='1.0' encoding='utf-8'?>" +
		"<createCustomerProfileRequest xmlns='AnetApi/xml/v1/schema/AnetApiSchema.xsd'>" +
		   "<merchantAuthentication><name>" +login+ "</name>" +
		   "<transactionKey>" +key+ "</transactionKey></merchantAuthentication>" +
	   		"<profile>" +
	   			"<merchantCustomerId>" + biz.id + "</merchantCustomerId>" +
	   			"<description>" + biz.businessName + "</description>" +
	   			"<email>" + biz.email + "</email>" +
	   			 createPaymentProfileXml(payInfo) +
	   			"</profile>" +
	   		"<validationMode>testMode</validationMode>" +
	   	"</createCustomerProfileRequest>";
	   
	}
	
	private String createPaymentProfileXml(Payment payInfo){
		def xml = 			
		"<paymentProfiles>" +
		    "<billTo>" +
		    	"<firstName>" + payInfo.firstName + "</firstName>" +
		    	"<lastName>" + payInfo.lastName + "</lastName>" +
		    	"<address>" + payInfo.billingAddress + "</address>" +
		    	"<city>" + payInfo.city + "</city>" +
		    	"<state>" + payInfo.state + "</state>" +
		    	"<zip>" + payInfo.zipcode + "</zip>" +
		    "</billTo>" +
		    "<payment>" +
		    	"<creditCard>" +
		    		"<cardNumber>" + payInfo.cardNumber + "</cardNumber>" +
		    		"<expirationDate>20" + payInfo.expireYear + "-" + payInfo.expireMonth + "</expirationDate>" +
		    		"<cardCode>" + payInfo.cardSecurityCode + "</cardCode>" +
		    	"</creditCard>" +
		    "</payment>" +
		  "</paymentProfiles>";		
		return xml;
	}
	
	private URLConnection getConnection(String url) throws Exception{
		def postUrl = new URL(url)	
		URLConnection connection = postUrl.openConnection();
		connection.setDoOutput(true);
		connection.setUseCaches(false);
		connection.setRequestProperty("Content-Type", "text/xml; charset=utf-8");		
		return connection;
	}
	
	/**
	 **/
	public List<String> processPayment(String url, String postString ) {
		def postUrl = new URL(url)
	try{	
		URLConnection connection = postUrl.openConnection();
		connection.setDoOutput(true);
		connection.setUseCaches(false);
		
		// this line is not necessarily required but fixes a bug with some servers
		connection.setRequestProperty("Content-Type","application/x-www-form-urlencoded");
		
		// submit the post_string and close the connection
		DataOutputStream requestObject = new DataOutputStream( connection.getOutputStream() );
		requestObject.write(postString.toString().getBytes());
		requestObject.flush();
		requestObject.close();
		
		if(connection.responseCode ==  HttpURLConnection.HTTP_OK) {
			// process and read the gateway response
			def csv = connection.content.text
			paymentResponse = csv.tokenize("|")
		}
		else
			paymentResponse = ["", connection.responseCode, connection.content.text ];
		connection.getInputStream().close();
			
	  }catch(Throwable e){
	     paymentResponse = ["", "500", "Server cannot process payment righ now. Try again later." ]
		
	  }
	}
	
	/**
	 * submit xml request document
	 **/
	HashMap processSubcription(String url,  String postString ) {
		ARBAPI api = new ARBAPI(null, "login", "key");
		def postUrl = new URL(url);
		URLConnection connection = postUrl.openConnection();
		connection.setDoOutput(true);
		connection.setUseCaches(false);
		
		// this line is not necessarily required but fixes a bug with some servers
		connection.setRequestProperty("Content-Type", "text/xml; charset=\"utf-8\"");
		//Calendar cal = new GregorianCalendar()		
		
		//def y = 2
		//while ( y-- > 0 ) {
			//String postString = createSubscriptionRequest(api, paymentInfo, cal.getTime())
			// submit the post_string and close the connection
			DataOutputStream requestObject = new DataOutputStream( connection.getOutputStream() );
			requestObject.write(postString.toString().getBytes());
			requestObject.flush();
			requestObject.close();
			if(connection.responseCode ==  HttpURLConnection.HTTP_OK) {
				def xml = connection.content.text
				subscriptionResponse = api.parseResponseMessages (xml)

				/*
				if (! subscriptionResponse.containsKey("E00017"))
					break;
				else {  //authorizenet server is east of california ; adjust of time difference
					    //maybe possible to rewrite using time zone for start date
					cal.add(Calendar.DAY_OF_MONTH, 1)
				}
				*/	
			}
			else
			{
				subscriptionResponse = new HashMap()
				subscriptionResponse.put "result_code", connection.responseCode 
				subscriptionResponse.put "message" , connection.content.text
			}
		//}
		return subscriptionResponse
	}
	
	//create ARBCreateSubscriptionRequest text
	String getCancelSubscriptionRequestText(String login, String key, Payment paymentInfo){
		ARBAPI api = new ARBAPI(null, login, key);
		
		ARBSubscription cancel_subscription = new ARBSubscription();
		cancel_subscription.setSubscriptionId(paymentInfo.getSubscriptionId());
		
		// Create a new subscription request from the subscription object
		// Returns XML document. Also holds internal pointer as current_request.
		//
		api.cancelSubscriptionRequest(cancel_subscription);
		return api.getCurrentRequest().dump();	
	}
	//create xml request document/text		
	String getCreateSubscriptionRequestText(String login, String key, Payment paymentInfo, Date startDate, Business biz){
		ARBAPI api = new ARBAPI(null, login, key);
		
		// Create a payment schedule
		//
		ARBPaymentSchedule new_schedule = new ARBPaymentSchedule();
		new_schedule.setIntervalLength(1);
		new_schedule.setSubscriptionUnit("months");
		println com.anet.api.util.DateUtil.getFormattedDate(startDate, "yyyy-MM-dd")
		new_schedule.setStartDate(com.anet.api.util.DateUtil.getFormattedDate(startDate, "yyyy-MM-dd"));
		new_schedule.setTotalOccurrences(9999);
		//new_schedule.setTrialOccurrences(0
		
		// Create a new credit card
		//
		CreditCard credit_card = new CreditCard();
		credit_card.setCardNumber(paymentInfo.getCardNumber());
		credit_card.setExpirationDate("20" + paymentInfo.getExpireYear()+ "-" + paymentInfo.getExpireMonth());
		
		// Create Order Details
		//
		//ARBOrder order = new ARBOrder();
		//order.setInvoiceNumber("12345");
		//order.setDescription("Sample Description");
		
		// Create customer and specify billing info
		//
		//ARBCustomer customer = new ARBCustomer();
		//customer.setId("100");
		//customer.setEmail("nowhere@fakeEmail.com");
		//customer.setPhoneNumber("555-123-4567");
		//customer.setFaxNumber("555-345-6789");
		
		// Create bill-to address
		//
		ARBNameAndAddress billing_info = new ARBNameAndAddress();
		billing_info.setFirstName(paymentInfo.getFirstName());
		billing_info.setLastName(paymentInfo.getLastName());
		//billing_info.setCompany("Business Co.");
		billing_info.setAddress(paymentInfo.getBillingAddress());
		billing_info.setCity(paymentInfo.getCity());
		billing_info.setState(paymentInfo.getState());
		billing_info.setZip(paymentInfo.getZipcode());
		billing_info.setCountry("US");
		
		// Create a subscription and specify payment, schedule and customer
		//
		ARBSubscription new_subscription = new ARBSubscription();
		new_subscription.setPayment(new ARBPayment(credit_card));
		// use the line above for credit card or the line beow for bank account
		// new_subscription.setPayment(new ARBPayment(bank_account));
		new_subscription.setSchedule(new_schedule);
		new_subscription.setBillTo(billing_info);
		//new_subscription.setShipTo(shipping_info);
		//new_subscription.setCustomer(customer);
		//new_subscription.setOrder(order);
		new_subscription.setAmount(paymentInfo.getAmount() as double);
		//new_subscription.setTrialAmount(0.00);.
		
		// Give this subscription a name
		//
		//new_subscription.setName("in-the Door Advertising Subscription");
		String name = com.anet.api.util.DateUtil.getFormattedDate(startDate, "yyyy-MM-dd") +
				' - ' + biz. businessName;
		if(name.length() > 50)
			name = name.substring(0, 50);
		new_subscription.setName(name);
		// Create a new subscription request from the subscription object
		// Returns XML document. Also holds internal pointer as current_request.
		//
		api.createSubscriptionRequest(new_subscription);
		return api.getCurrentRequest().dump();
		
	}
	//create ARBUpdateSubscriptionRequest text
	String getUpdateSubscriptionRequestText(String login, String key, Payment paymentInfo, Business biz){
		ARBAPI api = new ARBAPI(null, login, key);

		CreditCard credit_card = new CreditCard();
		credit_card.setCardNumber(paymentInfo.getCardNumber());
		credit_card.setExpirationDate("20" + paymentInfo.getExpireYear()+ "-" + paymentInfo.getExpireMonth());
		
		ARBNameAndAddress billing_info = new ARBNameAndAddress();
		billing_info.setFirstName(paymentInfo.getFirstName());
		billing_info.setLastName(paymentInfo.getLastName());
		billing_info.setAddress(paymentInfo.getBillingAddress());
		billing_info.setCity(paymentInfo.getCity());
		billing_info.setState(paymentInfo.getState());
		billing_info.setZip(paymentInfo.getZipcode());
		billing_info.setCountry("US");
		
		ARBSubscription update_subscription = new ARBSubscription();
		update_subscription.setSubscriptionId(paymentInfo.getSubscriptionId());
		update_subscription.setPayment(new ARBPayment(credit_card));
		update_subscription.setBillTo(billing_info);
		update_subscription.setAmount(paymentInfo.getAmount() as double);
		
		// Create a new subscription request from the subscription object
		// Returns XML document. Also holds internal pointer as current_request.
		api.updateSubscriptionRequest(update_subscription);
		return api.getCurrentRequest().dump();
		
	}
	
	public boolean isSubscriptionApproved() {
		if(subscriptionResponse)
			if(subscriptionResponse.containsKey(AUTHORIZE_NET_SUBSCRIPTION_SUCCESSFUL))
				return true
		
		return false
	}
	
	public String getSubcriptionId() {
		if(subscriptionResponse)
			if(subscriptionResponse.containsKey(AUTHORIZE_NET_SUBSCRIPTION_SUCCESSFUL))
				return subscriptionResponse.get("result_subscription_id")
		
		return ""
	}	
	
	
	public boolean isPaymentApproved() {
		if(paymentResponse)
			if(paymentResponse.getAt(0) == AUTHORIZE_NET_APPROVED)
				return true
		
		return false
	}
	
	public String getResponseText() {
		if(paymentResponse)
			return paymentResponse.getAt(3)
		return ""
	}	
	
	public String getTransactionId() {
		if(paymentResponse)
			return paymentResponse.getAt(6)
		return ""
	}
	
	public String getApprovalCode() {
		if(paymentResponse)
			return paymentResponse.getAt(4)
		return ""		
	}
	
	public List getPaymentResponse() {
		return paymentResponse;
	}
	
	
	public String getErrorMessageProp(){
		if(paymentResponse)
			switch(paymentResponse.getAt(0)){
				case AUTHORIZE_NET_DECLINED:
					return "net.authorize.itda.custome." + paymentResponse.getAt(2)
				
				case AUTHORIZE_NET_ERROR:
					return "net.authorize.itda.custome." + paymentResponse.getAt(2)
				
				default: // to do what about key error
					return "authorize.net.unknown.error"	
			}
		else
			return ""
	}
	
	public String getSubscriptionErrorMessageProp(){
		if(subscriptionResponse) {
			if(subscriptionResponse.containsKey("E00001"))
				return "authorize.net.try.again.E00001"
			if(subscriptionResponse.containsKey("E00018"))
				return "authorize.net.cc.expired.E00018"
			if(subscriptionResponse.containsKey("E00013"))
				return "authorize.net.invalid.field.E00013"
		}
		
		return ""
	}
	public HashMap getSubscriptionResponse() {
		return subcriptionResponse;
	}	
}

