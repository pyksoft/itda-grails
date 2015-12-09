package com.itda;
import org.hsqldb.lib.HashMap;

import grails.test.GrailsUnitTestCase;
import com.anet.api.http.HttpUtil;
import com.anet.api.*;
import com.ondemand1.util.PaymentProcessor;
import java.util.HashMap;
//import APIUtilities;

class AuthorizeNetSubcriptionTests extends GrailsUnitTestCase {

    public final String   PARAMETERS = //"x_login=54PB5egZ&x_tran_key=48V258vr55AE8tcg&x_version=3.1&x_delim_data=TRUE&x_delim_char=|&x_relay_response=FALSE&x_method=CC&x_device_type=8"
    								   "x_login=54PB5egZ&x_tran_key=48V258vr55AE8tcg&x_version=3.1&x_delim_data=TRUE&x_delim_char=|&x_relay_response=FALSE&x_method=CC&x_device_type=8"
    public final String  APIURL = "https://apitest.authorize.net/xml/v1/request.api";
    public final String  TXURL = "https://test.authorize.net/gateway/transact.dll";    
    public final String  login = "54PB5egZ";
    public final String  key = "48V258vr55AE8tcg";
        
	protected void setUp() {
		super.setUp()
	}
	
	protected void tearDown() {
		super.tearDown()
	}
	
	void testCreateUpdateDeleteSubscription() {
		
		PaymentProcessor pp = new PaymentProcessor()
		def payInfo = createPaymentInfo("15")
		
		StringBuffer paymentParams = payInfo.authorizeCaptureHttpParamsAsStringBuffer()
		paymentParams.append('&').append( PARAMETERS )  
		pp.processPayment(TXURL, paymentParams.toString());
		payInfo.approvalCode = pp.getApprovalCode()
		payInfo.transactionId = pp.getTransactionId()
		payInfo.response = pp.getPaymentResponse();
		println payInfo.response;
		assertTrue(pp.isPaymentApproved());	
		
		def biz = createBusinessInfo ();
		GregorianCalendar cal = new GregorianCalendar();
		cal.add(Calendar.MONTH, 1);		
		String xml = pp.getCreateSubscriptionRequestText("54PB5egZ", "48V258vr55AE8tcg", 
					payInfo, cal.getTime(), biz);
		HashMap map = pp.processSubcription(APIURL, xml);
println map.toString()
		assertNotNull  map.get("I00001") 
		def subId = map.get("result_subscription_id") as String
		payInfo.subscriptionId = subId
		assertNotNull subId
		
		//update subscription
		//payInfo.setExpireYear "10";
		xml = pp.getUpdateSubscriptionRequestText("54PB5egZ", "48V258vr55AE8tcg", payInfo, biz);	
		
		map = pp.processSubcription(APIURL, xml);
		println map.toString();
		assertNotNull  map.get("I00001");
		
		//cancel subscription
		xml = pp.getCancelSubscriptionRequestText("54PB5egZ", "48V258vr55AE8tcg", payInfo);
		println " cancel request is " + xml;
		map = pp.processSubcription(APIURL, xml)
		println map.toString()
		//assertNotNull  map.get("I00001")		
	}

	void donttestDeleteSubscription() {
		
		//def pp = new PaymentProcessor()
		//CreateSubscriptionExample.main(["https://apitest.authorize.net/xml/v1/request.api","54PB5egZ" , "48V258vr55AE8tcg"] as String[])
		PaymentProcessor pp = new PaymentProcessor()
		def payInfo = createPaymentInfo("15")

		for (subId in ['1151300','1151301', '1151302', '1151303']) {
		payInfo.subscriptionId = subId
			//cancel subscription
			def xml = pp.getCancelSubscriptionRequestText("54PB5egZ", "48V258vr55AE8tcg", payInfo);
			println " cancel request is " + xml;
			def map = pp.processSubcription(APIURL, xml)
			println map.toString()
			//assertNotNull  map.get("I00001")		
		}
	}
	
