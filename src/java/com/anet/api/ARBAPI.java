// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


package com.anet.api;

import com.anet.api.util.BasicXmlDocument;
import com.anet.api.http.HttpUtil;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

import org.w3c.dom.*;

// Import java.io.*;
public class ARBAPI{
   
   private BasicXmlDocument current_request = null;
   private BasicXmlDocument current_response = null;
   private String merchant_name = null;
   private String transaction_key = null;
   
   private ArrayList messages = null;
   private String result_code = null;
   private String result_subscription_id = null;

   private HttpUtil http_util = null;
   public ARBAPI(URL in_api_url, String in_merchant_name, String in_transaction_key){
      
      messages = new ArrayList();
      
      merchant_name = in_merchant_name;
      transaction_key = in_transaction_key;
      //http_util = new HttpUtil(in_api_url);
   }
   public BasicXmlDocument getCurrentRequest(){
      return current_request;
   
   }
   
   public BasicXmlDocument getCurrentResponse(){
      return current_response;
   }
   
   public String getResultCode(){
      return result_code;
   }
   public String getResultSubscriptionId(){
      return result_subscription_id;
   }
   
   public void destroy(){
      http_util.cleanup();
   }
   private void addSubscriptionIdToRequest(BasicXmlDocument document, ARBSubscription subscription){
      if(subscription.getSubscriptionId() != null){
         Element subscr_id_el = document.createElement(ARBAPIRequests.ELEMENT_SUBSCRIPTION_ID);
         subscr_id_el.appendChild(document.getDocument().createTextNode(subscription.getSubscriptionId()));
         document.getDocumentElement().appendChild(subscr_id_el);
      }  
   }
   private void addSubscriptionToRequest(BasicXmlDocument document, ARBSubscription subscription){
   
      addSubscriptionIdToRequest(document, subscription);
      
      Element subscr_el = document.createElement(ARBAPIRequests.ELEMENT_SUBSCRIPTION);
      if(subscription.getName() != null){
         Element name_el = document.createElement(ARBAPIRequests.ELEMENT_NAME);
         name_el.appendChild(document.getDocument().createTextNode(subscription.getName()));
         subscr_el.appendChild(name_el);
      }
      
      addPaymentScheduleToSubscription(document, subscription, subscr_el);
      if(subscription.getAmount() != 0 || subscription.getTrialAmount() != 0){
         Element amount_el = document.createElement(ARBAPIRequests.ELEMENT_AMOUNT);
         amount_el.appendChild(document.getDocument().createTextNode(Double.toString(subscription.getAmount())));
         subscr_el.appendChild(amount_el);
         Element trial_el = document.createElement(ARBAPIRequests.ELEMENT_TRIAL_AMOUNT);
         trial_el.appendChild(document.getDocument().createTextNode(Double.toString(subscription.getTrialAmount())));
         subscr_el.appendChild(trial_el);
      }
      
      addPaymentToSubscription(document, subscription, subscr_el);
      addOrderInfoToSubscription(document, subscription, subscr_el);
      addCustomerInfoToSubscription(document, subscription, subscr_el);
      addBillingInfoToSubscription(document, subscription, subscr_el);
      addShippingInfoToSubscription(document, subscription, subscr_el);
      document.getDocumentElement().appendChild(subscr_el);
   }
   
