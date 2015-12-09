/*
 * Before working with this sample code, please be sure to read the accompanying Readme.txt file.
 * It contains important information regarding the appropriate use of and conditions for this sample
 * code. Also, please pay particular attention to the comments included in each individual code file,
 * as they will assist you in the unique and correct implementation of this code on your specific platform.
 *
 * Copyright 2008 Authorize.Net Corp.
 */
package authorizenet;

import java.util.List;

import grails.test.GrailsUnitTestCase;
//import java.net.MalformedURLException;
//import java.net.URL;
import AuthNet.Rebill.*;
//import javax.xml.namespace.QName;
import java.math.BigDecimal;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;


public class CreateProfilesTest  extends GrailsUnitTestCase {

	public void testMain() throws Exception{
		
		System.out.println(SoapAPIUtilities.getExampleLabel("Create Profiles Test"));
		ServiceSoap soap = SoapAPIUtilities.getServiceSoap();

		CustomerPaymentProfileType new_payment_profile = new CustomerPaymentProfileType();
		
		PaymentType new_payment = new PaymentType();
		//BankAccountType new_bank = new BankAccountType();
		//new_bank.setAccountNumber("4111111");
		
		CreditCardType new_card = new CreditCardType();
		new_card.setCardNumber("4111111111111111"); //Visa
		
		CustomerAddressType cust_addr = new CustomerAddressType();//Needed for Visa only
		cust_addr.setAddress("100 temp st");
		cust_addr.setCity("San Diego");
		cust_addr.setState("CA");
		cust_addr.setZip("92121");
		new_payment_profile.setBillTo(cust_addr);
		
		
		//new_card.setCardNumber("5555555555554444"); //Mastercard
		
		try{
			javax.xml.datatype.XMLGregorianCalendar cal = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar();
			cal.setMonth(2);
			cal.setYear(2015);
			new_card.setExpirationDate(cal);
			// System.out.println(new_card.getExpirationDate().toXMLFormat());
		}
		catch(javax.xml.datatype.DatatypeConfigurationException dce){
			System.out.println(dce.getMessage());
			throw dce;
		}
		
		new_payment.setCreditCard(new_card);
		//new_payment.setBankAccount(new_bank);
		
		new_payment_profile.setPayment(new_payment);
		

		CustomerProfileType m_new_cust = new CustomerProfileType();
		m_new_cust.setEmail("here@there.com");
		m_new_cust.setDescription("Example customer: " + Long.toString(System.currentTimeMillis()));

		
		ArrayOfCustomerPaymentProfileType pay_list = new ArrayOfCustomerPaymentProfileType();
		pay_list.getCustomerPaymentProfileType().add(new_payment_profile);
		
		m_new_cust.setPaymentProfiles(pay_list);
		
		CreateCustomerProfileResponseType response = soap.createCustomerProfile(SoapAPIUtilities.getMerchantAuthentication(),m_new_cust,ValidationModeEnum.LIVE_MODE);

		assertNotNull(response);
		if(response != null){
			/* 
				Response Code: Ok
				Message: Successful.
				New ID = 9934358
				With payment profile ID = 8885453
			 */
			assertEquals("Ok", response.getResultCode().value());
			System.out.println("Response Code: " + response.getResultCode().value());
			for(int i = 0; i < response.getMessages().getMessagesTypeMessage().size(); i++){
				System.out.println("Message: " + response.getMessages().getMessagesTypeMessage().get(i).getText());
			}
			long new_cust_id = response.getCustomerProfileId();
			assertTrue(new_cust_id > 0);
			if(new_cust_id > 0){
				System.out.println("New Customer ID = " + new_cust_id);
			}
			ArrayOfLong aol = response.getCustomerPaymentProfileIdList();
			long paymentProfileId = 0;
			assertNotNull(aol);
			if (response.getCustomerPaymentProfileIdList() != null){
				for(Long id : aol.getLong()){
					System.out.println("With payment profile ID = " + id);
					paymentProfileId = id;
				}
			}
			
			//retrieve customer profile
			getCustomerProfile(new_cust_id, paymentProfileId);
		}
		else{
			System.out.println("Null response from server");
		}
		
	}
	
	private void getCustomerProfile(long profile_id, long paymentProfileId) throws Exception{
		ServiceSoap soap = SoapAPIUtilities.getServiceSoap();
		GetCustomerProfileResponseType response_type = soap.getCustomerProfile(SoapAPIUtilities.getMerchantAuthentication(), profile_id);
		assertNotNull(response_type);
		CustomerProfileMaskedType profile = response_type.getProfile();
		assertNotNull(profile);
		if(profile == null){
			System.out.println("Profile with id " + profile_id + " is null");
		}
		else{
			System.out.println("Retrieved profile " + profile.getCustomerProfileId() + " / " + profile.getDescription());
			ArrayOfCustomerPaymentProfileMaskedType aocppmt = profile.getPaymentProfiles();
			assertNotNull(aocppmt);
			if (aocppmt != null){
				List<CustomerPaymentProfileMaskedType> custPaymentList = aocppmt.getCustomerPaymentProfileMaskedType();
				assertTrue(custPaymentList.size() == 1); 
				for(CustomerPaymentProfileMaskedType paymentProfile : custPaymentList){
					System.out.println("With payment profile " + paymentProfile.getCustomerPaymentProfileId());
					assertEquals(paymentProfile.getCustomerPaymentProfileId(), paymentProfileId);
				}
			}
			createTransaction(profile);
			updateCustomerProfile(profile);
			deleteCustomerProfile(profile);
		}		
	}

