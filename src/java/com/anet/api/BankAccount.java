// Before working with this sample code, please be sure to read the accompanying Readme.txt file.
// It contains important information regarding the appropriate use of and conditions for this
// sample code. Also, please pay particular attention to the comments included in each individual
// code file, as they will assist you in the unique and correct implementation of this code on
// your specific platform.


package com.anet.api;

public class BankAccount{

    private String account_type;      // One of "checking", "savings", or "businessChecking"
    private String routing_number;    // Number must be 9 digits
    private String account_number;    // Number should be 5 to 17 digits
    private String name_on_account;
    private String echeck_type;       // One of "PPD", "WEB", "CCD", or "TEL"
    private String bank_name;
   
   
   public BankAccount(){
      
   }


   public String getAccountNumber() {
      return account_number;
   }


   public void setAccountNumber(String account_number) {
      this.account_number = account_number;
   }


   public String getAccountType() {
      return account_type;
   }


   public void setAccountType(String account_type) {
      this.account_type = account_type;
   }


   public String getBankName() {
      return bank_name;
   }


   public void setBankName(String bank_name) {
      this.bank_name = bank_name;
   }


   public String getEcheckType() {
      return echeck_type;
   }


   public void setEcheckType(String echeck_type) {
      this.echeck_type = echeck_type;
   }


   public String getNameOnAccount() {
      return name_on_account;
   }


   public void setNameOnAccount(String name_on_account) {
      this.name_on_account = name_on_account;
   }


   public String getRoutingNumber() {
      return routing_number;
   }


   public void setRoutingNumber(String routing_number) {
      this.routing_number = routing_number;
   }
}