   private void addPaymentToSubscription(BasicXmlDocument document, ARBSubscription subscription, Element subscr_el){
      ARBPayment payment = subscription.getPayment();
      if(payment == null) return;
      
      Element payment_el = document.createElement(ARBAPIRequests.ELEMENT_PAYMENT);
      CreditCard credit_card= payment.getCreditCard();
      
      if(credit_card != null){
         Element cc_el = document.createElement(ARBAPIRequests.ELEMENT_CREDIT_CARD);
         
         Element cc_num_el = document.createElement(ARBAPIRequests.ELEMENT_CREDIT_CARD_NUMBER);
         cc_num_el.appendChild(document.getDocument().createTextNode(credit_card.getCardNumber()));
         cc_el.appendChild(cc_num_el);

         Element cc_exp_el = document.createElement(ARBAPIRequests.ELEMENT_CREDIT_CARD_EXPIRY);
         cc_exp_el.appendChild(document.getDocument().createTextNode(com.anet.api.util.DateUtil.getFormattedDate(credit_card.getExpirationDate(),CreditCard.EXPIRY_DATE_FORMAT)));
         cc_el.appendChild(cc_exp_el);
         
         payment_el.appendChild(cc_el);
      }
	  
      BankAccount bank_account = payment.getBankAccount();
      
      if(bank_account != null){
         Element ach_el = document.createElement(ARBAPIRequests.ELEMENT_BANK_ACCOUNT);
         
         Element ach_acc_type_el = document.createElement(ARBAPIRequests.ELEMENT_ACCOUNT_TYPE);
         ach_acc_type_el.appendChild(document.getDocument().createTextNode(bank_account.getAccountType()));
         ach_el.appendChild(ach_acc_type_el);
         
         Element ach_route_el = document.createElement(ARBAPIRequests.ELEMENT_ROUTING_NUMBER);
         ach_route_el.appendChild(document.getDocument().createTextNode(bank_account.getRoutingNumber()));
         ach_el.appendChild(ach_route_el);
         
         Element ach_account_el = document.createElement(ARBAPIRequests.ELEMENT_ACCOUNT_NUMBER);
         ach_account_el.appendChild(document.getDocument().createTextNode(bank_account.getAccountNumber()));
         ach_el.appendChild(ach_account_el);
         
         Element ach_name_el = document.createElement(ARBAPIRequests.ELEMENT_NAME_ON_ACCOUNT);
         ach_name_el.appendChild(document.getDocument().createTextNode(bank_account.getNameOnAccount()));
         ach_el.appendChild(ach_name_el);
         
         Element ach_type_el = document.createElement(ARBAPIRequests.ELEMENT_ECHECK_TYPE);
         ach_type_el.appendChild(document.getDocument().createTextNode(bank_account.getEcheckType()));
         ach_el.appendChild(ach_type_el);
	  
	     if(bank_account.getBankName() != null){
            Element bank_name_el = document.createElement(ARBAPIRequests.ELEMENT_BANK_NAME);
            bank_name_el.appendChild(document.getDocument().createTextNode(bank_account.getBankName()));
            ach_el.appendChild(bank_name_el);
         }
         
         payment_el.appendChild(ach_el);
      }
      
      subscr_el.appendChild(payment_el);
   }
   
   private void addOrderInfoToSubscription(BasicXmlDocument document, ARBSubscription subscription, Element subscr_el){
      if(subscription.getOrder() == null) return;
      ARBOrder ord_info = subscription.getOrder();
      Element ord_el = document.createElement(ARBAPIRequests.ELEMENT_ORDER);
		
      if(ord_info.getInvoiceNumber() != null){
        Element invoice_el = document.createElement(ARBAPIRequests.ELEMENT_INVOICE_NUMBER);
        invoice_el.appendChild(document.getDocument().createTextNode(ord_info.getInvoiceNumber()));
        ord_el.appendChild(invoice_el);
      }
      
      if(ord_info.getDescription() != null){
        Element descript_el = document.createElement(ARBAPIRequests.ELEMENT_DESCRIPTION);
        descript_el.appendChild(document.getDocument().createTextNode(ord_info.getDescription()));
        ord_el.appendChild(descript_el);
      }
      
      subscr_el.appendChild(ord_el);
      
   }
   