	private void createTransaction(CustomerProfileMaskedType customer_profile) throws Exception{
			
			List<CustomerPaymentProfileMaskedType> payment_profiles = customer_profile.getPaymentProfiles().getCustomerPaymentProfileMaskedType();
			/*
			if(payment_profiles.size() >= 1){
				System.out.println("Please specify which payment profile to use:");
				for(int i = 0; i < payment_profiles.size(); i++){
					
					String card_num = null;
					if(payment_profiles.get(i).getPayment().getBankAccount() != null) card_num = payment_profiles.get(i).getPayment().getBankAccount().getAccountNumber();
					else if(payment_profiles.get(i).getPayment().getCreditCard() != null) card_num = payment_profiles.get(i).getPayment().getCreditCard().getCardNumber();
					System.out.println(payment_profiles.get(i).getCustomerPaymentProfileId() + " - " + card_num);
				}
				return;
			
			}
			*/
		ServiceSoap soap = SoapAPIUtilities.getServiceSoap();
		ProfileTransAuthCaptureType auth_capture = new ProfileTransAuthCaptureType();

		auth_capture.setCustomerProfileId(customer_profile.getCustomerProfileId());
		CustomerPaymentProfileMaskedType payProfile = payment_profiles.get(0);
		CreditCardMaskedType cc = payProfile.getPayment().getCreditCard();
		System.out.println("CC is " + cc.getCardNumber() + " " + cc.getExpirationDate());
		auth_capture.setCustomerPaymentProfileId(payProfile.getCustomerPaymentProfileId());//first credit card
		BigDecimal amount = new  BigDecimal((new java.util.Random()).nextInt(2000));
		auth_capture.setAmount(amount);
		OrderExType order = new OrderExType();
		order.setInvoiceNumber("invoice " + (new java.util.Date().toString()));
		auth_capture.setOrder(order);

		ProfileTransactionType trans = new ProfileTransactionType();
		trans.setProfileTransAuthCapture(auth_capture);

		CreateCustomerProfileTransactionResponseType response = soap.createCustomerProfileTransaction(SoapAPIUtilities.getMerchantAuthentication(), trans, null);
		assertNotNull (response);
		System.out.println(response.getDirectResponse());
		/*
	    // create JAXB context and instantiate marshaler
	    JAXBContext context = JAXBContext.newInstance(CreateCustomerProfileTransactionResponseType.class);
	    Marshaller m = context.createMarshaller();
	    m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
	    m.marshal(response, System.out);
		*/
		String respCode = response.getResultCode().value();
		assertEquals("Ok", respCode);
		System.out.println("createTransaction Response Code: " + respCode);
		for(int i = 0; i < response.getMessages().getMessagesTypeMessage().size(); i++){
			System.out.println("Message: " + response.getMessages().getMessagesTypeMessage().get(i).getText());
		}

	}
	
	private void updateCustomerProfile(CustomerProfileMaskedType profile){
			ServiceSoap soap = SoapAPIUtilities.getServiceSoap();
			// Change the description to be the current time
			//
			profile.setDescription(new java.util.Date().toString());
			UpdateCustomerProfileResponseType response = soap.updateCustomerProfile(SoapAPIUtilities.getMerchantAuthentication(), profile);
			
			String respCode = response.getResultCode().value();
			assertEquals("Ok", respCode);
			System.out.println("updateCustomerProfile Response Code: " + respCode);
			for(int i = 0; i < response.getMessages().getMessagesTypeMessage().size(); i++){
				System.out.println("Message: " + response.getMessages().getMessagesTypeMessage().get(i).getText());
			}
	}
	
	private void deleteCustomerProfile(CustomerProfileMaskedType profile){
		ServiceSoap soap = SoapAPIUtilities.getServiceSoap();
		DeleteCustomerProfileResponseType response = soap.deleteCustomerProfile(SoapAPIUtilities.getMerchantAuthentication(), profile.getCustomerProfileId());
		
		String respCode = response.getResultCode().value();
		assertEquals("Ok", respCode);		
		System.out.println("deleteCustomerProfile Response Code: " +respCode);
		for(int i = 0; i < response.getMessages().getMessagesTypeMessage().size(); i++){
			System.out.println("Message: " + response.getMessages().getMessagesTypeMessage().get(i).getText());
		}
	}
	
}