	void notToTestExampleSubscription() {
		
		CreateSubscriptionExample.main(["https://apitest.authorize.net/xml/v1/request.api","54PB5egZ" , "48V258vr55AE8tcg"] as String[])	
	}
		
/* 
<?xml version="1.0" encoding="utf-8"?> 
<ARBCreateSubscriptionResponse xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xmlns:xsd="http://www.w3.org/2001/XMLSchema" 
	xmlns="AnetApi/xml/v1/schema/AnetApiSchema.xsd">
	<messages>
		<resultCode>Ok</resultCode>
		<message>
			<code>I00001</code>
			<text>Successful.</text>
		</message>
	</messages>
	<subscriptionId>598865</subscriptionId>
</ARBCreateSubscriptionResponse>
*/
	void dontestExpiredCard() {
		
		Double amount = (new java.util.Random()).nextInt(2000) as Double
		
		def paymentInfo = new Payment(
				firstName: "firstName", lastName: "lastName",
				billingAddress: "123 My Way", city: "cityName",
				state: "CA", zipcode: "98765",
				cardNumber: "4111111111111111", expireYear: "09", expireMonth: "09",
				cardSecurityCode: "123", description: "registration fee", amount: amount
				)
		
		PaymentProcessor pp = new PaymentProcessor()
		String xml = pp.createSubscriptionRequest("54PB5egZ", "48V258vr55AE8tcg", 
					paymentInfo, (new GregorianCalendar()).getTime(), createBusinessInfo ())
		HashMap map = pp.processSubcription(APIURL, xml)
		assertEquals "The credit card has expired.", map.get("E00013") as String
		
	}	
	void donttestBadCardNumber() {
		
		Double amount = (new java.util.Random()).nextInt(2000) as Double
		
		def paymentInfo = new Payment(
				firstName: "firstName", lastName: "lastName",
				billingAddress: "123 My Way", city: "cityName",
				state: "CA", zipcode: "98765",
				cardNumber: "1111111111111111", expireYear: "15", expireMonth: "09",
				cardSecurityCode: "123", description: "registration fee", amount: amount
				)
		
		PaymentProcessor pp = new PaymentProcessor()
		String xml = pp.createSubscriptionRequest("54PB5egZ", "48V258vr55AE8tcg", 
						paymentInfo, (new GregorianCalendar()).getTime(), createBusinessInfo ())
		HashMap map = pp.processSubcription(APIURL, xml)
		assertEquals "Credit Card Number is invalid.", map.get("E00013") as String
				
	}	
		
	void dontestAuthorizeCaptureTx() {
		
		//def pp = new PaymentProcessor()
		//CreateSubscriptionExample.main(["https://apitest.authorize.net/xml/v1/request.api","54PB5egZ" , "48V258vr55AE8tcg"] as String[])
		PaymentProcessor pp = new PaymentProcessor()
		def payInfo = createPaymentInfo("15")
		
		StringBuffer paymentParams = payInfo.authorizeCaptureHttpParamsAsStringBuffer()
		paymentParams.append('&').append( PARAMETERS )  
		pp.processPayment(TXURL, paymentParams.toString());
		payInfo.approvalCode = pp.getApprovalCode()
		payInfo.transactionId = pp.getTransactionId()
		payInfo.response = pp.getPaymentResponse();
		println payInfo.response;
		assertTrue(pp.isPaymentApproved());
	}
	
	
	private Payment createPaymentInfo(String expireYy = "15") 
	{
		Double amount = (new java.util.Random()).nextInt(2000) as Double
		
		def paymentInfo = new Payment(
				firstName: "firstName", lastName: "lastName",
				billingAddress: "123 My Way", city: "cityName",
				state: "CA", zipcode: "98765",
				cardNumber: "4111111111111111", expireYear: expireYy, expireMonth: "09",
				cardSecurityCode: "123", description: "registration fee", amount: amount
				)
		return paymentInfo	
	}
	
	private Business createBusinessInfo () {
		long id = System.currentTimeMillis();
		return new Business(businessName: "testOffice" + id, phone:"222-222-2222", email:"eric-eric-eric@mail.com", representativeName:'owner name', id:id);

	}
}


public class APIUtilities {
	
	// TODO: change to https://api.authorize.net/xml/v1/request.api
	//
	public static final String API_URL = "https://apitest.authorize.net/xml/v1/request.api";
	
	// TODO: Specify your API login name
	//
	public static final String API_LOGIN_NAME = "54PB5egZ";

	// TODO: Specify you API key
	//
	public static final String API_KEY = "48V258vr55AE8tcg";
	
	public static String prepareXml(String xml) {
		xml = xml.replace('$xmldecl$', "<?xml version=\"1.0\" encoding=\"utf-8\"?>");
		xml = xml.replace('$xmlns$', 'xmlns=\'AnetApi/xml/v1/schema/AnetApiSchema.xsd\'');
		xml = xml.replace('$merchauth$', '<merchantAuthentication><name>' + API_LOGIN_NAME + '</name><transactionKey>' + API_KEY + '</transactionKey></merchantAuthentication>');
		return xml;
	}
	
	// If you have org.apache.commons.lang.StringEscapeUtils, use that instead.
	public static String escapeXml(String str) {
		str = str.replace("&", "&amp;");
		str = str.replace("<", "&lt;");
		str = str.replace(">", "&gt;");
		return str;
	}
	
	public static java.util.Random rand = new java.util.Random();
	