   private void addCustomerInfoToSubscription(BasicXmlDocument document, ARBSubscription subscription, Element subscr_el){
      if(subscription.getCustomer() == null) return;
      ARBCustomer cust_info = subscription.getCustomer();
      Element cust_el = document.createElement(ARBAPIRequests.ELEMENT_CUSTOMER);
		
      if(cust_info.getId() != null){
        Element custId_el = document.createElement(ARBAPIRequests.ELEMENT_ID);
        custId_el.appendChild(document.getDocument().createTextNode(cust_info.getId()));
        cust_el.appendChild(custId_el);
      }
      
      if(cust_info.getEmail() != null){
        Element email_el = document.createElement(ARBAPIRequests.ELEMENT_EMAIL);
        email_el.appendChild(document.getDocument().createTextNode(cust_info.getEmail()));
        cust_el.appendChild(email_el);
      }

      if(cust_info.getPhoneNumber() != null){
        Element phone_el = document.createElement(ARBAPIRequests.ELEMENT_PHONE_NUMBER);
        phone_el.appendChild(document.getDocument().createTextNode(cust_info.getPhoneNumber()));
        cust_el.appendChild(phone_el);
      }

      if(cust_info.getFaxNumber() != null){
	    Element fax_el = document.createElement(ARBAPIRequests.ELEMENT_FAX_NUMBER);
        fax_el.appendChild(document.getDocument().createTextNode(cust_info.getFaxNumber()));
        cust_el.appendChild(fax_el);
      }
      
      subscr_el.appendChild(cust_el);
      
   }
   
   private void addBillingInfoToSubscription(BasicXmlDocument document, ARBSubscription subscription, Element subscr_el){
      if(subscription.getBillTo() == null) return;
      ARBNameAndAddress bill_info = subscription.getBillTo();
      Element bill_el = document.createElement(ARBAPIRequests.ELEMENT_BILL_TO);
      
      Element fname_el = document.createElement(ARBAPIRequests.ELEMENT_FIRST_NAME);
      fname_el.appendChild(document.getDocument().createTextNode(bill_info.getFirstName()));
      bill_el.appendChild(fname_el);

      Element lname_el = document.createElement(ARBAPIRequests.ELEMENT_LAST_NAME);
      lname_el.appendChild(document.getDocument().createTextNode(bill_info.getLastName()));
      bill_el.appendChild(lname_el);
	  
	  if(bill_info.getCompany() != null){
        Element company_el = document.createElement(ARBAPIRequests.ELEMENT_COMPANY);
        company_el.appendChild(document.getDocument().createTextNode(bill_info.getCompany()));
        bill_el.appendChild(company_el);
      }
	  
	  if(bill_info.getAddress() != null){
        Element address_el = document.createElement(ARBAPIRequests.ELEMENT_ADDRESS);
        address_el.appendChild(document.getDocument().createTextNode(bill_info.getAddress()));
        bill_el.appendChild(address_el);
      }
	  
	  if(bill_info.getCity() != null){
        Element city_el = document.createElement(ARBAPIRequests.ELEMENT_CITY);
        city_el.appendChild(document.getDocument().createTextNode(bill_info.getCity()));
        bill_el.appendChild(city_el);
      }
	  
	  if(bill_info.getState() != null){
        Element state_el = document.createElement(ARBAPIRequests.ELEMENT_STATE);
        state_el.appendChild(document.getDocument().createTextNode(bill_info.getState()));
        bill_el.appendChild(state_el);
      }
	  
	  if(bill_info.getZip() != null){
        Element zip_el = document.createElement(ARBAPIRequests.ELEMENT_ZIP);
        zip_el.appendChild(document.getDocument().createTextNode(bill_info.getZip()));
        bill_el.appendChild(zip_el);
      }
	  
	  if(bill_info.getCountry() != null){
        Element country_el = document.createElement(ARBAPIRequests.ELEMENT_COUNTRY);
        country_el.appendChild(document.getDocument().createTextNode(bill_info.getCountry()));
        bill_el.appendChild(country_el);
      }
      
      subscr_el.appendChild(bill_el);
      
   }
   
