// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.
//
// Copyright 2007 Authorize.Net Corp.


import com.anet.api.http.HttpUtil;
import com.anet.api.*;

public class CancelSubscriptionExample{
   
   public static void main(String args[]){
      
      if(args.length < 4){
         System.out.println("Authorize.Net ARB API Cancel Subscription Java Example");
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

      // Create a subscription and specify subscription id
      //
      ARBSubscription cancel_subscription = new ARBSubscription();
      cancel_subscription.setSubscriptionId(args[3]);

      // Create a new subscription request from the subscription object
      // Returns XML document. Also holds internal pointer as current_request.
      //
      api.cancelSubscriptionRequest(cancel_subscription);
      api.sendRequest();
      api.printMessages();

      api.destroy();
   }
}
