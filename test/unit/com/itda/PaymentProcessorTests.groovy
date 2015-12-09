package com.itda;
import grails.test.*
import com.ondemand1.util.PaymentProcessor

class PaymentProcessorTests extends GrailsUnitTestCase {

    public final String   PARAMETERS = "x_login=54PB5egZ&x_tran_key=48V258vr55AE8tcg&x_version=3.1&x_delim_data=TRUE&x_delim_char=|&x_relay_response=FALSE&x_method=CC&x_device_type=8"	
    public final String  URL = "https://test.authorize.net/gateway/transact.dll"
        
	protected void setUp() {
		super.setUp()
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testAuthorizeAndCapture() {
		def url = URL
		def postString = PARAMETERS	
		Hashtable post_values = new Hashtable();

		post_values.put ("x_type", "AUTH_CAPTURE");
		post_values.put ("x_card_num", "4111111111111111");
		post_values.put ("x_exp_date", "0115");
		String amount = (new java.util.Random()).nextInt(2000) as String
		post_values.put ("x_amount", amount);
		post_values.put ("x_description", "Sample Transaction");
		
		post_values.put ("x_first_name", "John");
		post_values.put ("x_last_name", "Doe");
		post_values.put ("x_address", "1234 Street");
		post_values.put ("x_state", "WA");
		post_values.put ("x_zip", "98004");
		post_values.put ("x_card_code", "123");
		
		Enumeration keys = post_values.keys();
		while( keys.hasMoreElements() ) {
			String key = keys.nextElement().toString()
		  String value = URLEncoder.encode(post_values.get(key).toString(),"UTF-8");
		  postString += "&" + key  + "=" + value
		}

		
		def pp = new PaymentProcessor()
		pp.processPayment (url, postString)
		def results = pp.getPaymentResponse()
		
		assertEquals "This transaction has been approved.", results.get(3)
		assertEquals 1, results.get(1) as int
		assertEquals true, pp.isPaymentApproved()	
	}

	void testAuthorizeThenCapture() {
		Double amount = (new java.util.Random()).nextInt(2000) as Double

		def paymentInfo = new Payment(
							firstName: "firstName", lastName: "lastName",
							billingAddress: "123 My Way", city: "cityName",
							state: "CA", zipcode: "98765",
							cardNumber: "4111111111111111", expireYear: "15", expireMonth: "10",
							cardSecurityCode: "123", description: "registration fee", amount: amount
							)
		
		def pp = new PaymentProcessor()
		StringBuffer postString = paymentInfo.authorizeOnlyttpParamsAsStringBuffer()
		postString.append("&").append(PARAMETERS)
		println "<testAuthorizeThenCapture>"+  postString.toString() + "</testAuthorizeThenCapture>"
		pp.processPayment (URL, postString.toString())
		def results = pp.getPaymentResponse()
		assertEquals "This transaction has been approved.", results.get(3)
		assertEquals 1, results.get(1) as int
		assertEquals true, pp.isPaymentApproved()		
		
		println "<testAuthorizeThenCapture>"+  results.toString() + "</testAuthorizeThenCapture>"

		paymentInfo.approvalCode = pp.getApprovalCode()
		paymentInfo.transactionId = pp.getTransactionId()

		postString = paymentInfo.priorAuthorizeCaptureHttpParamsAsStringBuffer()
		postString.append("&").append(PARAMETERS)
		println "<testAuthorizeThenCapture>"+  postString.toString() + "</testAuthorizeThenCapture>"
		pp.processPayment (URL, postString.toString())
		results = pp.getPaymentResponse()
		println "<testAuthorizeThenCapture>"+  results.toString() + "</testAuthorizeThenCapture>"
		
		assertEquals "This transaction has been approved.", results.get(3)
		assertEquals 1, results.get(1) as int
		assertEquals true, pp.isPaymentApproved()		
	}	

	void testAuthorizeThenVoid() {
		Double amount = (new java.util.Random()).nextInt(2000) as Double

		def paymentInfo = new Payment(
							firstName: "firstName", lastName: "lastName",
							billingAddress: "123 My Way", city: "cityName",
							state: "CA", zipcode: "98765",
							cardNumber: "4111111111111111", expireYear: "15", expireMonth: "10",
							cardSecurityCode: "123", description: "registration fee", amount: amount
							)
		
		def pp = new PaymentProcessor()
		StringBuffer postString = paymentInfo.authorizeOnlyttpParamsAsStringBuffer()
		postString.append("&").append(PARAMETERS)
		println "<testAuthorizeThenVoid>"+  postString.toString() + "</testAuthorizeThenVoid>"
		pp.processPayment (URL, postString.toString())
		def results = pp.getPaymentResponse()
		assertEquals "This transaction has been approved.", results.get(3)
		assertEquals 1, results.get(1) as int
		assertEquals true, pp.isPaymentApproved()		
		
		println "<testAuthorizeThenVoid>"+  results.toString() + "</testAuthorizeThenVoid>"

		paymentInfo.approvalCode = pp.getApprovalCode()
		paymentInfo.transactionId = pp.getTransactionId()

		postString = paymentInfo.voidHttpParamsAsStringBuffer()
		postString.append("&").append(PARAMETERS)
		println "<testAuthorizeThenVoid>"+  postString.toString() + "</testAuthorizeThenVoid>"
		pp.processPayment (URL, postString.toString())
		results = pp.getPaymentResponse()
		println "<testAuthorizeThenVoid>"+  results.toString() + "</testAuthorizeThenVoid>"
		
		assertEquals "This transaction has been approved.", results.get(3)
		assertEquals 1, results.get(1) as int
		assertEquals true, pp.isPaymentApproved()		
	}	
	
	void testInvalidCard() {
		Double amount = (new java.util.Random()).nextInt(2000) as Double

		def paymentInfo = new Payment(
							firstName: "firstName", lastName: "lastName",
							billingAddress: "123 My Way", city: "cityName",
							state: "CA", zipcode: "98765",
							cardNumber: "0111111111111111", expireYear: "15", expireMonth: "10",
							cardSecurityCode: "123", description: "registration fee", amount: amount
							)
		
		def pp = new PaymentProcessor()
		StringBuffer postString = paymentInfo.authorizeOnlyttpParamsAsStringBuffer()
		postString.append("&").append(PARAMETERS)
		println "<testInvalidCard>"+  postString.toString() + "</testInvalidCard>"
		pp.processPayment (URL, postString.toString())
		def results = pp.getPaymentResponse()
		//assertEquals "This transaction has been approved.", results.get(3)
		//assertEquals 1, results.get(1) as int
		assertEquals false, pp.isPaymentApproved()		
		
	}	

	void testExpiredCard() {
		Double amount = (new java.util.Random()).nextInt(2000) as Double

		def paymentInfo = new Payment(
							firstName: "firstName", lastName: "lastName",
							billingAddress: "123 My Way", city: "cityName",
							state: "CA", zipcode: "98765",
							cardNumber: "4111111111111111", expireYear: "09", expireMonth: "09",
							cardSecurityCode: "123", description: "registration fee", amount: amount
							)
		
		def pp = new PaymentProcessor()
		StringBuffer postString = paymentInfo.authorizeOnlyttpParamsAsStringBuffer()
		postString.append("&").append(PARAMETERS)
		println "<testExpiredCard>"+  postString.toString() + "</testExpiredCard>"
		pp.processPayment (URL, postString.toString())
		def results = pp.getPaymentResponse()
		//assertEquals "This transaction has been approved.", results.get(3)
		//assertEquals 1, results.get(1) as int
		assertEquals false, pp.isPaymentApproved()		
		
	}	
	
}