   private void addShippingInfoToSubscription(BasicXmlDocument document, ARBSubscription subscription, Element subscr_el){
      if(subscription.getShipTo() == null) return;
      ARBNameAndAddress ship_info = subscription.getShipTo();
      Element ship_el = document.createElement(ARBAPIRequests.ELEMENT_SHIP_TO);

	  if(ship_info.getFirstName() != null){
        Element fname_el = document.createElement(ARBAPIRequests.ELEMENT_FIRST_NAME);
        fname_el.appendChild(document.getDocument().createTextNode(ship_info.getFirstName()));
        ship_el.appendChild(fname_el);
      }
	  
	  if(ship_info.getLastName() != null){
        Element lname_el = document.createElement(ARBAPIRequests.ELEMENT_LAST_NAME);
        lname_el.appendChild(document.getDocument().createTextNode(ship_info.getLastName()));
        ship_el.appendChild(lname_el);
      }
	  
	  if(ship_info.getCompany() != null){
        Element company_el = document.createElement(ARBAPIRequests.ELEMENT_COMPANY);
        company_el.appendChild(document.getDocument().createTextNode(ship_info.getCompany()));
        ship_el.appendChild(company_el);
      }
	  
	  if(ship_info.getAddress() != null){
        Element address_el = document.createElement(ARBAPIRequests.ELEMENT_ADDRESS);
        address_el.appendChild(document.getDocument().createTextNode(ship_info.getAddress()));
        ship_el.appendChild(address_el);
      }
	  
	  if(ship_info.getCity() != null){
        Element city_el = document.createElement(ARBAPIRequests.ELEMENT_CITY);
        city_el.appendChild(document.getDocument().createTextNode(ship_info.getCity()));
        ship_el.appendChild(city_el);
      }
	  
	  if(ship_info.getState() != null){
        Element state_el = document.createElement(ARBAPIRequests.ELEMENT_STATE);
        state_el.appendChild(document.getDocument().createTextNode(ship_info.getState()));
        ship_el.appendChild(state_el);
      }
	  
	  if(ship_info.getZip() != null){
        Element zip_el = document.createElement(ARBAPIRequests.ELEMENT_ZIP);
        zip_el.appendChild(document.getDocument().createTextNode(ship_info.getZip()));
        ship_el.appendChild(zip_el);
      }
	  
	  if(ship_info.getCountry() != null){
        Element country_el = document.createElement(ARBAPIRequests.ELEMENT_COUNTRY);
        country_el.appendChild(document.getDocument().createTextNode(ship_info.getCountry()));
        ship_el.appendChild(country_el);
      }
      
      subscr_el.appendChild(ship_el);
      
   }
      
   private void addPaymentScheduleToSubscription(BasicXmlDocument document, ARBSubscription subscription, Element subscr_el){
      ARBPaymentSchedule schedule = subscription.getSchedule();
      if(schedule == null) return;
      
      Element payment_el = document.createElement(ARBAPIRequests.ELEMENT_PAYMENT_SCHEDULE);
      
      // Add the interval
      //
      if(schedule.getIntervalLength() > 0){
         Element interval_el = document.createElement(ARBAPIRequests.ELEMENT_INTERVAL);
         Element length_el = document.createElement(ARBAPIRequests.ELEMENT_LENGTH);
         Element unit_el = document.createElement(ARBAPIRequests.ELEMENT_UNIT);
         length_el.appendChild(document.getDocument().createTextNode(Integer.toString(schedule.getIntervalLength())));
         interval_el.appendChild(length_el);
         interval_el.appendChild(unit_el);
         unit_el.appendChild(document.getDocument().createTextNode(schedule.getSubscriptionUnit()));
         
         payment_el.appendChild(interval_el);
      }
   
      Element start_date_el = document.createElement(ARBAPIRequests.ELEMENT_START_DATE);
      start_date_el.appendChild(document.getDocument().createTextNode(com.anet.api.util.DateUtil.getFormattedDate(schedule.getStartDate(),ARBPaymentSchedule.SCHEDULE_DATE_FORMAT)));
      payment_el.appendChild(start_date_el);
      
      Element total_el = document.createElement(ARBAPIRequests.ELEMENT_TOTAL_OCCURRENCES);
      total_el.appendChild(document.getDocument().createTextNode(Integer.toString(schedule.getTotalOccurrences())));
      payment_el.appendChild(total_el);
      
      Element trial_el = document.createElement(ARBAPIRequests.ELEMENT_TRIAL_OCCURRENCES);
      trial_el.appendChild(document.getDocument().createTextNode(Integer.toString(schedule.getTrialOccurrences())));
      payment_el.appendChild(trial_el);
      
      subscr_el.appendChild(payment_el);
   }
   