	public static org.w3c.dom.Document sendRequest(String xml) {
		System.out.println("Posting data to " + API_URL);
		System.out.println(xml);
		try {
			java.net.URL url = new java.net.URL(API_URL);
			java.net.HttpURLConnection conn = (java.net.HttpURLConnection)url.openConnection();
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "text/xml; charset=utf-8");
			conn.setAllowUserInteraction(false);
			// POST the data
			java.io.OutputStreamWriter sw = new java.io.OutputStreamWriter(conn.getOutputStream(), "UTF8");
			sw.write(xml);
			sw.flush();
			sw.close();
			// Get the Response
			java.io.InputStream resultStream = conn.getInputStream();
			java.io.BufferedReader aReader = new java.io.BufferedReader(new java.io.InputStreamReader(resultStream, "UTF8"));
			StringBuffer aResponse = new StringBuffer();
			String aLine = aReader.readLine();
			while(aLine != null) {
				aResponse.append(aLine);
				aLine = aReader.readLine();
			}
			resultStream.close();
			System.out.println("Response:");
			System.out.println(aResponse.toString());
			// Remove BOM because the current version of InputStreamReader doesn't do that for you as it should. 
			if (aResponse.length() > 0 && (int)aResponse.charAt(0) == 0xFEFF) {
				aResponse.deleteCharAt(0);
			}
			// Parse the Response
			javax.xml.parsers.DocumentBuilder docBuilder = javax.xml.parsers.DocumentBuilderFactory.newInstance().newDocumentBuilder();
			java.io.StringReader stringReader = new java.io.StringReader(aResponse.toString());
			org.w3c.dom.Document doc = docBuilder.parse(new org.xml.sax.InputSource(stringReader));
			stringReader.close();
			// Check API response for errors
			javax.xml.xpath.XPathFactory xpathFactory = javax.xml.xpath.XPathFactory.newInstance();
			javax.xml.xpath.XPath xpath = xpathFactory.newXPath();
			String resultCode = xpath.evaluate("/*/messages/resultCode/text()",  doc);
			if ("Ok".equalsIgnoreCase(resultCode)) {
				// API call was successful
				return doc;
			} else {
				// Print errors
				System.out.println("The API call was not successful. Error list:");
				org.w3c.dom.NodeList nodes = (org.w3c.dom.NodeList)xpath.evaluate("/*/messages/message", doc, javax.xml.xpath.XPathConstants.NODESET);
				if (nodes != null) {
					for (int i = 0; i < nodes.getLength(); i++) {
						org.w3c.dom.Node node = nodes.item(i);
						String code = "", text = "";
						code = xpath.evaluate("code/text()", node);
						text = xpath.evaluate("text/text()", node);
						System.out.println("[" + code + "] " + text);
					}
				}
				return null;
			}
		} catch (Exception ex) {
			System.out.println(ex.toString());
		}
		return null;
	}
	void donttestCreateAuthNetCustomerProfile() {
		//    def xml1 = '$xmldecl$\r\n<deleteCustomerProfileRequest $xmlns$>$merchauth$<customerProfileId>$customerProfileId$</customerProfileId></deleteCustomerProfileRequest>';
		//    xml1 = xml1.replace('$customerProfileId$', APIUtilities.escapeXml("4471369"));
		//    xml1 = APIUtilities.prepareXml(xml1);

			
			PaymentProcessor pp = new PaymentProcessor();
			Business biz = createBusinessInfo();
			Payment paymentInfo = createPaymentInfo("19");
			String xml = pp.createAuthNetCustomerProfile( APIURL, login, key, paymentInfo, biz	);
			if(xml.charAt(0) == 0xFEFF)
				xml = xml.substring(1);
			println xml;
			String customerProfileId;
			
			// Parse the Response
			javax.xml.parsers.DocumentBuilder docBuilder = javax.xml.parsers.DocumentBuilderFactory.newInstance().newDocumentBuilder();
			java.io.StringReader stringReader = new java.io.StringReader(xml);
			org.w3c.dom.Document doc = docBuilder.parse(new org.xml.sax.InputSource(stringReader));
			//stringReader.close();
			// Check API response for errors
			javax.xml.xpath.XPathFactory xpathFactory = javax.xml.xpath.XPathFactory.newInstance();
			javax.xml.xpath.XPath xpath = xpathFactory.newXPath();
			String resultCode = xpath.evaluate("/*/messages/resultCode/text()",  doc);
			if ("Ok".equalsIgnoreCase(resultCode)) {
				// API call was successful
				println "response is OK"
				xpath = javax.xml.xpath.XPathFactory.newInstance().newXPath();
				customerProfileId = xpath.evaluate("/*/customerProfileId/text()",  doc);
			} else {
				// Print errors
				System.out.println("The API call was not successful. Error list:");
				org.w3c.dom.NodeList nodes = (org.w3c.dom.NodeList)xpath.evaluate("/*/messages/message", doc, javax.xml.xpath.XPathConstants.NODESET);
				if (nodes != null) {
					for (int i = 0; i < nodes.getLength(); i++) {
						org.w3c.dom.Node node = nodes.item(i);
						String code = "", text = "";
						code = xpath.evaluate("code/text()", node);
						text = xpath.evaluate("text/text()", node);
						System.out.println("[" + code + "] " + text);
					}
				}
			}	
		    xml = '$xmldecl$\r\n<deleteCustomerProfileRequest $xmlns$>$merchauth$<customerProfileId>$customerProfileId$</customerProfileId></deleteCustomerProfileRequest>';
			xml = xml.replace('$customerProfileId$', APIUtilities.escapeXml(customerProfileId));
			xml = APIUtilities.prepareXml(xml);
			
			doc = APIUtilities.sendRequest(xml);
			
			if (doc != null) {
				System.out.println("Successfully deleted customer profile id " + customerProfileId);
			}		
		}
		
		void dontrtestCreateDeleteCustomerProfile() throws Exception{
			System.out.println("Create Profile Test");
			def xml1 = 
				'$xmldecl$\r\n<createCustomerProfileRequest $xmlns$>$merchauth$<profile><merchantCustomerId>$custid$</merchantCustomerId><description>$descr$</description><email>$email$</email>';
			def xml2 = 
				"""
	<paymentProfiles>
	    <billTo>
	      <firstName>John</firstName>
	      <lastName>Doe</lastName>
	      <address>123 Main St.</address>
	      <city>Bellevue</city>
	      <state>WA</state>
	      <zip>98004</zip>
	    </billTo>
	    <payment>
	      <creditCard>
	        <cardNumber>4111111111111111</cardNumber>
	        <expirationDate>2023-12</expirationDate>
			<cardCode>123</cardCode>
	      </creditCard>
	    </payment>
			</paymentProfiles>
		
	""";			
		String xml = xml1 + xml2	+	'</profile><validationMode>testMode</validationMode></createCustomerProfileRequest>';
			xml = xml.replace('$custid$', APIUtilities.escapeXml("custId" + APIUtilities.rand.nextInt()));
			xml = xml.replace('$descr$', APIUtilities.escapeXml("some description"));
			xml = xml.replace('$email$', APIUtilities.escapeXml("samplesamplesample@example.com"));
			xml = APIUtilities.prepareXml(xml);
			
			org.w3c.dom.Document doc = APIUtilities.sendRequest(xml);
			
			String customerProfileId = null;
			
			if (doc != null) {
				try {
					javax.xml.xpath.XPath xpath = javax.xml.xpath.XPathFactory.newInstance().newXPath();
					customerProfileId = xpath.evaluate("/*/customerProfileId/text()",  doc);
					System.out.println("Successfully created customer profile id " + customerProfileId);
					org.w3c.dom.NodeList customerPaymentProfileIdList = (org.w3c.dom.NodeList)xpath.evaluate("/*/customerPaymentProfileIdList/numericString/text()", doc, javax.xml.xpath.XPathConstants.NODESET);
					org.w3c.dom.NodeList validationDirectResponseList = (org.w3c.dom.NodeList)xpath.evaluate("/*/validationDirectResponseList/string/text()", doc, javax.xml.xpath.XPathConstants.NODESET);
					org.w3c.dom.NodeList customerShippingAddressIdList = (org.w3c.dom.NodeList)xpath.evaluate("/*/customerShippingAddressIdList/numericString/text()", doc, javax.xml.xpath.XPathConstants.NODESET);
					if (customerPaymentProfileIdList != null) {
						for (int i = 0; i < customerPaymentProfileIdList.getLength(); i++) {
							System.out.print(" - customer payment profile id " + customerPaymentProfileIdList.item(i).getNodeValue());
							if (validationDirectResponseList != null && i < validationDirectResponseList.getLength()) {
								String s = validationDirectResponseList.item(i).getNodeValue();
								if (s.length() > 40) {
									s = s.substring(0, 39) + "...";
								}
								System.out.print(" ; validation raw response: " + s);
							}
							System.out.println();
						}
						for (int i = 0; i < customerShippingAddressIdList.getLength(); i++) {
							System.out.println(" - customer shipping address id " + customerShippingAddressIdList.item(i).getNodeValue());
						}
					}
				} catch (Exception ex) {
					System.out.println(ex.toString());
					throw ex;
				}
			}

			
		    xml = '$xmldecl$\r\n<deleteCustomerProfileRequest $xmlns$>$merchauth$<customerProfileId>$customerProfileId$</customerProfileId></deleteCustomerProfileRequest>';
			xml = xml.replace('$customerProfileId$', APIUtilities.escapeXml(customerProfileId));
			xml = APIUtilities.prepareXml(xml);
			
			doc = APIUtilities.sendRequest(xml);
			
			if (doc != null) {
				System.out.println("Successfully deleted customer profile id " + customerProfileId);
			}		
		}

}