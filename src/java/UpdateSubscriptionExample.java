// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.
//
// Copyright 2007 Authorize.Net Corp.


import com.anet.api.http.HttpUtil;
import com.anet.api.*;

public class UpdateSubscriptionExample{

   public static void main(String args[]){
      
      if(args.length < 4){
         System.out.println("Authorize.Net ARB API Update Subscription Java Example");
         System.out.println("\tSyntax: CreateSubscriptionExample {api-url} {user-login} {transaction-key} {subscription-id}");
         System.out.println("\tExample: CreateSubscriptionExample https://apitest.authorize.net/xml/v1/request.api YourUserLogin YourTranactionKey 5555");
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
      
   
      // Create a new credit card
      //
      CreditCard credit_card = new CreditCard();
      credit_card.setCardNumber("4111111111111111");
      credit_card.setExpirationDate("2008-08");
   
      // Create a subscription and specify payment, schedule and customer
      //
      ARBSubscription update_subscription = new ARBSubscription();
      update_subscription.setPayment(new ARBPayment(credit_card));
      update_subscription.setSubscriptionId(args[3]);
      
      //new_subscription.setAmount(5.00);
      //new_subscription.setTrialAmount(0.00);

      
      // Create a new subscription request from the subscription object
      // Returns XML document. Also holds internal pointer as current_request.
      //
      api.updateSubscriptionRequest(update_subscription);
      // System.out.println(api.getCurrentRequest().dump());
      api.sendRequest();
      
      api.printMessages();
      
      
      
      api.destroy();

   }
}