   private void addAuthenticationToRequest(BasicXmlDocument document){
      Element auth_el = document.createElement(ARBAPIRequests.ELEMENT_MERCHANT_AUTHENTICATION);
      Element name_el = document.createElement(ARBAPIRequests.ELEMENT_NAME);
      name_el.appendChild(document.getDocument().createTextNode(merchant_name));
      Element trans_key = document.createElement(ARBAPIRequests.ELEMENT_TRANSACTION_KEY);
      trans_key.appendChild(document.getDocument().createTextNode(transaction_key));
      auth_el.appendChild(name_el);
      auth_el.appendChild(trans_key);
      document.getDocumentElement().appendChild(auth_el);
   
   }
   public String createSubscriptionRequest(ARBSubscription subscription){
      
      clearRequest();
      
      BasicXmlDocument document = new BasicXmlDocument();
      document.parseString("<" + ARBAPIRequests.REQUEST_CREATE_SUBSCRIPTION + " xmlns = \"" + ARBAPIRequests.XML_NAMESPACE + "\" />");
      
      addAuthenticationToRequest(document);
      addSubscriptionToRequest(document,subscription);
      current_request = document;
      return result_code;
   }
   public String updateSubscriptionRequest(ARBSubscription subscription){
      
      clearRequest();
      
      BasicXmlDocument document = new BasicXmlDocument();
      document.parseString("<" + ARBAPIRequests.REQUEST_UPDATE_SUBSCRIPTION + " xmlns = \"" + ARBAPIRequests.XML_NAMESPACE + "\" />");
      
      addAuthenticationToRequest(document);
      addSubscriptionToRequest(document,subscription);
      current_request = document;
      
      return result_code;
   }
   public String cancelSubscriptionRequest(ARBSubscription subscription){

      clearRequest();
      
      BasicXmlDocument document = new BasicXmlDocument();
      document.parseString("<" + ARBAPIRequests.REQUEST_CANCEL_SUBSCRIPTION + " xmlns = \"" + ARBAPIRequests.XML_NAMESPACE + "\" />");
      
      addAuthenticationToRequest(document);
      addSubscriptionIdToRequest(document,subscription);
      current_request = document;
      
      return result_code;
   }
   public void clearRequest(){
      messages.clear();
      result_code = null;
      result_subscription_id = null;
      current_request = null;
      current_response = null;
   }
   public BasicXmlDocument sendRequest(){
      return sendRequest(current_request);
   }
   public BasicXmlDocument sendRequest(BasicXmlDocument request_document){
      BasicXmlDocument response = null;
      result_code = null;
      messages.clear();
      System.out.println (request_document.dump()); //eho
      String in_response = http_util.postUrl(request_document.dump());
      System.out.println(in_response);
      if(in_response == null) return null;
      
      int mark = in_response.indexOf("<?xml");
      if(mark == -1){
         System.out.println("Invalid response");
         System.out.println(in_response);
         return null;
      }
      response = new BasicXmlDocument();
      
      response.parseString(in_response.substring(mark,in_response.length()));
      // System.out.println("Response-XML::\n" + response.dump());
      if(response.IsAccessible() == false){
         System.out.println("Invalid response");
         System.out.println(in_response);
         return null;
      }
      
      /*
      try{
         FileOutputStream fos = new FileOutputStream("out.xml",true);
         fos.write(in_response.getBytes());
      }
      catch(Exception e){
         System.out.println(e);
      }
      */
      current_response = response;
      importResponseMessages();
      return response;
   }
   
