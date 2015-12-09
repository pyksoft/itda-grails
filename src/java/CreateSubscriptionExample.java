// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


import com.anet.api.http.HttpUtil;
import com.anet.api.*;

public class CreateSubscriptionExample{
   
   public static void main(String args[]){
      
      if(args.length < 3){
         System.out.println("Authorize.Net ARB API Create Subscription Java Example");
         System.out.println("\tSyntax: CreateSubscriptionExample {api-url} {user-login} {transaction-key}");
         System.out.println("\tExample: CreateSubscriptionExample https://apitest.authorize.net/xml/v1/request.api YourUserLogin YourTranactionKey");
         System.exit(0);
      }

      java.net.URL url = null;
      try{
         if(args.length > 0) url = new java.net.URL(args[0]);
      }
      catch(java.net.MalformedURLException mue){
         System.out.println(mue);
      }
      if(url == null){
         System.out.println("Invalid url");
         System.exit(0);
      }
      
      // API constructor - url, merchant id, token key
      //
      ARBAPI api = new ARBAPI(url, args[1], args[2]);
      
   
      // Create a payment schedule
      //
      ARBPaymentSchedule new_schedule = new ARBPaymentSchedule();
      new_schedule.setIntervalLength(1);
      new_schedule.setSubscriptionUnit("months");
      new_schedule.setStartDate("2009-11-01");
      new_schedule.setTotalOccurrences(9999);
      new_schedule.setTrialOccurrences(0);
   
      // Create a new credit card
      //
      CreditCard credit_card = new CreditCard();
      credit_card.setCardNumber("4111111111111111");
      credit_card.setExpirationDate("2018-07");
	  
	  // Create a new bank account
      /*
	  BankAccount bank_account = new BankAccount();
	  bank_account.setAccountType("checking");  // checking, businessChecking, savings
	  bank_account.setRoutingNumber("052000113");
	  bank_account.setAccountNumber("1234567890");
	  bank_account.setNameOnAccount("John Doe");
	  bank_account.setEcheckType("WEB"); // PPD or WEB
	  bank_account.setBankName("First Bank"); // optional part of bank account
	  */
   
      // Create Order Details
      //
	  ARBOrder order = new ARBOrder();
	  order.setInvoiceNumber("1234567");
	  order.setDescription("Sample Description");
      	  
      // Create customer and specify billing info
      //
      ARBCustomer customer = new ARBCustomer();
      customer.setId("100");
	  customer.setEmail("nowhere@fakeEmail.com");
	  customer.setPhoneNumber("555-123-4567");
	  customer.setFaxNumber("555-345-6789");
   
      // Create bill-to address
      //
      ARBNameAndAddress billing_info = new ARBNameAndAddress();
      billing_info.setFirstName("John");
      billing_info.setLastName("Doe");
      billing_info.setCompany("Business Co.");
      billing_info.setAddress("1234 Street");
      billing_info.setCity("Bellevue");
      billing_info.setState("WA");
      billing_info.setZip("98004");
      billing_info.setCountry("US");
   
      // Create ship-to address
      ARBNameAndAddress shipping_info = new ARBNameAndAddress();
      shipping_info.setFirstName("Jane");
      shipping_info.setLastName("Doe");
      //shipping_info.setCompany("Business Co.");
      //shipping_info.setAddress("1234 Street");
      //shipping_info.setCity("Bellevue");
      //shipping_info.setState("WA");
      //shipping_info.setZip("98004");
      //shipping_info.setCountry("US");
	  
	  
      // Create a subscription and specify payment, schedule and customer
      //
      ARBSubscription new_subscription = new ARBSubscription();
      new_subscription.setPayment(new ARBPayment(credit_card));
	  // use the line above for credit card or the line beow for bank account
      // new_subscription.setPayment(new ARBPayment(bank_account));
      new_subscription.setSchedule(new_schedule);
      new_subscription.setBillTo(billing_info);
      new_subscription.setShipTo(shipping_info);
      new_subscription.setCustomer(customer);
      new_subscription.setOrder(order);
      new_subscription.setAmount(666.00);
      new_subscription.setTrialAmount(0.00);

      // Give this subscription a name
      //
      new_subscription.setName("Demo Subscription");
      
      // Create a new subscription request from the subscription object
      // Returns XML document. Also holds internal pointer as current_request.
      //
      api.createSubscriptionRequest(new_subscription);
	  // uncomment the following line to dump your XML request for debugging
      // System.out.println(api.getCurrentRequest().dump());
      api.sendRequest();
      
      api.printMessages();
      
      api.destroy();
      
   }
}