   private String getElementText(Element parent_el, String element_name){
      String out_val = null;
      NodeList match_list = parent_el.getElementsByTagName(element_name);
      if(match_list.getLength() == 0) return out_val;
      Element match_el = (Element)match_list.item(0);
      if(match_el.hasChildNodes()){
         out_val = match_el.getFirstChild().getNodeValue();
      }
      return out_val;
   }

   
	public HashMap parseResponseMessages(String in_response) {
		HashMap map = new HashMap();
		
		int mark = in_response.indexOf("<?xml");
		if (mark == -1) {
			 map.put("result_code", "1000");
			 map.put("message", "Invalid XML Response");
			 return map;
		}
		BasicXmlDocument response = new BasicXmlDocument();

		response.parseString(in_response.substring(mark, in_response.length()));
		if (response.IsAccessible() == false) {
			 map.put("result_code", "1000");
			 map.put("message", "XML Response is not parsable");
			 return map;
		}

		NodeList messages_list = response.getDocument()
				.getElementsByTagName(ARBAPIRequests.ELEMENT_MESSAGES);
		if (messages_list.getLength() == 0)
		{
			 map.put("result_code", "1000");
			 map.put("message", "XML Response is missing required element");
			 return map;
		}

		Element messages_el = (Element) messages_list.item(0);

		map.put("result_code", getElementText(messages_el,
				ARBAPIRequests.ELEMENT_RESULT_CODE));
		map.put("result_subscription_id", 
				getElementText(response.getDocumentElement()
				, ARBAPIRequests.ELEMENT_SUBSCRIPTION_ID));

		NodeList message_list = messages_el
				.getElementsByTagName(ARBAPIRequests.ELEMENT_MESSAGE);
		for (int i = 0; i < message_list.getLength(); i++) {
			Element message_el = (Element) message_list.item(i);

			map.put(getElementText(message_el, ARBAPIRequests.ELEMENT_CODE),
					getElementText(message_el, ARBAPIRequests.ELEMENT_TEXT));
		}
		return map;

	}   
   
   
   private void importResponseMessages(){
      NodeList messages_list = current_response.getDocument().getElementsByTagName(ARBAPIRequests.ELEMENT_MESSAGES);
      if(messages_list.getLength() == 0) return;
      Element messages_el =(Element)messages_list.item(0);
      
      result_code = getElementText(messages_el,ARBAPIRequests.ELEMENT_RESULT_CODE);
      result_subscription_id = getElementText(current_response.getDocumentElement(),ARBAPIRequests.ELEMENT_SUBSCRIPTION_ID);
      
      NodeList message_list = messages_el.getElementsByTagName(ARBAPIRequests.ELEMENT_MESSAGE);
      for(int i = 0; i < message_list.getLength(); i++){
         Element message_el = (Element)message_list.item(i);
         Message new_message = new Message();
         new_message.setCode(getElementText(message_el,ARBAPIRequests.ELEMENT_CODE));
         //new_message.setResultCode(getElementText(message_el,ARBAPIRequests.ELEMENT_RESULT_CODE));
         new_message.setText(getElementText(message_el,ARBAPIRequests.ELEMENT_TEXT));
         this.messages.add(new_message);
      }
   }
   public void printMessages(){
      System.out.println("Result Code: " + (result_code != null ? result_code : "No result code"));
      if(result_subscription_id != null){
         System.out.println("Result Subscription Id: " + result_subscription_id);
      }
      for(int i = 0; i < messages.size(); i++){
         Message message = (Message)messages.get(i);
         System.out.println(message.getCode() + " - " + message.getText());
      }
   }
   
   
}
   
